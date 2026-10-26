# iTerm2 崩溃/损坏排障手册（Playbook）

> 2026-10-26 五层病灶实战沉淀 · 适用 iTerm2 3.7.x on macOS 15+
> 铁律：动手前必备份；修复后必验证；验证必须触发崩溃路径本身

## 症状 → 章节索引

| 症状 | 直接跳转 |
|---|---|
| "Master profile 被损坏"弹窗 | [L1 控制字符](#l1-隐形控制字符) |
| 一打开就崩，反复崩 | [L2 残留进程](#l2-异常退出残留) + [L4 类型雷](#l4-36--37-类型迁移雷) |
| 能开但窗口看不见 | [L5 屏外窗口缓存](#l5-屏外窗口缓存) |
| 正常用着，开 Settings/Toolbelt 才崩 | [L4 类型雷](#l4-36--37-类型迁移雷) |
| 会话建不出来 / shell 秒退 | [L3 死命令](#l3-profile-内嵌死命令) |

## 五层病灶速查

### L1 隐形控制字符
二进制 plist 不做 XML 转义，`plutil -lint` 通过 ≠ 干净。任何 XML 序列化路径
（defaults export、app 内编辑器）遇到 C0 控制字符即炸。本案实锤：Master profile
的 `HotKey Characters` 含 `\x10`（3.6.10 合法、3.7 崩溃源）。

### L2 异常退出残留
三类孤儿，互相成就死循环：
- `~/Library/Application Support/iTerm2/private/socket.lock`（死锁 → "Another instance"）
- `~/Library/Application Support/iTerm2/iterm2-daemon-N.socket*`（孤儿 daemon socket，正常会随版本累加无害）
- **孤儿 `iTermServer-<ver>` 进程**（最险）：GUI 崩了 server 活着 → 下次启动走
  `orphanServerAdopter` 收养路径 → 重建窗口+toolbelt → 碰毒即崩 → 又留孤儿。

### L3 profile 内嵌死命令
profile 的 `Command` 指向已卸载的二进制（本案：brew zsh 退役后残留
`login -pfq Gatspy /usr/local/bin/zsh`）→ 会话创建全挂。卸载系统级工具前先
grep GUI 偏好域引用。

### L4 3.6 → 3.7 类型迁移雷
同一个键，类型改朝换代。`+[ProfileModel doesProfile:matchFilter:]` 对
`Custom Command` 发 `isEqualToString:`，收到 NSNumber 即
`doesNotRecognizeSelector` → SIGSEGV：

| 键 | 3.6 类型 | 3.7 合法值 |
|---|---|---|
| `Custom Command` | bool | str 枚举：`'No'` / `'Yes'`（出厂值照抄 Default profile） |
| `Prompt Before Closing 2` | int | bool |
| 热键窗 `HotKey Characters` / `HotKey Characters Ignoring Modifiers` / `Alternate Shortcuts` | str（含显示字符） | **导入时整体剥掉**，真热键由 `HotKey Key Code` + `HotKey Modifier Flags` 定义 |

### L5 屏外窗口缓存
`NoSyncSavedWindowPositions`（y=999 屏外坐标）与 `NSWindow Frame iTerm Profile*`
缓存陈旧 → 进程活着窗口看不见。删这两类键 + `killall cfprefsd`。

## 标准诊断流程（按序执行）

```bash
# ① 读最新崩溃报告：异常类型 + 崩溃帧
d="$HOME/Library/Logs/DiagnosticReports"
f=$(cd "$d" && /bin/ls -t | grep '^iTerm' | head -1)
tail -n +2 "$d/$f" | jq -c '{exception, termination}'
tail -n +2 "$d/$f" | jq -r '. as $r | .threads[$r.faultingThread].frames[:14][] |
  "\($r.usedImages[.imageIndex].name)  \(.symbolWithSignature // .symbol // .imageOffset)"'

# ② 进程清点：有无孤儿
pgrep -lf iTerm          # iTermServer 孤儿？login 会话？
ps -o pid,ppid,lstart,stat,command -p <pid>   # 孤儿起止时间、子进程有无活作业

# ③ 控制字符全域扫描
python3 -I - <<'PY'
import plistlib, subprocess, re
p = plistlib.loads(subprocess.run(
    ["defaults","export","com.googlecode.iterm2","-"],
    capture_output=True).stdout)
bad = re.compile(r"[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]")
def walk(o, path):
    if isinstance(o, str) and bad.search(o): print("POISON:", path, repr(o))
    elif isinstance(o, dict):
        for k, v in o.items(): walk(v, f"{path}/{k}")
    elif isinstance(o, list):
        for i, v in enumerate(o): walk(v, f"{path}[{i}]")
walk(p, "$")
PY

# ④ 类型审计：与出厂 Default profile 逐键比对类型
python3 -I - <<'PY'
import plistlib, subprocess
p = plistlib.loads(subprocess.run(
    ["defaults","export","com.googlecode.iterm2","-"],
    capture_output=True).stdout)
bms = p["New Bookmarks"]
ref = {k: type(v) for k, v in next(
    b for b in bms if b["Name"] == "Default").items()}
for b in bms:
    diffs = [(k, type(b[k]).__name__, ref[k].__name__)
             for k in b if k in ref and type(b[k]) is not ref[k]]
    if diffs: print(b["Name"], diffs)
PY
```

**崩溃帧翻译表**：

| 崩溃帧 | 含义 |
|---|---|
| `doesNotRecognizeSelector:` → `___forwarding___` | 配置值类型错（查 L4） |
| 入口 `orphanServerAdopter...` | 有孤儿 server（查 L2），毒值在收养路径暴露 |
| `ProfileListView` / `ToolProfiles` / `iTermToolbeltView` | profile 值有毒，Profile 列表构建时炸 |
| `NSPersistentUIRestorer` | 窗口状态残留（查 L5 / savedState） |

**源码比对**：iTerm2 开源，崩溃帧里的 iTerm2 符号直接拉源码看它读哪些键、期望什么类型：

```bash
curl -sL "https://raw.githubusercontent.com/gnachman/iTerm2/master/sources/Settings/Profiles/ProfileModel.m" -o /tmp/ProfileModel.m
```

（3.7 路径在 `sources/Settings/Profiles/`；文件路径不确定时用 GitHub trees API 搜文件名。）

## 修复手册

**备份纪律**：每次动手前 `cp -p` 到 `/tmp` 带日期后缀；优先 `mv` 隔离而非 rm（可逆）。

```bash
# L1/L4 修复：直接改 plist → flush cfprefsd → 验证 export 可解析
cp -p ~/Library/Preferences/com.googlecode.iterm2.plist /tmp/iterm2.plist.bak-$(date +%Y%m%d-%H%M)
python3 -I - <<'PY'
import plistlib
path = "/Users/$USER/Library/Preferences/com.googlecode.iterm2.plist"  # fix $USER
with open(path, "rb") as fh: p = plistlib.loads(fh.read())
for b in p["New Bookmarks"]:
    cc = b.get("Custom Command")
    if not isinstance(cc, str): b["Custom Command"] = "No"
    pv = b.get("Prompt Before Closing 2")
    if not isinstance(pv, bool): b["Prompt Before Closing 2"] = bool(pv)
with open(path, "wb") as fh: plistlib.dump(p, fh, fmt=plistlib.FMT_BINARY)
PY
killall cfprefsd

# L2 修复：孤儿清剿（先验子进程无活作业 → kill → 隔离 socket）
pgrep -P <server_pid> | xargs -I{} ps -o pid,stat,time,command -p {}
kill <server_pid>
mkdir -p /tmp/iterm2-socket-quarantine
mv "$HOME/Library/Application Support/iTerm2/"iterm2-daemon-*.socket* /tmp/iterm2-socket-quarantine/ 2>/dev/null
mv "$HOME/Library/Application Support/iTerm2/private/socket"* /tmp/iterm2-socket-quarantine/ 2>/dev/null

# L3 修复：Custom Command 改 'No'（用登录 shell），或更新 Command 为存活路径

# L5 修复：defaults delete com.googlecode.iterm2 NoSyncSavedWindowPositions
#          再删 NSWindow Frame iTerm* 各键，killall cfprefsd

# 终极方案（以上皆失败）：mv 隔离整个域 → 出厂态验证 → 类型校验的器官级移植
mv ~/Library/Preferences/com.googlecode.iterm2.plist{,.quarantine-$(date +%Y%m%d)}
killall cfprefsd
```

## 验证闭环（监测盲区警告）

直启二进制的存活监测**测不出** ProfileListView/Toolbelt 类毒——正常路径不构建它们。
完整验证 = ① + ② + ③：

```bash
# ① 直启 90 秒 + stderr 捕获
/Applications/iTerm.app/Contents/MacOS/iTerm2 2>/tmp/iterm-stderr.log &
sleep 90; pgrep -x iTerm2 && echo ALIVE
cat /tmp/iterm-stderr.log   # 空 = 无错误

# ② 主动跑通崩溃全链（建会话 → refreshTools → Toolbelt 构建）
osascript -e 'tell application "iTerm" to create window with default profile'
sleep 30; pgrep -x iTerm2 && echo "全链存活"

# ③ 崩溃报告零新增
ls "$HOME/Library/Logs/DiagnosticReports" | grep -c iTerm
```

人工验收三连：Dock 启动出窗 → **⌘,** 开 Settings→Profiles（在崩溃点上跳舞）→ ⌘⌥P 悬浮窗。

## 本案历史档案（2026-10-26）

| 备份 | 内容 |
|---|---|
| `/tmp/iterm2.plist.bak-20261026` | 最早原始域 |
| `/tmp/iterm2-chatdb.bak` | AI 聊天库 |
| `/tmp/iterm2.plist.pre-arrangement-fix.plist` | 窗口修复前 |
| `/tmp/iterm2.plist.pre-typebomb-fix-20261026b` | 类型雷拆除前 |
| `~/Library/Preferences/com.googlecode.iterm2.plist.quarantine` | 整域隔离（含旧 Master 全量） |
| `/tmp/iterm2-socket-quarantine/` | 14 个 socket/锁残留 |

修复层级链：L1 控制字符 → L2 socket 死锁 → L3 死命令 → 整域隔离重建 → L4 类型雷 → L2' 孤儿 server 死循环。用户 3.6.10 全量导出（`~/Downloads/234/iterm2_config.txt`）为 profile 家族（Default/Master/Big Window/light-theme/Master Float）之源。
