# 特殊配置文件使用说明

## 1. zsh/zshrc.local - 本地 Shell 配置

### 当前状态
- **文件路径**: `zsh/zshrc.local`
- **符号链接**: `~/.zsh.localrc` → `~/.dotfiles/zsh/zshrc.local`
- **内容大小**: 244 行
- **Git 状态**: 被 git 跟踪（⚠️ 与 .gitignore 配置不一致）

### 加载机制

```bash
# zsh/zshrc.symlink 中的加载逻辑
if [[ -f ~/.zsh.localrc ]]; then
  source ~/.zsh.localrc
fi
```

**实际流程**:
1. `~/.zsh.localrc` 符号链接到 `~/.dotfiles/zsh/zshrc.local`
2. `zshrc.symlink` source `~/.zsh.localrc`
3. 因此 `zsh/zshrc.local` 被加载

### 包含内容

- **环境变量**: FZF 配置、Java/Gradle 路径等
- **别名定义**: 80+ 个命令别名（cat→bat, vim→mvim 等）
- **自定义函数**: lls, new-id, git_log_month, mkp, = 计算器等
- **工具集成**: direnv, OrbStack, autojump

### 使用建议

**当前问题**:
- ❌ 文件包含敏感信息（服务器 SSH 别名）
- ❌ 包含机器特定路径（`/Users/Gatspy/`）
- ❌ .gitignore 中声明忽略，但实际被跟踪

**建议修复**:
```bash
# 1. 从 git 中移除（但保留本地文件）
git rm --cached zsh/zshrc.local

# 2. 确认 .gitignore 已添加
echo "zsh/zshrc.local" >> .gitignore

# 3. 以后使用 ~/.zsh.localrc 存放真正本地配置
#    或将敏感配置移到 ~/.zsh.localrc
```

---

## 2. karabiner - Karabiner-Elements 键盘映射

### 当前状态
- **配置文件**: `karabiner/karabiner.json`
- **目标位置**: `~/.config/karabiner/karabiner.json`
- **大小**: 266 行 JSON 配置
- **安装脚本**: `karabiner/install.sh`

### 加载机制

**手动安装**:
```bash
# 运行安装脚本
cd ~/.dotfiles
./karabiner/install.sh
```

**自动安装**:
```bash
# bootstrap 脚本不会自动安装 karabiner
# 需要手动运行或添加到 bootstrap
```

### 安装脚本逻辑

```bash
#!/usr/bin/env zsh
# Karabiner-Elements 配置安装脚本

# 1. 检查 Karabiner-Elements 是否已安装
if [[ ! -d "/Applications/Karabiner-Elements.app" ]]; then
  log_warning "Karabiner-Elements not found, skipping"
  exit 0
fi

# 2. 备份现有配置
KARABINER_CONFIG="$HOME/.config/karabiner"
backup_file "$KARABINER_CONFIG/karabiner.json"

# 3. 复制配置文件
cp "$DOTFILES/karabiner/karabiner.json" "$KARABINER_CONFIG/karabiner.json"
```

### 配置内容

**当前键盘映射**:

1. **右 Command → Hyper 键**
   - 按 `Right Command` 发送 `Ctrl+Option+Shift+Command`

2. **右 Shift + WASD → 方向键**
   - `Right Shift + W` → 上箭头
   - `Right Shift + A` → 左箭头
   - `Right Shift + S` → 下箭头
   - `Right Shift + D` → 右箭头

### 使用说明

1. **安装 Karabiner-Elements**
   ```bash
   brew install --cask karabiner-elements
   ```

2. **安装配置**
   ```bash
   cd ~/.dotfiles
   source karabiner/install.sh
   # 或
   ./karabiner/install.sh
   ```

3. **启用配置**
   - 打开 Karabiner-Elements 应用
   - 在 "Complex Modifications" 中加载配置
   - 确保 "change right_command to hyper" 和 "change right_shift+wsad" 已启用

4. **验证映射**
   - 按 `Right Command` 应该触发 Hyper 键
   - 按 `Right Shift + W/A/S/D` 应该触发方向键

---

## 对比总结

| 配置 | 加载方式 | 自动安装 | 更新频率 |
|------|---------|---------|---------|
| `zsh/zshrc.local` | 符号链接 + source | ✅ 是 | 经常（开发工具） |
| `karabiner/` | 复制文件 | ❌ 否 | 很少（稳定配置） |

---

## 建议改进

### zsh/zshrc.local

**问题**: 包含敏感信息和机器特定路径

**方案 1: 移出仓库**
```bash
# 将本地配置移到真正的本地文件
mv zsh/zshrc.local ~/.zsh.localrc.real
ln -sf ~/.zsh.localrc.real ~/.zsh.localrc
```

**方案 2: 拆分配置**
```bash
# 创建模板文件
mv zsh/zshrc.local zsh/zshrc.local.template
# 用户复制并修改
cp zsh/zshrc.local.template ~/.zsh.localrc
```

### karabiner

**建议**: 添加到 bootstrap 自动安装

```bash
# 在 script/bootstrap 的 install_configs() 中添加：
if [ -d "$DOTFILES_ROOT/karabiner" ]; then
  bash "$DOTFILES_ROOT/karabiner/install.sh"
fi
```

---

## 故障排查

### zsh/zshrc.local

**问题**: 配置未生效

```bash
# 检查链接
ls -la ~/.zsh.localrc

# 手动加载
source ~/.zsh.localrc

# 测试别名
alias bat  # 应该显示 cat='bat'
```

### karabiner

**问题**: 键盘映射不生效

```bash
# 1. 检查应用是否安装
ls -la /Applications/Karabiner-Elements.app

# 2. 检查配置文件
ls -la ~/.config/karabiner/karabiner.json

# 3. 检查配置是否被 Karabiner-Elements 加载
# 打开应用 → Complex Modifications → 查看是否启用

# 4. 重新安装配置
cd ~/.dotfiles && ./karabiner/install.sh
```
