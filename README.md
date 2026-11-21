# Modern Dotfiles

三端（macOS Intel / macOS Silicon / Windows x64）模块化 dotfiles。macOS 与 MSYS2 侧走 zsh（topic 化 + 懒加载），Windows 侧走 PowerShell（Cosmic 引导器）；语言运行时与 CLI 由 mise 单源管理，GUI/字体归平台原生包管理器。

## 三端包管理编排（2026-11-21 定稿）

| 管理器 | 职责 | 清单正典 |
|---|---|---|
| **mise** | 一切跨平台运行时 + 纯二进制 CLI（三端同一份 config，`os` 过滤分流） | `config/mise/config.toml.symlink` |
| **Homebrew** | macOS 专属：GUI cask、字体、C/C++ 动态库、系统组件 | `homebrew/Brewfile.casks`（M6 白名单单正典；MBP 2019 存量维保禁裸 bundle） |
| **Scoop** | Windows 专属：GUI、字体、系统编译底座（git/mingw/msys2） | `config/scoop/scoopfile.json` |

同名异物各自留原生管理器（mac 的 mole=清理工具 / win 的 mole=SSH 隧道）。优先级：mac 端 mise shims 恒压 brew；Windows 双轨——`mise shims` 前置用户 PATH（管 IDE/GUI）+ `$PROFILE` 内 `mise activate pwsh`（管交互终端）。

## 快速开始

### macOS / Linux（zsh）

```bash
git clone git@github.com:gatspy/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && script/bootstrap   # 建链（*.symlink → $HOME，config/*.symlink → ~/.config）
exec zsh
```

- 语言工具：`mise install`（macOS 实装 88 项，os 过滤自动适配 Intel/Silicon）
- macOS GUI：M6 用 `brew bundle --file=homebrew/Brewfile.casks`；MBP 存量维保禁裸 bundle
- 私有配置：`~/.zsh.localrc`（bootstrap 自动软链到 `zsh/zshrc.local`，该文件已入 git 随 clone 走）

### Windows（PowerShell 7）

```powershell
git clone git@github.com:gatspy/dotfiles.git ~\.dotfiles
pwsh -File ~\.dotfiles\script\bootstrap.ps1           # junction + symlink 幂等建链
pwsh -File ~\.dotfiles\script\bootstrap.ps1 -FixPath  # mise shims 前置 + 用户 PATH 去重
mise install                                          # Windows 实装 83 项
```

详见 [docs/windows-setup.md](docs/windows-setup.md)。

## 目录速览

| 目录 | 内容 |
|---|---|
| `system/` | zsh 核心（PATH / env / aliases / history / keys / platform 检测） |
| `zsh/` | zshrc 入口、补全、vi 模式、私有 zshrc.local |
| `config/` | 外部工具：mise / sheldon / starship（mac+win 双版）/ zed / powershell / windows-terminal / scoop / git |
| `git/` | gitconfig（mac + win 双版）、gitignore、gitmessage |
| `ai/` | AI 服务集成（sbx Docker 沙箱工作流、versor） |
| `mise/` | mise shell 集成 + GITHUB_TOKEN 注入 |
| `hammerspoon/` `karabiner/` `iterm/` `capslox/` | macOS 自动化 / 键位 / iTerm2 / Capslox keymap |
| `homebrew/` | Brewfile.casks 单正典 + brew wrapper 函数 |
| `k8s/` `python/` `golang/` `rust/` `dart/` `flutter/` `web/` `xcode/` | 语言与栈 topic（按白名单/条件加载） |
| `functions/` `completions/` | zsh 函数与补全（大补全懒加载） |
| `script/` | bootstrap（bash 版 + PowerShell 版）、install、lib.sh |
| `archive/` | 化石与历史文档（不加载、不部署） |
| `tmux/` | git 子模块（gpakosz/.tmux 定制） |

## zsh 加载顺序

`*/path.zsh` → compinit（智能缓存）→ sheldon（defer 插件）→ starship → zoxide → 各 topic `*.zsh`（always_load + 条件加载）→ `*/completion.zsh` → `~/.zsh.localrc` → `mise activate zsh --shims`

## 纪律（三机三界皆准）

1. 未提交 = 未存在
2. 文件在仓库 ≠ 在机器生效（bootstrap 跑过才算部署）
3. 验证必须用 `env -i` 最小环境
4. mise 声明的工具必须已装或删行（悬空条目拖慢每次 hook-env）

## 文档索引

| 文档 | 内容 |
|---|---|
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | 架构 3.1：加载策略 / 性能 / 维护 |
| [docs/new-mac-setup.md](docs/new-mac-setup.md) | 双机（MBP + M6）初始化 runbook |
| [docs/windows-setup.md](docs/windows-setup.md) | Windows runbook（PowerShell / WT / scoop / mise） |
| [docs/symlinks.md](docs/symlinks.md) | 链接清单与冲突处理 |
| [docs/special-configs.md](docs/special-configs.md) | zshrc.local / karabiner 说明 |
| [docs/iterm2-crash-playbook.md](docs/iterm2-crash-playbook.md) | iTerm2 五层病灶排障手册 |
| [docs/performance-baseline.md](docs/performance-baseline.md) | 0.50s 启动基准 |
| [docs/security/api-keys.md](docs/security/api-keys.md) | API 密钥管理 |
| [homebrew/OPTIMIZATION_REPORT_2026.md](homebrew/OPTIMIZATION_REPORT_2026.md) | brew 大清理复盘（2026-04） |

基于 [holman/dotfiles](https://github.com/holman/dotfiles) 的主题化架构理念。MIT License。
