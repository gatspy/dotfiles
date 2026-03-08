# Karabiner-Elements 配置

## 使用说明

1. **复制模板配置**
   ```bash
   cp ~/.dotfiles/karabiner/karabiner.json.example ~/.config/karabiner/karabiner.json
   ```

2. **目录已符号链接到 ~/.config/karabiner**
   ```bash
   ~/.config/karabiner → ~/.dotfiles/karabiner
   ```

3. **修改配置**
   - 直接编辑 `~/.config/karabiner/karabiner.json`
   - 或使用 Karabiner-Elements GUI 修改

## 文件说明

- `karabiner.json.example` - 配置模板（不跟踪实际配置）
- `assets/` - Karabiner-Elements 自动备份目录
- `automatic_backups/` - 应用自动保存的备份

## 注意

**`karabiner.json` 已加入 `.gitignore`**，因为：
- Karabiner-Elements GUI 会直接修改这个文件
- 避免将个人配置提交到仓库

如需分享配置，请：
1. 清理个人信息
2. 重命名为 `karabiner.json.example`
3. 提交到仓库
