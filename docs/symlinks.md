# Dotfiles 符号链接清单

**更新日期**: 2026-03-08
**总计**: 11 个符号链接

---

## 链接分类

### 1. 根目录 .symlink 文件 (5个)

这些文件位于主题目录下，使用 `.symlink` 后缀标记：

| 源文件 | 目标路径 | 说明 |
|--------|---------|------|
| `git/gitconfig.symlink` | `~/.gitconfig` | Git 通用配置 |
| `git/gitignore.symlink` | `~/.gitignore` | Git 忽略规则 |
| `git/gitconfig.local.symlink` | `~/.gitconfig.local` | Git 本地配置 |
| `web/npmrc.symlink` | `~/.npmrc` | NPM 配置 |
| `zsh/zshrc.symlink` | `~/.zshrc` | Zsh 主配置 |

**处理函数**: `install_dotfiles()`

---

### 2. config/ 目录 .symlink 文件 (3个)

这些文件遵循 XDG 配置目录规范，位于 `~/.config/` 下：

| 源文件 | 目标路径 | 说明 |
|--------|---------|------|
| `config/mise/config.toml.symlink` | `~/.config/mise/config.toml` | Mise 版本管理配置 |
| `config/sheldon/plugins.toml.symlink` | `~/.config/sheldon/plugins.toml` | Sheldon 插件配置 |
| `config/starship.toml.symlink` | `~/.config/starship.toml` | Starship 提示符配置 |

**处理函数**: `install_configs()`

---

### 3. 特殊处理的文件 (3个)

这些文件不由通用的 `.symlink` 机制处理：

| 源文件/目录 | 目标路径 | 处理方式 | 说明 |
|------------|---------|---------|------|
| `tmux/.tmux.conf` | `~/.tmux.conf` | 符号链接 | Tmux 配置（来自子模块） |
| `tmux/.tmux.conf.local` | `~/.tmux.conf.local` | 复制 | Tmux 本地配置（仅首次） |
| `hammerspoon/` | `~/.hammerspoon` | 目录链接 | Hammerspoon 配置目录 |

**处理函数**: `install_configs()`

---

## Bootstrap 处理逻辑

### install_dotfiles()

```bash
# 只处理根目录下的 .symlink 文件，跳过 config/ 目录
for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 \
  -name '*.symlink' \
  -not -path '*.git*' \
  -not -path '*/config/*'); do

  filename=$(basename "$src" .symlink)
  dst="$HOME/.$filename"
  link_file "$src" "$dst"
done
```

**关键点**:
- 使用 `-not -path '*/config/*'` 跳过 config/ 目录
- 使用 `basename "$src" .symlink` 获取文件名

### install_configs()

```bash
# Mise 配置
if [ -f "$DOTFILES_ROOT/config/mise/config.toml.symlink" ]; then
  mkdir -p ~/.config/mise
  link_file "$DOTFILES_ROOT/config/mise/config.toml.symlink" ~/.config/mise/config.toml
fi

# Sheldon 配置
if [ -f "$DOTFILES_ROOT/config/sheldon/plugins.toml.symlink" ]; then
  mkdir -p ~/.config/sheldon
  link_file "$DOTFILES_ROOT/config/sheldon/plugins.toml.symlink" ~/.config/sheldon/plugins.toml
fi

# Starship 配置
if [ -f "$DOTFILES_ROOT/config/starship.toml.symlink" ]; then
  mkdir -p ~/.config
  link_file "$DOTFILES_ROOT/config/starship.toml.symlink" ~/.config/starship.toml
fi

# Tmux 配置
if [ -f "$DOTFILES_ROOT/tmux/.tmux.conf" ]; then
  link_file "$DOTFILES_ROOT/tmux/.tmux.conf" ~/.tmux.conf
fi

# Hammerspoon 配置
if [ -d "$DOTFILES_ROOT/hammerspoon" ]; then
  link_file "$DOTFILES_ROOT/hammerspoon" ~/.hammerspoon
fi
```

---

## 链接冲突处理

`link_file()` 函数的冲突处理策略：

| 目标状态 | 处理方式 |
|---------|---------|
| 不存在 | 直接创建链接 |
| 已是正确的链接 | 跳过 |
| 是其他链接 | 备存后重新链接 |
| 是普通文件 | 备存为 `.backup` 后链接 |
| 是目录 | 删除目录后链接（⚠️ 危险） |

**注意**: `.hammerspoon` 是目录，会被直接删除！

---

## 添加新链接

### 方式 1: 使用 .symlink 后缀（推荐）

```bash
# 在主题目录下创建 .symlink 文件
cat > ~/.dotfiles/mytool/config.conf.symlink << 'EOF'
# 配置内容
EOF

# 运行 bootstrap
script/bootstrap
```

**适用**: 链接到 `~/.filename` 的文件

### 方式 2: 添加到 install_configs()

```bash
# 在 script/bootstrap 中添加处理逻辑
# install_configs() 函数内

if [ -f "$DOTFILES_ROOT/config/mytool/config.conf.symlink" ]; then
  mkdir -p ~/.config/mytool
  link_file "$DOTFILES_ROOT/config/mytool/config.conf.symlink" ~/.config/mytool/config.conf
fi
```

**适用**: 链接到 `~/.config/` 下的文件

---

## 故障排查

### 检查链接状态

```bash
# 检查单个链接
readlink ~/.zshrc

# 检查所有链接
find ~ -maxdepth 1 -type l -name ".*" | while read f; do
  echo "$f → $(readlink $f)"
done

# 检查损坏的链接
find ~ -maxdepth 1 -xtype l
```

### 重新创建链接

```bash
# 运行 bootstrap
cd ~/.dotfiles
script/bootstrap

# 或手动创建
ln -sf ~/.dotfiles/zsh/zshrc.symlink ~/.zshrc
```

---

## 历史变更

| 日期 | 变更内容 |
|------|---------|
| 2026-03-08 | 修复 config/ 目录文件链接路径错误 |
| 2026-03-08 | 添加 starship.toml.symlink |
