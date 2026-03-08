# API Keys 安全管理指南

## ⚠️ 重要安全提示

**所有 API Key 必须通过环境变量设置，绝不能明文写在代码中！**

## 泄露密钥处理（已完成）

以下密钥曾在 `ai/agent.zsh` 中明文暴露，**已从代码中移除**，但**需要立即轮换**：

| 服务 | 状态 | 操作 |
|------|------|------|
| Kimi Codex | 🔴 已泄露 | **立即轮换** `KIMI_CODEX_API_KEY` |
| GLM Codex | 🔴 已泄露 | **立即轮换** `GLM_CODEX_API_KEY` |
| Gemini | 🔴 已泄露 | **立即轮换** `GEMINI_API_KEY` |
| Figma | 🔴 已泄露 | **立即轮换** `FIGMA_API_KEY` |
| Magic UI | 🔴 已泄露 | **立即轮换** `TWENTYFIRST_API_KEY` |
| Morphllm | 🔴 已泄露 | **立即轮换** `MORPH_API_KEY` |
| Cursor CLI | 🔴 已泄露 | **立即轮换** `CURSOR_API_KEY` |

### 轮换步骤

1. 登录各服务控制台
2. 撤销旧密钥
3. 生成新密钥
4. 更新环境变量（见下文）
5. 验证新密钥工作正常

## 安全配置方法

### 方法 1: 使用 shell 环境变量（推荐用于本地开发）

在 `~/.zshrc` 或 `~/.zsh.localrc` 中设置：

```bash
# Kimi Codex
export KIMI_CODEX_API_KEY="your-new-key-here"

# GLM Codex
export GLM_CODEX_API_KEY="your-new-key-here"

# Gemini
export GEMINI_API_KEY="your-new-key-here"

# Figma
export FIGMA_API_KEY="your-new-key-here"

# Magic UI
export TWENTYFIRST_API_KEY="your-new-key-here"

# Morphllm
export MORPH_API_KEY="your-new-key-here"

# Cursor CLI
export CURSOR_API_KEY="your-new-key-here"
```

### 方法 2: 使用密钥管理工具（推荐用于生产环境）

#### 使用 1Password CLI

```bash
# 设置密钥
op item edit --labels "kimi-codex" --fields "API Key=your-new-key"

# 在 shell 中加载
export KIMI_CODEX_API_KEY=$(op item get --labels "kimi-codex" --fields "API Key")
```

#### 使用 AWS Secrets Manager

```bash
# 存储密钥
aws secretsmanager create-secret \
  --name kimi-codex-api-key \
  --secret-string "your-new-key"

# 检索密钥
export KIMI_CODEX_API_KEY=$(aws secretsmanager get-secret-value \
  --secret-id kimi-codex-api-key \
  --query SecretString --output text)
```

#### 使用 Keychain（macOS）

```bash
# 存储密钥
security add-generic-password \
  -a "kimi-codex" \
  -s "dotfiles-api-keys" \
  -w "your-new-key"

# 检索密钥
export KIMI_CODEX_API_KEY=$(security find-generic-password \
  -a "kimi-codex" \
  -s "dotfiles-api-keys" \
  -w)
```

### 方法 3: 使用 .env 文件（仅本地开发，不提交到 Git）

创建 `~/.dotfiles/.env.local`：

```bash
# API Keys (DO NOT COMMIT)
KIMI_CODEX_API_KEY=your-new-key-here
GLM_CODEX_API_KEY=your-new-key-here
GEMINI_API_KEY=your-new-key-here
FIGMA_API_KEY=your-new-key-here
TWENTYFIRST_API_KEY=your-new-key-here
MORPH_API_KEY=your-new-key-here
CURSOR_API_KEY=your-new-key-here
```

在 `.gitignore` 中添加：
```
.env.local
.env
```

加载环境变量：
```bash
# 在 zshrc 中添加
[[ -f ~/.dotfiles/.env.local ]] && source ~/.dotfiles/.env.local
```

## 安全最佳实践

### ✅ 推荐做法

1. **使用环境变量**: 所有密钥通过环境变量设置
2. **最小权限原则**: 为密钥设置最小必要权限
3. **定期轮换**: 每 90 天轮换一次密钥
4. **监控使用**: 启用 API 使用监控和告警
5. **加密存储**: 使用密钥管理工具或加密存储
6. **访问审计**: 记录谁在何时访问了哪些密钥

### ❌ 避免做法

1. **不要提交密钥到 Git**: 包括历史记录
2. **不要硬编码密钥**: 在代码中直接写入
3. **不要共享密钥**: 通过不安全的渠道传输
4. **不要在日志中打印**: 防止密钥泄露到日志
5. **不要使用相同密钥**: 不同服务使用不同密钥

## 密钥泄露应急处理

如果发现密钥已泄露：

1. **立即撤销**: 登录服务控制台撤销泄露的密钥
2. **轮换密钥**: 生成新的密钥
3. **检查使用记录**: 查看是否有未授权使用
4. **清理 Git 历史**: 如果已提交到 Git，使用 BFG Repo-Cleaner 或 git-filter-repo 清理
5. **通知团队**: 告知所有相关人员更新密钥

## 清理 Git 历史

如果密钥已被提交到 Git：

```bash
# 使用 git-filter-repo 清理历史
pip install git-filter-repo

# 从历史中移除包含密钥的文件
git filter-repo --invert-paths --path ai/agent.zsh.backup

# 强制推送（谨慎使用！）
git push origin --force
```

## 相关资源

- [OWASP Key Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Key_Management_Cheat_Sheet.html)
- [GitHub Security Best Practices](https://docs.github.com/en/security)
- [Git Secrets](https://github.com/awslabs/git-secrets) - 防止密钥提交到 Git
