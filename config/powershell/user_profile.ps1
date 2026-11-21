# =============================================================================
#  User Profile (修复版)
# =============================================================================

# 1. 实用函数 (提到了最前面，确保一定能加载！)
# -----------------------------------------------------------
function global:pwdcp {   # <--- 加了 global: 前缀，确保 reload 也能活下来
    Set-Clipboard -Value $PWD.Path
    Write-Host "✅ 已复制: $($PWD.Path)" -ForegroundColor Green
}

function global:rf {
    param([string]$query)
    if (-not $query) { $query = Read-Host "请输入搜索内容" }
    $result = rg --column --line-number --no-heading --color=always --smart-case $query |
              fzf --ansi --delimiter : --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' --preview-window 'right:60%:border-left' |
              ForEach-Object { $_ -replace ':.*$', '' }
    if ($result) { $parts = $result -split ':'; code -g "$($parts[0]):$($parts[1])" }
}

# 2. 交互体验优化 (穿上防弹衣)
# -----------------------------------------------------------
if (Get-Module -ListAvailable PSReadLine) {
    Import-Module PSReadLine -ErrorAction SilentlyContinue
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -EditMode Windows
    
    # [强力防错] 用 try-catch 包裹，就算不支持也不崩
    try {
        Set-PSReadLineOption -HistorySearchCursorMovesToEnd -ErrorAction Stop
    } catch {
        # 忽略错误
    }

    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

# 3. 别名与函数
# -----------------------------------------------------------
Set-Alias g   git         
Set-Alias lg  lazygit
Set-Alias vim nvim   
Set-Alias vi  nvim
Set-Alias cls Clear-Host

if (Get-Command bat -ErrorAction SilentlyContinue) { 
    if (Test-Path Alias:cat) { Remove-Item Alias:\cat -ErrorAction SilentlyContinue }
    Set-Alias cat bat 
}

function ..   { Set-Location .. }
function ...  { Set-Location ..\.. }
function open { if ($args.Count -eq 0) { ii . } else { ii $args } }
function which { Get-Command $args }
function profile { code "$HOME\.config\powershell\user_profile.ps1" }

# [Sudo]
function global:sudo {
    param([string]$cmd)
    if ($cmd) { Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& $cmd" -Verb RunAs }
    else { Start-Process pwsh -Verb RunAs }
}

# [Proxy]
function global:proxy {
    $port = 7890 
    $env:HTTP_PROXY = "http://127.0.0.1:$port"; $env:HTTPS_PROXY = "http://127.0.0.1:$port"; $env:ALL_PROXY = "socks5://127.0.0.1:$port"
    Write-Host "🌍 Proxy ON" -ForegroundColor Green
}
function global:unproxy {
    Remove-Item Env:\HTTP_PROXY -ErrorAction SilentlyContinue; Remove-Item Env:\HTTPS_PROXY -ErrorAction SilentlyContinue; Remove-Item Env:\ALL_PROXY -ErrorAction SilentlyContinue
    Write-Host "🚫 Proxy OFF" -ForegroundColor Yellow
}

# [Mkcd]
function global:mkcd { param([string]$dir); New-Item -ItemType Directory -Path $dir -Force | Out-Null; Set-Location $dir }
Set-Alias mkp mkcd

# [Upall] 一键全量升级（dotfiles + scoop + mise）
function global:upall {
    git -C "$HOME\.dotfiles" pull
    scoop update "*"; scoop cleanup "*"
    mise up
    mise prune -y
}

# [ln]
function ln {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Target,

        [Parameter(Mandatory=$true, Position=1)]
        [string]$Path,
        
        [Parameter(Position=2)]
        [string]$ItemType = "SymbolicLink"
    )

    if (-not (Test-Path $Target)) {
        Write-Error "目标路径不存在: $Target"
        return
    }
    
    # 确定是文件链接还是目录链接，除非用户明确指定
    if ($ItemType -eq "SymbolicLink" -and (Get-Item $Target).PSIsContainer) {
        $ItemType = "SymbolicLink" # 默认创建目录的符号链接
    }

    New-Item -Path $Path -Target $Target -ItemType $ItemType -Force
}


# 4. FZF 配置（PSFzf 懒加载：首次按 Ctrl+R/T/Alt+C 才 Import，省 131ms/标签）
# -----------------------------------------------------------
if (Get-Command fzf -ErrorAction SilentlyContinue) {
    if (Get-Module -ListAvailable PSFzf) {
        if (Get-Command fd -ErrorAction SilentlyContinue) {
            $env:FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
            $env:FZF_CTRL_T_COMMAND  = $env:FZF_DEFAULT_COMMAND
            $env:FZF_ALT_C_COMMAND   = 'fd --type d --hidden --follow --exclude .git'
        }
        $env:FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border"

        # 首次按键时 Import + 换绑真实处理器，之后与直载行为一致
        function global:Initialize-PSFzf {
            if (-not (Get-Module PSFzf)) {
                Import-Module PSFzf -ErrorAction SilentlyContinue
                Set-PSReadLineKeyHandler -Chord 'Ctrl+r' -ScriptBlock { Invoke-FzfPsReadlineHandlerHistory }
                Set-PSReadLineKeyHandler -Chord 'Ctrl+t' -ScriptBlock { Invoke-FzfPsReadlineHandlerProvider }
                Set-PSReadLineKeyHandler -Chord 'Alt+c' -ScriptBlock { Invoke-FzfPsReadlineHandlerSetLocation }
            }
        }
        Set-PSReadLineKeyHandler -Chord 'Ctrl+r' -ScriptBlock { Initialize-PSFzf; Invoke-FzfPsReadlineHandlerHistory }
        Set-PSReadLineKeyHandler -Chord 'Ctrl+t' -ScriptBlock { Initialize-PSFzf; Invoke-FzfPsReadlineHandlerProvider }
        Set-PSReadLineKeyHandler -Chord 'Alt+c' -ScriptBlock { Initialize-PSFzf; Invoke-FzfPsReadlineHandlerSetLocation }
    }
}

# 视觉修正
$PSStyle.FileInfo.Directory = "`e[1;34m"
$PSStyle.FileInfo.Executable = "`e[1;32m"