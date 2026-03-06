# Modern Dotfiles

现代模块化 zsh 配置，支持版本管理和懒加载。

## 特性

- **版本管理**：[mise](https://mise.jdx.dev/) 管理所有语言运行时（Node, Python, Go, Ruby, Rust, Flutter, Java 等）
- **插件管理**：[sheldon](https://github.com/rossmacarthur/sheldon) + zsh-defer 懒加载
- **现代提示符**：[starship](https://starship.rs/) + [zoxide](https://github.com/ajeetdsouza/zoxide)
- **跨平台**：macOS 主支持，Linux 兼容

## 安装

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

## 目录结构

```
├── config/          # 外部工具配置 (mise, sheldon)
├── system/          # 核心系统设置 (platform, env, path)
├── [topic]/         # 主题特定配置
├── functions/       # 工具函数
├── bin/            # 可执行脚本
└── script/         # 安装和维护脚本
```

## 核心工具

| 工具 | 用途 |
|------|------|
| [mise](https://mise.jdx.dev/) | 统一版本管理 |
| [sheldon](https://github.com/rossmacarthur/sheldon) | 插件管理器 |
| [starship](https://starship.rs/) | 跨 shell 提示符 |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | 智能 cd 跳转 |
| [enhancd](https://github.com/b4b4r07/enhancd) | 增强 cd 命令 |
| [fzf](https://github.com/junegunn/fzf) | 模糊查找器 |

## 配置说明

### 自动加载规则

- `topic/path.zsh` 或 `topic/00-path.zsh` - 最先加载，设置 PATH
- `topic/*.zsh` - 按需加载
- `topic/completion.zsh` - 最后加载，设置补全
- `*.symlink` - 符号链接到 `$HOME`

### 外部配置同步

- `~/.config/mise/config.toml` ← `config/mise/config.toml.symlink`
- `~/.config/sheldon/plugins.toml` ← `config/sheldon/plugins.toml.symlink`

## 自定义

在 `~/.zsh.localrc` 中添加私有配置（不会被版本跟踪）。

## 依赖

- macOS 12+ 或主流 Linux 发行版
- [Homebrew](https://brew.sh/) (macOS)
- [git](https://git-scm.com/)

## 原始项目

基于 [holman/dotfiles](https://github.com/holman/dotfiles) 的主题化架构理念。
