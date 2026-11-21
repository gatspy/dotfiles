# Windows 配置手册（PowerShell / WT / Scoop / mise）

> 2026-11-21 定稿 · 原则：**Windows 侧配置全部入仓，PowerShell 引导器建链，工具域 mise 单源**

## 机器画像（2026-11-21 实测）

| 项 | 值 |
|---|---|
| PowerShell | 7.6.10（`C:\Program Files\PowerShell\7`），机器级策略 RemoteSigned |
| $PROFILE | `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`（bootstrap 引导器，点加载 `.config\powershell\user_profile.ps1` + modules） |
| mise 本体 | `D:\Program\Develop\mise\bin\mise.exe`（自定义安装目录，**非** scoop / 非 %LOCALAPPDATA%）；shims 在 `D:\Program\Develop\mise\shims` |
| scoop 根 | `D:\Program\Scoop\main`（`scoop config root_path`） |
| WT | UWP 打包版，settings.json 在 `…\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState` |

## 仓库承载与链接映射（bootstrap.ps1 建链）

| 仓库文件 | live 位置 | 方式 |
|---|---|---|
| `config/powershell/`（bootstrap + user_profile + modules/6 件） | `~\.config\powershell` | **junction** |
| `config/powershell/Microsoft.PowerShell_profile.ps1` | `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1` | symlink |
| `config/mise/config.toml.symlink`（三端同源） | `~\.config\mise\config.toml` | symlink |
| `config/windows-terminal/settings.json` | WT LocalState\settings.json | symlink |
| `config/starship.windows.toml`（Emoji 极简风） | `~\.config\starship.toml` | symlink |
| `git/gitconfig.windows.symlink`（BC5/autocrlf=true/GCM） | `~\.gitconfig` | symlink |
| `git/gitmessage.symlink` | `~\.gitmessage` | symlink |
| `config/git/ignore.symlink`（修正反斜杠 bug） | `~\.config\git\ignore` | symlink |
| `config/scoop/scoopfile.json` | `~\.config\scoop\scoopfile.json` | symlink（2026-11-21 已导出建链） |

纪律：`~\.gitconfig.local`（公司 CA 等）不入仓，靠 gitconfig 的 `[include]` 链生效；profile 内 `reload` 后的改动会写穿回仓库，`git status` 直接可见。

## 新机/重装流程（按序）

1. **底座**：装 pwsh 7 → scoop（含 `git` `pwsh` `scoop-completion` `aria2`）→ mise 本体（官方脚本，装到自定义目录或默认 `%LOCALAPPDATA%\mise`，记录进本表）→ `gh auth login`
2. **取仓**：`git clone git@github.com:gatspy/dotfiles.git ~\.dotfiles`
3. **建链**：`pwsh -File ~\.dotfiles\script\bootstrap.ps1`（幂等，实体文件自动改名备份）
4. **装工具**：`mise install`（三端同一份 config.toml，Windows 实装 83 项；含 ffmpeg os=["windows"]）
5. **PATH 双轨**：`pwsh -File ~\.dotfiles\script\bootstrap.ps1 -FixPath`（mise shims 前置用户 PATH + 去重；第一轨管 IDE/GUI/CMD，$PROFILE 的 `mise activate pwsh` 是第二轨管交互终端）
6. **一次性动作**（见下节）
7. **可选 kanata**：`pwsh -File ~\.dotfiles\script\bootstrap.ps1 -Kanata`（junction `~\.config\kanata` → 仓库 kanata/，二进制安装用 `kanata.ps1`）

## 一次性动作清单

```powershell
# ① Defender 排除（管理员）——编译器/包管理器高频小文件 I/O 的性能杀手位
Add-MpPreference -ExclusionPath @(
  "$env:LOCALAPPDATA\mise", "D:\Program\Develop\mise",
  "$env:USERPROFILE\.cargo", "$env:USERPROFILE\.rustup", "D:\Program\Scoop\main"
)

# ② Go 代理刻入全局（mise [env] 的 GOPROXY 在 go:* 解析期尚未注入）
go env -w GOPROXY=https://goproxy.cn,direct

# ③ Scoop 卸载已由 mise/starship/kanata 接管的 CLI（消双装，PATH 恒 mise 优先）
# 2026-11-21 实测：以下 26 项已卸；ffmpeg/temurin21-jdk 当时已不在 scoop（无需处理）
scoop uninstall bat cmake croc delta duckdb dust eza fd fzf gh jq lsd maven `
  oh-my-posh pixi powertoys procs protobuf ripgrep starship tokei `
  trippy vfox vivid zola zoxide
scoop cleanup *; scoop cache rm *

# ④ mise Roaming 残留（存在才删；2026-11-21 实测本机无残留）
Remove-Item -Recurse -Force "$env:APPDATA\mise"

# ⑤ 工具收敛（2026-11-21 实测：83/83 已装，prune 清掉 8 个旧 fork 孤儿）
mise reshim --force; mise prune -y
```

保留在 Scoop 的：`git mingw msys2 make openssl wixtoolset 7zip nanazip bandizip peazip lz4 zstd less sudo nmap frp mole scoop-completion aria2` + 全部 GUI 应用 + 字体（Hack-NF-Mono / Maple-Mono，与 mac Brewfile 字体 cask 同名对齐）。同名陷阱：scoop 的 `mole` 是 SSH 隧道，brew 的 `mole` 是清理工具，各自留原地不进 mise。

## 验收（最小环境，不信继承）

```powershell
# 工具归属：全部应指向 mise 安装目录，而非 scoop shims
gcm java, cmake, rg, fd, jq, delta, starship, ffmpeg | Select-Object Name, Source
mise doctor          # 无红字
mise outdated        # 干净输出
pwsh -NoProfile -Command "$PROFILE"   # 确认入口路径
reload               # profile 幂等重载，0 报错
git config --global --list   # 出自链接文件
```

## 已排障实录

- **FixPath 裸盘符事故**（2026-11-21 修复）：`@(...)|Where-Object` 管道单元素输出退化为标量字符串，`$candidates[0]` 取到首字符 `'D'` 被写进 PATH → 改 `@($candidates)[0]` 并顺带清理裸盘符条目。教训：PS 管道单元素必退化，取下标前先 @() 包层。
- **scoop-completion 静默失效**（2026-11-21 修复）：旧 bootstrap 写死 `USERPROFILE\scoop` 与 `H:\scoop` 两个路径，本机根在 `D:\Program\Scoop\main`，两路全空 → 改为按 PSModulePath 按名导入。
- **`~\.config\git\ignore` 反斜杠 bug**（2026-11-21 修复）：`**/.claude\settings.local.json` 中 `\s` 是转义，实际匹配 `.claudesettings.local.json`，形同虚设 → 入仓改正斜杠并建链。
- **mise 配置分叉**（2026-11-21 收敛）：Windows 曾有一份 68 行独立 fork（java 23/flutter 3.38.10/阿里源），与三端正典漂移 → 废弃（bootstrap-bak 留档），统一链接仓库版。
