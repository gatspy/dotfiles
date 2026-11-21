# ==============================================================================
#  Web Environment Cleaner (Registry Level Wipe)
#  Filename: remove-web-env.ps1
#  Command: Remove-WebDevEnv
# ==============================================================================

function Remove-Web-Env {
    <#
    .SYNOPSIS
        物理清除前端开发环境配置 (注册表级粉碎)。
    #>

    $ErrorActionPreference = "SilentlyContinue"
    $UserDir = $env:USERPROFILE
    
    Write-Host "🧹 正在物理粉碎前端环境配置..." -ForegroundColor Cyan

    # --------------------------------------------------------------------------
    # 1. 物理删除环境变量 (三维打击)
    # --------------------------------------------------------------------------
    Write-Host "`n[1/3] 粉碎环境变量..." -ForegroundColor Yellow
    
    $VarsToRemove = @(
        "BUN_INSTALL_CACHE_DIR", 
        "NPM_CONFIG_CACHE", 
        "NPM_CONFIG_USERCONFIG"
    )

    foreach ($var in $VarsToRemove) {
        # [A] 注册表层：直接删除 Key (最彻底的方法)
        # 这比 SetEnvironmentVariable($null) 更暴力，直接从注册表抹去字段
        Remove-ItemProperty -Path "HKCU:\Environment" -Name $var -ErrorAction SilentlyContinue
        
        # [B] 进程层：告诉当前进程这个变量没了
        [System.Environment]::SetEnvironmentVariable($var, $null, "Process")
        
        # [C] 会话层：从 PowerShell 驱动器强制移除 (解决“躺在那”的问题)
        if (Test-Path "env:\$var") {
            Remove-Item -Path "env:\$var" -Force
        }
        
        Write-Host "    💥 已销毁: $var" -ForegroundColor DarkGray
    }

    Write-Host "    ✅ 环境变量已彻底清空 (不留空壳)" -ForegroundColor Green

    # --------------------------------------------------------------------------
    # 2. 删除软链接
    # --------------------------------------------------------------------------
    Write-Host "`n[2/3] 拆除软链接..." -ForegroundColor Yellow

    $Links = @(
        "$UserDir\.npmrc",
        "$UserDir\.bunfig.toml",
        "$env:LOCALAPPDATA\pnpm\config\rc"
    )

    foreach ($link in $Links) {
        if (Test-Path $link) {
            Remove-Item -Force $link
            Write-Host "    🗑️  已删除: $link" -ForegroundColor Gray
        }
    }

    # --------------------------------------------------------------------------
    # 3. 删除配置目录
    # --------------------------------------------------------------------------
    Write-Host "`n[3/3] 删除配置中心..." -ForegroundColor Yellow
    
    $ConfigBase = "$UserDir\.config\web"
    if (Test-Path $ConfigBase) {
        Remove-Item -Recurse -Force $ConfigBase
        Write-Host "    🗑️  已移除: .config/web" -ForegroundColor Gray
    }

    Write-Host "`n========================================================" -ForegroundColor Cyan
    Write-Host " 🎉 清理完成！" -ForegroundColor Cyan
    Write-Host " ℹ️  请运行 'dir env:NPM*' 验证，绝对看不到它们了。" -ForegroundColor Yellow
    Write-Host "========================================================" -ForegroundColor Cyan
}