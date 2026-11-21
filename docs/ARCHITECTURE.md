# Dotfiles Architecture

**版本**: 3.1 (2026-11-21 三端化)
**作者**: gatspy
**系统**: macOS (Intel/Silicon) + Windows x64

---

## 设计理念

本项目采用 **topic-based 模块化架构**，每个技术栈或功能领域独立为一个主题（topic）。

**核心原则**：
- **模块化**：每个主题独立，易于维护
- **按需加载**：支持条件加载，减少启动时间
- **渐进优化**：保留良好架构，优化内容和性能
- **可回滚**：所有改动可追溯，支持快速恢复
- **三端单源**：工具域 mise 一份 config 三端共用（`os` 过滤分流），GUI 归平台原生包管理器

---

## 三端包管理编排（2026-11-21 定稿）

| 管理器 | 职责 | 正典清单 |
|---|---|---|
| mise | 跨平台运行时 + 纯二进制 CLI（Win 实装 83 / mac 实装 88） | `config/mise/config.toml.symlink` |
| Homebrew | macOS GUI cask、字体、动态库（M6 白名单；MBP 存量维保） | `homebrew/Brewfile.casks` v2.5 |
| Scoop | Windows GUI、字体、编译底座（git/mingw/msys2） | `config/scoop/scoopfile.json` |

优先级保障：mac 端 zshrc 先注入 mise shims 再于末尾 `mise activate zsh --shims`（二者互补：前者供 sheldon/starship eval 提前用上 mise 工具，后者挂 [env] hook）；Windows 双轨见 [windows-setup.md](windows-setup.md)。化石清单入 `archive/`，禁止再跑（根 Brewfile 已归档）。

---

## 目录结构

### 核心配置（始终加载）

```
dotfiles/
├── system/          # 系统核心：00-path / platform / env / aliases / history / keys
├── zsh/             # zshrc 入口、config、vimode、fpath、completion、zshrc.local（私有）
├── config/          # 外部工具配置
│   ├── mise/        # 三端单源 config.toml
│   ├── sheldon/     # 插件管理器
│   ├── starship.toml.symlink      # mac 提示符（Nerd Font 幻影风）
│   ├── starship.windows.toml      # win 提示符（Emoji 极简风）
│   ├── powershell/  # Windows 引导器 + user_profile + modules/（junction 建链）
│   ├── windows-terminal/settings.json
│   ├── scoop/       # scoopfile.json（C 阶段卸载后导出）
│   ├── git/         # ~/.config/git/ignore
│   └── zed/         # settings + keymap
├── script/          # bootstrap（bash + PowerShell 双版）、install、lib.sh
└── zshrc.symlink    # 主配置文件入口
```

### 开发工具（始终加载）

```
├── git/             # gitconfig（mac/windows 双版）+ aliases + gitmessage
├── homebrew/        # brew wrapper + Brewfile.casks
├── mise/            # GITHUB_TOKEN 注入 + rustup/cargo home 导出
├── fzf/ atuin/      # 懒加载
├── completions/     # 懒加载机制（pixi/django/react-native/dotnet）
└── functions/       # c/h/extract 等
```

### 语言和栈（白名单/条件加载）

```
├── python/ golang/ rust/ dart/ flutter/ web/ k8s/ xcode/
└── （android/qt/reactnative 按 topic_config 环境变量条件加载）
```

### 应用与键位（平台各异）

```
├── tmux/            # git 子模块
├── hammerspoon/     # macOS 自动化（~/.hammerspoon 目录链接）
├── karabiner/       # macOS 键位（目录即 live 配置目录）
├── capslox/         # Capslox keymap（win）
├── iterm/           # Dynamic Profiles + appearance.sh + 全量快照
└── macos/ vscode/   # defaults 与 VSCode 安装脚本
```

### 其他

```
├── ai/              # sbx 沙箱工作流（task/work/take）、versor
├── small-tools/     # zenith/zdns/antigravity
└── archive/         # 化石清单与历史文档（不加载不部署）
```

---

## 加载策略

### 优先级分层

```
Priority 1: 核心系统
  ├─ */path.zsh 文件（所有主题的 path.zsh）
  ├─ system/, zsh/ 主题
  └─ compinit（智能缓存，每日一建）

Priority 2: 开发工具
  ├─ git/, homebrew/, mise/, fzf/, atuin/
  ├─ completions/, functions/
  └─ script/（不参与 shell 加载，仅部署用）

Priority 3: 外部工具
  ├─ Sheldon 插件（zsh-defer 延迟）
  ├─ Starship Prompt
  └─ Zoxide 导航

Priority 4: 语言和应用（条件加载）
  ├─ always_load_topics 白名单（system|zsh|web|k8s|golang|rust|python|dart|git|
  │   homebrew|fzf|mise|atuin|tmux|hammerspoon|karabiner|xcode|ai|small-tools|
  │   completions|functions|config|script）
  ├─ topic_config 环境变量（android/flutter/reactnative/qt）
  └─ 注意：glob 只匹配 $DOTFILES/*/*.zsh 一层，子目录 topic 需显式 source
```

---

## 性能优化

### 已实现的优化

1. **智能 compinit**：zcompdump 每日仅重建一次（glob 修饰符判龄）
2. **懒加载机制**：pixi/django/react-native/dotnet/kubectl/atuin 首调才展开
3. **Sheldon defer**：全部非核心插件 zsh-defer 延迟
4. **补全 O(1) 跳过**：关联数组代替线性扫描

### 性能基准

| 版本 | 启动时间 |
|------|---------|
| 优化前 | ~817ms |
| v2.0 | ~500ms |
| v3.0 | ~490ms |

**当前基准**: **0.49s**（详见 [performance-baseline.md](performance-baseline.md)）

---

## 维护指南

### 添加新主题

1. 创建主题目录与文件（path.zsh / *.zsh / completion.zsh）
2. 更新 `zsh/zshrc.symlink` 的 `always_load_topics` 或 `topic_config`
3. `zsh -n ~/.zshrc` 语法自检

### 删除主题

1. **优先移至 archive/**（而非直接删除）
2. 更新 zshrc 引用
3. `zsh -n ~/.zshrc` 复检

### Windows 侧维护

- 改 profile/modules → 编辑仓库 `config/powershell/`（live 是 junction，写穿回仓库）
- 改完 `reload` 重载；WT settings 同理（symlink 写穿）
- 环境动作与验收见 [windows-setup.md](windows-setup.md)

### 性能监控

```bash
time zsh -i -c exit
zsh -i -x -c exit 2>&1 | tee /tmp/zsh-profile.log
zsh -n ~/.zshrc
```

---

## 外部工具集成

### Sheldon — 插件管理器

`config/sheldon/plugins.toml.symlink`：zsh-defer 立即加载，其余补全/功能插件全部 defer。

### Starship — 提示符

双版制：mac 用 `config/starship.toml.symlink`（Nerd Font），Windows 用 `config/starship.windows.toml`（Emoji）。bootstrap 按 OS 建链。

### Mise — 版本管理

`config/mise/config.toml.symlink` 三端单源。加载机制：zshrc 第 27 行预注入 shims（供 sheldon/starship/zoxide eval 使用），末尾 `mise activate zsh --shims` 挂 [env] hook——**不是懒加载**，占位函数已裁撤（2026-11-21）。`mise/init.zsh` 负责 rustup/cargo home 导出与 GITHUB_TOKEN 注入（gh auth token，值只留本机）。

---

## 故障排查

### 启动慢
```bash
zsh -i -x -c exit 2>&1 | grep source
type pixi          # 应显示 shell function（懒加载生效）
```

### 补全失效
```bash
grep <command> ~/.dotfiles/completions/lazy.zsh
exec zsh
```

### 配置错误
```bash
zsh -n ~/.zshrc
git bisect start HEAD HEAD~10
git bisect run zsh -i -c exit
```

---

## 相关文档

- **双机 mac runbook**: [new-mac-setup.md](new-mac-setup.md)
- **Windows runbook**: [windows-setup.md](windows-setup.md)
- **链接清单**: [symlinks.md](symlinks.md)
- **性能基准**: [performance-baseline.md](performance-baseline.md)
- **脚本库**: [script/lib.sh](../script/lib.sh)
- **主配置**: [zsh/zshrc.symlink](../zsh/zshrc.symlink)

---

## 版本历史

| 版本 | 日期 | 主要变更 |
|------|------|---------|
| 1.0 | - | 初始版本（holman 血统） |
| 2.0 | - | Sheldon/Starship/Zoxide 现代化 |
| 3.0 | 2026-03-08 | 渐进式优化：懒加载扩展、微型主题合并 |
| 3.1 | 2026-11-21 | 三端化：Windows 全量入仓、mise/brew/scoop 编排定稿、化石归档、mise 初始化收敛 |
