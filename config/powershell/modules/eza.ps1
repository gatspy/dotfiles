# ----------------------------------------------------------------
# EZA Configuration (ls replacement)
# ----------------------------------------------------------------
#if (Get-Command eza -ErrorAction SilentlyContinue) {
#    # 1. 移除 PowerShell 自带的别名 (防止冲突)
#    if (Test-Path alias:ls)  { Remove-Item alias:ls }
#    if (Test-Path alias:dir) { Remove-Item alias:dir }

#    # 2. 定义通用参数 (推荐配置)
#    # --icons: 显示图标 (需要 Nerd Font)
#    # --group-directories-first: 文件夹排在前面 (符合 Windows 习惯)
#    # --git: 显示 Git 状态 (新增/修改)
#    # --header: 显示表头
#    # --time-style relative: 显示 "2 days ago" 而不是具体日期 (可选)

#    # 基础命令: ls (只看文件名和图标，保持简洁)
#    function ls { eza --icons --group-directories-first $args }

#    # 列表命令: ll (显示详细信息、权限、大小、Git状态)
#    function ll { eza --long --header --icons --git --group-directories-first --time-style relative $args }

#    # 全部命令: la (包含隐藏文件)
#    function la { eza --long --header --icons --git --all --group-directories-first $args }

#    # 树形命令: lt (像 tree 一样显示目录树，限制2层深度)
#    function lt { eza --tree --level=2 --icons $args }

#    # 替代 dir (如果你习惯打 dir，也可以让它变漂亮)
#    function dir { eza --long --header --icons --git --group-directories-first $args }
#}

# =============================================================================
# EZA 高颜值现代化配置 (Best Practice)
# =============================================================================

if (Get-Command eza -ErrorAction SilentlyContinue) {

    # 1. 启用 Vivid 配色 (推荐主题: molokai, snazzy, dracula, one-dark, zenburn)
    #    如果不喜欢 molokai，可以换成 snazzy 或者 dracula
    $env:LS_COLORS = (vivid generate snazzy | Out-String)

    # 2. 清理旧别名，防止冲突
    if (Test-Path alias:ls)  { Remove-Item alias:ls }
    if (Test-Path alias:ll)  { Remove-Item alias:ll }
    if (Test-Path alias:la)  { Remove-Item alias:la }
    if (Test-Path alias:lt)  { Remove-Item alias:lt }

    # 3. 定义核心参数组合 (提取公用参数)
    # --icons: 显示图标
    # --git: 显示 Git 状态
    # --hyperlink: 支持点击打开
    # --group-directories-first: 文件夹置顶
    # --time-style relative: 相对时间 (如 "2 days ago")
    # --color-scale: 根据文件大小/日期显示不同深浅的颜色 (高级感来源!)
    $eza_params = @('--icons', '--git', '--hyperlink', '--group-directories-first', '--time-style', 'relative', '--color-scale')

    # -------------------------------------------------------------------------
    # 定义命令函数
    # -------------------------------------------------------------------------

    # ls: 极简模式 (只看文件名，但也带图标和颜色)
    function ls { eza $eza_params $args }

    # ll: 详细列表 (开发最常用)
    # --long: 详细信息
    # --header: 显示表头
    # --git-ignore: 同时也列出 .gitignore 里的文件(但会变暗)，方便检查
    function ll { eza --long --header --git-ignore $eza_params $args }

    # la: 显示所有 (包括隐藏文件)
    function la { eza --long --header --all $eza_params $args }

    # lt: 树形结构 (替代 tree)
    # --level=2: 默认只看2层，防止刷屏
    function lt { eza --tree --level=2 $eza_params $args }
    
    # tree: 深度树 (如果你习惯打 tree)
    function tree { eza --tree $eza_params $args }
}

# =============================================================================
# Vivid Theme Previewer (带 Tab 补全的预览神器)
# =============================================================================
function preview-theme {
    param (
        [Parameter(Mandatory=$false, Position=0)]
        [ArgumentCompleter({
            param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
            vivid themes | Where-Object { $_ -like "$wordToComplete*" }
        })]
        [string]$Name
    )

    if (-not $Name) {
        Write-Host "🎨 输入 preview-theme <名字> 来预览 (按 Tab 补全)" -ForegroundColor Cyan
        return
    }

    $old_colors = $env:LS_COLORS

    try {
        # 🟢 关键修复：加了 | Out-String 和 .Trim() 确保颜色代码纯净无污染
        $color_code = (vivid generate $Name | Out-String).Trim()
        
        # 检查 vivid 是否成功生成了代码
        if ([string]::IsNullOrWhiteSpace($color_code)) {
            throw "Vivid 生成的颜色代码为空"
        }

        $env:LS_COLORS = $color_code
        
        Clear-Host
        Write-Host "`n🎨 主题: [ $Name ] (如果不变色，说明该主题对当前文件类型定义较少)" -ForegroundColor Yellow
        Write-Host "------------------------------------------------" -ForegroundColor DarkGray
        
        # 强制显示颜色
        eza --grid --icons --group-directories-first --color=always
        
        Write-Host "------------------------------------------------" -ForegroundColor DarkGray
    }
    catch {
        Write-Host "❌ 错误: $_" -ForegroundColor Red
    }
    finally {
        $env:LS_COLORS = $old_colors
    }
}

# 简写别名 (可选)
Set-Alias -Name pt -Value preview-theme