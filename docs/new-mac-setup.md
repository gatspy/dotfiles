# 双机配置手册：MBP 2019 (Intel) + Mac mini M6

> 2026-10-25 定稿 · 架构原则：**同一仓库，架构自适应，双机日常并行**

## 机器分工

| 机器 | 架构 | brew 前缀 | 定位 | brew 策略 |
|---|---|---|---|---|
| MBP 2019 | x86_64 | `/usr/local` | 日常机（至 2027-09 Intel EOL） | 存量维保：禁裸 `brew upgrade`，P0–P4 迁出执行中，只精准升级 |
| Mac mini M6 | arm64 | `/opt/homebrew` | 日常机（新） | 白名单出生：cask Brewfile + 极简 formula，从第一天就是终态 |

## 新机初始化（M6，按序执行）

1. **裸机基础**：账户名小写 `gatspy`（与旧机一致，杜绝大小写化石）；设备名 `Gatspy-Mini`（iCloud 管辖，实测不可改名——2026-10-26，mDNS 即 `Gatspy-Mini.local`；别名与主机名解耦，勿再折腾改名）；`xcode-select --install`；网络/代理（仓库内 aliyun pip、goproxy、清华 pipx 镜像随 mise 配置自动生效）
2. **mise 先行**（唯一先于 brew 的管理器，官方脚本装到 `~/.local/bin`，永不进 brew）→ `git clone git@github.com:gatspy/dotfiles.git ~/.dotfiles` → 激活符号链接（见 `docs/symlinks.md`，至少 `~/.zshrc` 与 `~/.config/mise/config.toml`）→ `mise install`（76 工具，ARM 原生）
3. **brew**：一条命令 `brew bundle --file=homebrew/Brewfile.casks` 全量部署（9 白名单 formula + 20 cask；cargo/npm/go 语言栈工具一律归 mise config.toml 管辖——Brewfile 的 cargo 段会触发 `brew install rust` 在 macOS 27 无瓶源码编译 llvm+z3 的事故，已永久删除）
   - App Store 应用（含 Xcode 约 12GB）手动到 App Store 安装；mas 已退役（2026-10-26）
4. **dotfiles 全面部署**：symlink 机制全量激活 → `vscode/install.sh`（M4 四 Profile）；`~/.zsh.localrc` 为软链指向 `zsh/zshrc.local`，已入 git 随 clone 自动到位（2026-10-27 实证修正，旧文"不在 git"为误）
5. **iTerm2 外观与重建保险**：外观三键（Dark/标签栏底部/不拉伸，2026-10-27 定稿）跑 `iterm/appearance.sh` 后重启 iTerm2；全量偏好快照在 `iterm/com.googlecode.iterm2.snapshot.plist`（`defaults import com.googlecode.iterm2 <file>` 后重启——覆盖当前全部偏好，慎用）；Modern 形态经 DynamicProfiles 自动吸收，注意字体（font-maple-mono-nf-cn）必须先于首次 iTerm2 启动安装；Master 形态（HackNF-Regular 13，字体四件套 HackNerdFont-*.ttf）经 `Master.json` 同步（Guid 与 MBP 本体相同——MBP 侧未部署维持自由身，一旦部署即同体接管，GUI 手改将转只读副本流）
5. **冒烟验收**（最小环境，不信继承）：
   `env -i HOME=$HOME TERM=xterm-256color zsh -il -c 'command -v go starship mise; git status -sb'`
6. **双机互通**（与 MBP 2019，2026-10-26 定稿）：
   - 开「远程登录」（系统设置 → 通用 → 共享），并把 `sshd` 加入「完全磁盘访问」（否则跨机读家目录部分文件被拒）
   - MBP 公钥入册：MBP 侧执行 `ssh mini 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_ed25519.pub`，M6 → MBP 反向同理（M6 生成 ed25519 后推给 MBP）
   - M6 侧对称别名：`Host mbp` → `HostName Gatspy.local` / `User gatspy`（MBP 侧 `Host mini` 已于 2026-10-26 落地）
   - 两端 sshd 收紧仅密钥：写 `/etc/ssh/sshd_config.d/99-hardening.conf`（`PasswordAuthentication no` + `KbdInteractiveAuthentication no` + `PermitRootLogin no`），`sudo launchctl kickstart -k system/com.openssh.sshd` 重载
   - 跨网 GUI 远控：uu远程（官网 dmg，双端安装；brew/mas 无包）
   - 验收三连：互 `ssh mini 'uname -m'` / `ssh mbp 'uname -m'` 见 arm64/x86_64；`rsync -n` 试传；屏幕共享互连一次

## 跨架构债

- ~~`/usr/local` 三处硬编码 + zshrc mc 补全路径~~ → 已修复（commit 807152d，按 `HOMEBREW_PREFIX` 条件化，双机受益）
- `system/00-path.zsh`：NDK `prebuilt/${ndk_arch:-darwin-x86_64}` → 待 M6 部署时确认 `platform.zsh` 在 arm64 产出 `darwin-aarch64`（Intel 上该行因 `(N)` 静默跳过，无影响）

## M6 formula 白名单（初稿）

| 层级 | 包 | 说明 |
|---|---|---|
| 必装 | git curl jq | 系统级基础（wget/htop/coreutils/grc 2026-10-27 退役；grc 着色被 mise 原生彩色工具全覆盖，system/grc.zsh 已删） |
| 开发 | cmake ninja | 构建工具，全部 bottle |
| 留任 | neovim mole | 编辑器留 brew / 同名不同物（wireshark 同日退役：纯 CLI 且不抓包） |
| 按需 | ffmpeg radare2 | 大件视为年升级项（protobuf 归 mise；graphviz/poppler/gnupg/imagemagick/libpq 已裁定退役） |

## 通用纪律（三机三界皆准）

1. 未提交 = 未存在
2. 文件在仓库 ≠ 在机器生效（install 脚本跑过才算部署）
3. 验证必须用 `env -i` 最小环境，继承环境的"正常"是假象
4. `~/.local/golang/bin` 的工具（wire/dlv/air 等）不在 git：Brewfile go 段 + 项目 clone 后 `go install` 重建
