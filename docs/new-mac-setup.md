# 双机配置手册：MBP 2019 (Intel) + Mac mini M6

> 2026-10-25 定稿 · 架构原则：**同一仓库，架构自适应，双机日常并行**

## 机器分工

| 机器 | 架构 | brew 前缀 | 定位 | brew 策略 |
|---|---|---|---|---|
| MBP 2019 | x86_64 | `/usr/local` | 日常机（至 2027-09 Intel EOL） | 存量维保：禁裸 `brew upgrade`，P0–P4 迁出执行中，只精准升级 |
| Mac mini M6 | arm64 | `/opt/homebrew` | 日常机（新） | 白名单出生：cask Brewfile + 极简 formula，从第一天就是终态 |

## 新机初始化（M6，按序执行）

1. **裸机基础**：账户名小写 `gatspy`（与旧机一致，杜绝大小写化石）；`xcode-select --install`；网络/代理（仓库内 aliyun pip、goproxy、清华 pipx 镜像随 mise 配置自动生效）
2. **mise 先行**（唯一先于 brew 的管理器，官方脚本装到 `~/.local/bin`，永不进 brew）→ `git clone git@github.com:gatspy/dotfiles.git ~/.dotfiles` → 激活符号链接（见 `docs/symlinks.md`，至少 `~/.zshrc` 与 `~/.config/mise/config.toml`）→ `mise install`（69+ 工具，ARM 原生）
3. **brew**：formula 白名单（下表，全部 bottle 分钟级）→ `brew bundle --file=homebrew/Brewfile.casks`（32 cask + 14 mas + 100+ vscode 扩展 + go/cargo 段）
   - mas 项需先登录 App Store；Xcode 走 mas 约 12GB；`mas "微信"`/`mas "WeChat_Lite"` 同 ID 重复，bundle 报错时删一行即可
4. **dotfiles 全面部署**：symlink 机制全量激活 → `vscode/install.sh`（M4 四 Profile）→ `~/.zsh.localrc` 私有配置**手动落位**（不在 git）
5. **冒烟验收**（最小环境，不信继承）：
   `env -i HOME=$HOME TERM=xterm-256color zsh -il -c 'command -v go starship mise ccls; git status -sb'`

## 跨架构债（部署前必须修，一处改动双机受益）

- `system/00-path.zsh`：`/usr/local/bin`、`/usr/local/sbin`、`/usr/local/opt/openssl@3/bin` 硬编码 → 按 `brew --prefix` 结果条件化（arm64 为 `/opt/homebrew`）
- `system/00-path.zsh`：NDK `prebuilt/${ndk_arch:-darwin-x86_64}` → 确认 `platform.zsh` 在 arm64 产出 `darwin-aarch64`
- `zsh/zshrc.symlink`：`complete -C /usr/local/bin/mc` → 前缀化

## M6 formula 白名单（初稿）

| 层级 | 包 | 说明 |
|---|---|---|
| 必装 | git curl tmux jq wget htop coreutils | 系统级基础 |
| 开发 | cmake ninja llvm ccls | ARM 全部有 bottle；ccls 在 M6 上分钟级复活（旧机冻结不修） |
| 按需 | ffmpeg imagemagick graphviz poppler protobuf gnupg nmap radare2 | 大件视为年升级项 |

## 通用纪律（三机三界皆准）

1. 未提交 = 未存在
2. 文件在仓库 ≠ 在机器生效（install 脚本跑过才算部署）
3. 验证必须用 `env -i` 最小环境，继承环境的"正常"是假象
4. `~/.local/golang/bin` 的工具（wire/dlv/air 等）不在 git：Brewfile go 段 + 项目 clone 后 `go install` 重建
