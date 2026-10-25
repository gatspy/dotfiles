# Kanata 键位方案（Windows 主用，macOS 预备）

Windows 下的键位重映射：**Win 键 = Cmd 键**，肌肉记忆与 macOS 完全一致，内核级拦截杜绝 PowerToys 的"按键失效"问题。

> 架构分工：**Windows 用 Kanata（已启用），macOS 暂保持 Karabiner 现状**（mac.kbd 等文件已备好并验证，Windows 稳定后随时切换，见下方 macOS 章节）。两平台键位规则相同（Caps=Esc/Ctrl、右侧 Hyper、右 Shift+WASD 方向）。

## ⌨️ 键位表

### 底排

| 物理键 | 行为 |
| :--- | :--- |
| **Caps** | 单击 = Esc，按住 = Ctrl |
| 左 Ctrl | **禁用**（物理坏键，事件全吞；换键盘后删除配置中 `XX` 一格即恢复） |
| 左 Win | 按住 = **主修饰层**（输出 Ctrl，等价 macOS 的 Cmd） |
| 左 Alt | 保留原生（Alt+Tab） |
| 右 Win | 按住 = **Hyper 层**（对应 macOS 右 Cmd → Hyper 习惯） |
| 右 Shift | 按住 = **导航层**（大写/选文本用左 Shift） |
| Win+Tab | 任务切换（Alt+Tab，等价 Cmd+Tab） |

### 主修饰层（按住左 Win）

- 任意字母 / 数字 / 符号 → Ctrl + 该键：`Win+C` = 复制、`Win+V` = 粘贴、`Win+S` = 保存……
- 原生 Win 系快捷键（Win+D/E/S…）整体退役，高频功能已在 Hyper 层重建

### 导航层（按住右 Shift）

- `W A S D` → ↑ ← ↓ →，`H J K L` → ← ↓ ↑ →

### Hyper 层（按住右 Win）

| 键 | 动作 | 输出 |
| :--- | :--- | :--- |
| B | Chrome | `start chrome` |
| C | 微信 | `start weixin` |
| E | Zed | `start zed` |
| F | 资源管理器 | `start explorer` |
| G | 待定 | 未绑定 |
| M | 待定 | 未绑定 |
| T | Windows Terminal | `start wt` |
| V | VSCode | `start code` |
| Q | 任务管理器 | Ctrl+Shift+Esc |
| S | 搜索 | Win+S |
| D | 显示桌面 | Win+D |
| L | 锁屏 | Win+L |
| A | 截图 | Win+Shift+S |
| Caps | 大写锁切换 | CapsLock |

## 📁 目录结构

```text
kanata/
├── win.kbd               # Windows 入口（已启用）
├── mac.kbd               # macOS 入口（预备，未启用，配置已验证）
├── shared-layers.kbd     # 两平台共享的四层逻辑（base / cmd / nav / hyper）
├── kanata.ps1            # Windows 管理脚本（装机用，日常不碰）
├── com.gatspy.kanata.plist  # macOS launchd 自启（切换时启用）
└── README.md
```

## 🚀 Windows 部署（总共两条命令）

前置：本目录同步到 `%USERPROFILE%\.config\kanata\`（`win.kbd` + `shared-layers.kbd`）。

```powershell
cd ~\.config\kanata

# ① 安装：自动下载官方包 → 挑对托盘版二进制装入 D:\Program\Kanata → 自动校验配置
.\kanata.ps1 install -Phase 1

# ② 注册开机自启（登录时运行、最高权限，非管理员会自动弹 UAC）
.\kanata.ps1 task
```

完成。**日常使用 = 任务栏托盘里的 kanata 图标**，没有任何东西需要你操作。

### 日常管理（偶发需求才用）

```powershell
.\kanata.ps1 status     # 运行状态 + 任务状态
.\kanata.ps1 restart    # 改了 win.kbd 之后重启生效
.\kanata.ps1 stop
```

### 路径规则

```text
-InstallDir 参数  >  ~\.config\kanata\install-dir.txt（install 时自动记忆）  >  默认 D:\Program\Kanata
```

## 🛡️ Phase 2：内核稳定模式（强烈建议尽快切换）

Phase 1 走 LLHOOK 路径，有两个固有约束：v1.12.0 的状态同步回归（[#2115](https://github.com/jtroo/kanata/issues/2115)，所以 Phase 1 固定 1.11.0）、以及系统级 UI（Alt+Tab 切换器等）的时序冲突。**Phase 2 的 wintercept 构建走完全不同的代码路径，两者皆免疫，且可安心用最新版 1.12.0**。

内核驱动用 **OpenInputBridge（OIB）**——Interception 的开源重写（Interception 已停更约 9 年），为 Windows 11 设计、WHQL 微软签名、活跃维护，kanata 官方变体实测兼容：

1. 从 [OIB 仓库](https://github.com/Applet-LLC/OpenInputBridge)获取发布 zip，解压到**本地固定路径**（勿放 OneDrive 同步目录）
2. 管理员运行 `setup.bat`（自动装 oib_kbd / oib_mou 两个驱动）→ **重启**
3. 验证：`sc query OpenInputBridgeKeyboard` 显示 RUNNING
4. 把 zip 里 `redist\x64\interception.dll` 一并复制到 kanata 目录，然后切换：

```powershell
.\kanata.ps1 stop
.\kanata.ps1 install -Phase 2 -OibDll "<OIB解压路径>\redist\x64\interception.dll"
.\kanata.ps1 task
```

⚠️ 切 Phase 2 前，**彻底退出 PowerToys 等一切旧键盘工具**——两个键盘钩子叠加会互相污染状态。
⚠️ OIB 仅支持 Windows 11；获取 zip 有困难时的兜底：老 Interception 驱动（`commandline\install.exe`）仍可用，只是不再维护。

## 🍎 macOS 切换（暂缓，Windows 稳定后执行）

配置已就绪且验证通过（`mac.kbd` 键码与 `win.kbd` 完全一致，Hyper 层应用名已按本机 /Applications 校对）。切换步骤：

```bash
# 1. 装 Kanata 二进制（cmd_allowed 构建，应用启动依赖）
curl -sL -o /tmp/k.zip https://github.com/jtroo/kanata/releases/download/v1.11.0/macos-binaries-x64.zip
unzip -o /tmp/k.zip kanata_macos_cmd_allowed_x64 -d /tmp && chmod +x /tmp/kanata_macos_cmd_allowed_x64
mv /tmp/kanata_macos_cmd_allowed_x64 /usr/local/bin/kanata

# 2. 前台试跑（首次触发授权：系统设置 → 隐私与安全性 → 输入监控 → 放行 /usr/local/bin/kanata）
kanata --cfg ~/.dotfiles/kanata/mac.kbd

# 3. 验证无误后切换：停 Karabiner 抓取 → 立即启用 launchd（顺序勿反）
sudo launchctl bootout system/org.pqrs.service.user.karabiner_grabber
launchctl bootout gui/$UID/org.pqrs.service.user.karabiner_grabber_user
cp ~/.dotfiles/kanata/com.gatspy.kanata.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.gatspy.kanata.plist
```

⚠️ 切换瞬间有 1–2 秒坏键防护空窗；若之后 Ctrl 粘滞，按几下**右 Ctrl** 即清零。
⚠️ Karabiner 大版本升级可能变更驱动接口，升级前查 [Kanata issues](https://github.com/jtroo/kanata/issues)。
Hyper 层的 ` 重载键输出旧 Hammerspoon 热键（⇧⌃⌥⌘+`），切换后 Hammerspoon 无需任何改动。

## 🔧 故障排查

| 症状 | 原因与处理 |
| :--- | :--- |
| `cannot be loaded... not digitally signed` | 执行策略拦截。一次性放行：`Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`；网盘拷贝的文件还需 `Unblock-File .\kanata.ps1` |
| `cmd is not enabled` / `never allow cmd` | 用了无 cmd 的二进制，重跑 `.\kanata.ps1 install`（自动选 cmd_allowed 托盘版） |
| 打字时报 `Unexpected keycode ... Clearing kanata states`、键位乱组合 | **v1.12.0 LLHOOK 回归 bug**（[issue #2115](https://github.com/jtroo/kanata/issues/2115)），脚本已固定 1.11.0；若手动升级踩到，降回即可 |
| 覆盖二进制报"文件被占用" | kanata 在跑，先 `.\kanata.ps1 stop` |
| 托盘图标不在 | `.\kanata.ps1 status` 看进程与任务状态 |
| UAC 弹窗内键位失效 | Phase 1 固有限制，切 Phase 2 |
| 应用启动器无反应 | 手动逐个跑 `start chrome / weixin / zed / code / wt`，对不上的改 `win.kbd` 别名 |
| 按键突然全失效 | 若还在用 PowerToys/scoop 旧方案则属预期 bug；切本方案后不应复现，复现即报 issue |

## 📌 待办

- [ ] Hyper 层 G（邮件）、M（Markdown）两键待指定应用后补绑定
- [ ] `start chrome / weixin / zed / code / wt` 按实际安装情况核对
- [ ] 使用一周后评估是否切 Phase 2
