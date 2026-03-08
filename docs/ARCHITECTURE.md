# Dotfiles Architecture

**版本**: 3.0 (2026-03-08 优化版)
**作者**: gatspy
**系统**: macOS (Apple Silicon)

---

## 设计理念

本项目采用 **topic-based 模块化架构**，每个技术栈或功能领域独立为一个主题（topic）。

**核心原则**：
- **模块化**：每个主题独立，易于维护
- **按需加载**：支持条件加载，减少启动时间
- **渐进优化**：保留良好架构，优化内容和性能
- **可回滚**：所有改动可追溯，支持快速恢复

---

## 目录结构

### 核心配置（始终加载）

```
dotfiles/
├── system/          # 系统核心配置
│   ├── 00-path.zsh  # PATH 设置
│   ├── aliases.zsh  # 核心别名
│   └── env.zsh      # 环境变量
├── zsh/             # Zsh shell 配置
│   ├── config.zsh   # Zsh 选项配置
│   ├── vimode.zsh   # Vi 模式配置
│   └── keybindings.zsh # 键绑定
├── config/          # 外部工具配置
│   ├── sheldon/     # Sheldon 插件管理器
│   └── mise/        # Mise 版本管理
├── script/          # 安装和引导脚本
│   └── lib.sh       # 公共函数库
└── zshrc.symlink    # 主配置文件入口
```

### 开发工具（始终加载）

```
├── git/             # Git 版本控制
│   ├── aliases.zsh
│   └── install.sh
├── homebrew/        # Homebrew 包管理
│   ├── aliases.zsh
│   └── install.sh
├── mise/            # 版本管理（懒加载）
├── fzf/             # 模糊查找器
├── atuin/           # Shell 历史（懒加载）
├── completions/     # 命令补全
│   └── lazy.zsh     # 懒加载机制
└── functions/       # 自定义 shell 函数
```

### 语言和框架（条件加载）

```
├── python/          # Python 开发
├── golang/          # Go 开发
├── rust/            # Rust 开发
├── dart/            # Dart SDK
├── flutter/         # Flutter 开发
├── web/             # Web 开发（Node.js, npm）
└── k8s/             # Kubernetes 工具
```

### 应用配置（条件加载）

```
├── tmux/            # Tmux 终端复用器
├── hammerspoon/     # macOS 自动化
├── karabiner/       # 键盘自定义
├── iterm/           # iTerm2 配置
├── macos/           # macOS 系统设置
└── xcode/           # Xcode 开发
```

### 实用工具

```
├── ai/              # AI 工具配置
├── small-tools/     # 小型工具集
│   ├── aliases.zsh      # zenith, zdns 别名
│   ├── zdns-funcs.zsh   # zdns 函数
│   └── antigravity.zsh  # antigravity 配置
├── bin/             # 自定义可执行脚本
└── archive/         # 归档目录（不加载）
```

---

## 加载策略

### 优先级分层

```
Priority 1: 核心系统
  ├─ path.zsh 文件（所有主题的 path.zsh）
  ├─ system/, zsh/ 主题
  └─ compinit（智能缓存）

Priority 2: 开发工具
  ├─ git/, homebrew/, mise/, fzf/, atuin/
  ├─ completions/, functions/
  └─ config/, script/

Priority 3: 外部工具
  ├─ Sheldon 插件（使用 defer）
  ├─ Starship Prompt
  └─ Zoxide 导航

Priority 4: 语言和应用（条件加载）
  ├─ 基于环境变量：$ANDROID_HOME, $FLUTTER_ROOT 等
  ├─ 基于命令存在：$commands[python], $commands[go] 等
  └─ 基于平台检测：$OSTYPE, $TERM_PROGRAM 等
```

### 条件加载配置

```zsh
# 始终加载的主题
always_load_topics="^(system|zsh|git|homebrew|fzf|mise|...|small-tools)$"

# 条件加载的主题
topic_config=(
  [android]="$ANDROID_HOME"         # Android 开发
  [flutter]="$FLUTTER_ROOT"         # Flutter 开发
  [reactnative]="$REACT_NATIVE_ROOT" # React Native
  [qt]="$QT_QMAKE_DIR"             # Qt 开发
)
```

---

## 性能优化

### 已实现的优化

1. **智能 compinit**：每日仅重建一次
   ```zsh
   if [ $(date +'%j') != $(date -r ${ZDOTDIR:-$HOME}/.zcompdump '+%j') ]; then
     compinit
   else
     compinit -C
   fi
   ```

2. **懒加载机制**：大型补全按需加载
   ```zsh
   # completions/lazy.zsh
   pixi() {
     unfunction "$0"
     source "$DOTFILES/completions/pixi.completion.zsh"
     pixi "$@"
   }
   ```

3. **Sheldon defer**：所有非核心插件延迟加载
   ```toml
   [plugins.zsh-autosuggestions]
   apply = ["defer"]
   ```

4. **补全系统优化**：跳过懒加载的补全文件
   ```zsh
   lazy_completions=(pixi django react-native dotnet)
   ```

### 性能基准

| 版本 | 启动时间 | 优化 |
|------|---------|------|
| 优化前 | ~817ms | - |
| v2.0 | ~500ms | 39% ↓ |
| v3.0 | ~490ms | 40% ↓ |

**当前基准**: **0.49s** (稳定后)

---

## 维护指南

### 添加新主题

1. 创建主题目录：
   ```bash
   mkdir ~/.dotframes/my-theme
   ```

2. 创建配置文件：
   ```bash
   # my-theme/path.zsh      # PATH 设置（可选）
   # my-theme/aliases.zsh    # 别名定义
   # my-theme/init.zsh       # 初始化脚本
   # my-theme/completion.zsh # 补全定义（可选）
   ```

3. 更新 `zsh/zshrc.symlink`：
   ```zsh
   # 始终加载
   always_load_topics="^(...|my-theme)$"

   # 或条件加载
   topic_config+=([my-theme]="$MY_TOOL_HOME")
   ```

### 删除主题

1. **优先移至 archive/**（而非直接删除）：
   ```bash
   mv ~/.dotfiles/my-theme ~/.dotfiles/archive/
   ```

2. 更新 `zsh/zshrc.symlink`，移除引用

3. 测试配置：
   ```bash
   zsh -n ~/.zshrc
   ```

### 性能监控

```bash
# 启动时间
time zsh -i -c exit

# 性能分析
zsh -i -x -c exit 2>&1 | tee /tmp/zsh-profile.log

# 语法检查
zsh -n ~/.zshrc
```

---

## 外部工具集成

### Sheldon - 插件管理器

**配置文件**: `config/sheldon/plugins.toml.symlink`

**插件类型**：
- 补全插件：npm, docker, rust（defer 加载）
- 功能插件：autosuggestions, history-search, syntax-highlighting（defer 加载）
- 核心插件：zsh-defer（立即加载）

### Starship - 提示符

**配置文件**: `~/.config/starship.toml`

**集成点**: `zsh/zshrc.symlink:33`
- 读取 `VI_KEYMAP` 变量（由 `zsh/vimode.zsh` 设置）
- 显示 Git 状态（由 Sheldon 插件提供）

### Mise - 版本管理

**配置文件**: `config/mise/config.toml.symlink`

**懒加载**: `mise/init.zsh`
```zsh
mise() {
  unfunction "$0"
  eval "$(mise activate zsh)"
  mise "$@"
}
```

---

## 故障排查

### 启动慢

1. 检查加载的文件：
   ```bash
   zsh -i -x -c exit 2>&1 | grep source
   ```

2. 验证懒加载：
   ```bash
   type pixi  # 应显示 "is a shell function"
   ```

3. 更新 Sheldon：
   ```bash
   sheldon lock --update
   ```

### 补全失效

1. 检查命令是否存在：
   ```bash
   which <command>
   ```

2. 检查 lazy.zsh：
   ```bash
   grep <command> ~/.dotfiles/completions/lazy.zsh
   ```

3. 强制重新加载：
   ```bash
   exec zsh
   ```

### 配置错误

1. 语法检查：
   ```bash
   zsh -n ~/.zshrc
   ```

2. 逐行加载：
   ```bash
   zsh -i -x -c exit 2>&1 | tail
   ```

3. Git bisect：
   ```bash
   git bisect start HEAD HEAD~10
   git bisect run zsh -i -c exit
   ```

---

## 相关文档

- **性能基准**: [docs/performance-baseline.md](performance-baseline.md)
- **脚本库**: [script/lib.sh](../script/lib.sh)
- **主配置**: [zsh/zshrc.symlink](../zsh/zshrc.symlink)

---

## 版本历史

| 版本 | 日期 | 主要变更 |
|------|------|---------|
| 1.0 | - | 初始版本 |
| 2.0 | - | 添加 Sheldon/Starship/Zoxide |
| 3.0 | 2026-03-08 | 渐进式优化：删除遗留、扩展懒加载、合并微型主题 |
