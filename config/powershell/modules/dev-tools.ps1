# =============================================================================
#  Dev Tools Module
#  通用开发辅助工具
# =============================================================================

# 1. [kill-port] 杀掉占用端口的进程
# -----------------------------------------------------------
# 痛点：启动服务器提示 "Port 8080 already in use"
# 用法：kill-port 8080
function kill-port {
    param([int]$port)
    if (-not $port) { Write-Error "请指定端口号 (如: kill-port 3000)"; return }

    $tcp = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
    if ($tcp) {
        $pidTarget = $tcp.OwningProcess
        $process = Get-Process -Id $pidTarget -ErrorAction SilentlyContinue

        if ($process) {
            Write-Host "🔪 发现占用端口 $port 的进程: $($process.ProcessName) (PID: $pidTarget)" -ForegroundColor Yellow
            Stop-Process -Id $pidTarget -Force
            Write-Host "✅ 进程已处决。" -ForegroundColor Green
        } else {
            Write-Warning "找到端口占用，但无法获取进程信息 (可能需要管理员权限)。"
        }
    } else {
        Write-Host "🕊️ 端口 $port 未被占用。" -ForegroundColor Gray
    }
}

# 2. [paths] 漂亮地打印 PATH 环境变量
# -----------------------------------------------------------
# 痛点：$env:PATH 是一坨长长的字符串，根本没法看
function paths {
    $env:PATH -split ';' | Where-Object { $_ -ne "" } | ForEach-Object {
        if (Test-Path $_) {
            Write-Host $_ -ForegroundColor Cyan
        } else {
            Write-Host "$_ [无效路径]" -ForegroundColor DarkGray
        }
    }
}

# 3. [uuid] 生成随机 UUID
# -----------------------------------------------------------
# 痛点：测试时经常需要一个唯一 ID
function uuid {
    [guid]::NewGuid().ToString() | Set-Clipboard
    Write-Host "✅ UUID 已复制到剪贴板" -ForegroundColor Green
    [guid]::NewGuid().ToString()
}

# 4. [whatip] 查看本机 IP
# -----------------------------------------------------------
function whatip {
    Get-NetIPAddress -AddressFamily IPv4 |
    Where-Object { $_.InterfaceAlias -notmatch "Loopback|vEthernet" } |
    Select-Object InterfaceAlias, IPAddress |
    Format-Table -AutoSize
}

function ee {
    param (
        [string]$filePath
    )
    Start-Process "D:\Program\EverEdit\EverEdit.exe" -ArgumentList "$filePath"
}

# ===============================================
# 5. Antigravity 后台启动方案 (使用 ANTIGRAVITY_HOME 环境变量)
# 使用方法：
# 1. 配置环境变量 ANTIGRAVITY_HOME 指向 Antigravity 的根安装目录。
# 2. 在终端输入 agy 或 agy . 即可。
# ===============================================
# function agy {
#     $envHome = $env:ANTIGRAVITY_HOME
#     if (-not $envHome) {
#         Write-Error "错误：环境变量 ANTIGRAVITY_HOME 未设置。"
#         return
#     }

#     $appPath = Join-Path -Path $envHome -ChildPath "\antigravity.exe"

#     if (-not (Test-Path $appPath)) {
#         Write-Error "错误：找不到 Antigravity 可执行文件: $appPath"
#         return
#     }

#     if ($args.Length -eq 0) {
#         Write-Host "用法：请输入要打开的目录或文件路径，例如 agy ." -ForegroundColor Yellow
#         return
#     }

#     Write-Host "正在使用 Start-Job 在完全分离的后台启动 Antigravity (.exe 方式)..." -ForegroundColor Cyan

#     # === 关键修复 ===
#     # 将 $appPath 和 $args 合并成一个单一的数组，供 Job 内部使用
#     $jobParameters = @($appPath) + $args

#     # 在后台 Job 中启动进程
#     Start-Job -ScriptBlock {
#         # $jobParameters 在 Job 内部就是 $args
#         # 我们使用 call operator (&) 来执行这个路径，并将后续参数直接传递
#         $command = $args[0]
#         $arguments = $args[1..($args.Length - 1)]

#         # 使用 Start-Process 确保它完全独立于当前 Job 的控制台
#         Start-Process -FilePath $command -ArgumentList $arguments -NoNewWindow

#     } -ArgumentList $jobParameters
#     # =================

#     Write-Host "命令已发送到后台。请检查应用是否打开。" -ForegroundColor Green
# }
