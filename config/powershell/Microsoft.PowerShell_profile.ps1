# =============================================================================
#  PowerShell Bootloader (Cosmic Edition v10.0)
#  架构：实时加载 + 模块化扩展 | 特点：0 报错，高可维护性
# =============================================================================
[Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 1. 定义路径
$ConfigRoot = "$HOME\.config\powershell"
$UserProfile = Join-Path $ConfigRoot "user_profile.ps1"
$ModulesDir  = Join-Path $ConfigRoot "modules"

# 2. 核心工具链加载 (实时运行，确保无误)
# -----------------------------------------------------------------------------

# [Mise]
$env:MISE_SHELL = "powershell"
if (Get-Command mise -ErrorAction SilentlyContinue) {
    Invoke-Expression (& mise activate pwsh | Out-String)
}

# [Starship]
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (& starship init powershell | Out-String)
}

# [Zoxide]
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& zoxide init powershell | Out-String)
}

# [Scoop 补全]（scoop 安装时会把自身 modules 目录写进 PSModulePath，直接按名导入；
# 旧版写死 USERPROFILE\scoop / H:\scoop 两个路径，在 D:\Program\Scoop\main 根下静默失效）
if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Import-Module scoop-completion -ErrorAction SilentlyContinue
}

# [GITHUB_TOKEN] cargo-binstall / gh 生态限流救急；值只留本机进程，绝不入仓
if (Get-Command gh -ErrorAction SilentlyContinue) {
    $_ghToken = gh auth token 2>$null
    if ($_ghToken) { $env:GITHUB_TOKEN = $_ghToken }
    Remove-Variable _ghToken -ErrorAction SilentlyContinue
}

# 3. 加载用户主配置
# -----------------------------------------------------------------------------
if (Test-Path $UserProfile) { 
    . $UserProfile 
} else {
    # 自动创建目录结构 (如果不存在)
    if (-not (Test-Path $ConfigRoot)) { New-Item -Path $ConfigRoot -ItemType Directory -Force | Out-Null }
    if (-not (Test-Path $ModulesDir)) { New-Item -Path $ModulesDir -ItemType Directory -Force | Out-Null }
}

# 4. 安全自动加载扩展模块 (加上 -ExecutionPolicy Bypass 绕过策略阻断)
# -----------------------------------------------------------------------------
if (Test-Path $ModulesDir) {
    Get-ChildItem -Path $ModulesDir -Filter "*.ps1" | ForEach-Object {
        try {
            # 使用临时沙箱策略载入扩展，防止点加载报错
            Set-ExecutionPolicy Bypass -Scope Process -Force
            . $_.FullName
        } catch {}
    }
}

# 5. 定义重载命令
function global:reload {
    . $PROFILE
    Write-Host "🚀 配置已重载！" -ForegroundColor Cyan
}
Set-Alias source reload


# =============================================================================
#  👇 以下是追加内容 (智能标题逻辑 - Emoji 通用版) 👇
# =============================================================================

# 1. 锁定 Starship Prompt
if (Test-Path function:prompt) {
    $Global:OriginalStarshipPrompt = $function:prompt
}

# 2. 定义图标 (使用通用 Emoji，任何字体都能显示！)
function Get-WTitle-Icon {
    if (Test-Path "Cargo.toml")     { return "🦀" } # Rust
    if (Test-Path "go.mod")         { return "🐹" } # Go
    if (Test-Path "package.json")   { return "📦" } # Node
    if (Test-Path "*.py")           { return "🐍" } # Python
    if (Test-Path "pom.xml")        { return "☕" } # Java
    return "📂" # 默认文件夹
}

# 3. 获取 Git 信息
function Get-WTitle-Git {
    try {
        if (-not (git rev-parse --is-inside-work-tree 2>$null)) { return "" }
        
        $branch = git symbolic-ref --short HEAD 2>$null
        if (-not $branch) { $branch = git rev-parse --short HEAD 2>$null }
        if (-not $branch) { return "" }
        
        # 拆开写，防止报错
        $dirty = $false
        git diff --quiet 2>$null
        if ($LASTEXITCODE -ne 0) { 
            $dirty = $true 
        } else {
            git diff --cached --quiet 2>$null
            if ($LASTEXITCODE -ne 0) { $dirty = $true }
        }
        
        # 这里换成了树叶图标，你之前喜欢的
        $icon = "🌿" 
        if ($dirty) { return " | $icon $branch*" }
        return " | $icon $branch"
    } catch { return "" }
}

# 4. 覆盖 Prompt
function prompt {
    try {
        # A. 算标题
        $icon = Get-WTitle-Icon
        $path = Split-Path -Leaf $PWD.Path
        if ($PWD.Path -eq $HOME) { $path = "~" }
        $git  = Get-WTitle-Git
        
        # 组合标题
        $titleText = "$icon $path$git"
        
        # B. 发 ANSI 指令
        $ansi = "$([char]27)]0;${titleText}$([char]7)"
    } catch {
        $ansi = ""
    }

    # C. 运行原来的 Starship
    if ($Global:OriginalStarshipPrompt) {
        return $ansi + (& $Global:OriginalStarshipPrompt)
    }
    return $ansi + "PS $PWD> "
}