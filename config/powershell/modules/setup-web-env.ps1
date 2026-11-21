# ==============================================================================
#  Web Development Environment Setup (Full Config Edition)
#  Filename: setup-env.ps1 (或 web-dev-env.ps1)
#  Command: Set-WebDevEnv
# ==============================================================================

function Setup-Web-Env {
    <#
    .SYNOPSIS
        一键部署前端开发环境 (Mise + Full Isolation).
    .DESCRIPTION
        1. 写入配置文件
        2. 设置 3 个核心环境变量 (Bun隔离, Npm隔离, Npm配置指向)
        3. 建立软链接
    #>
    
    $ErrorActionPreference = "Stop"
    Write-Host "🔥 正在部署前端环境 (Mise + Full Env Vars)..." -ForegroundColor Cyan

    # 1. 路径定义
    $UserDir      = $env:USERPROFILE
    $DataBase     = "D:/Program/Develop/web" 
    $ConfigBase   = "$UserDir/.config/web"
    $NpmRcFile    = "$ConfigBase/npmrc"
    $PnpmRcFile   = "$ConfigBase/pnpmrc"
    $BunFigFile   = "$ConfigBase/bunfig.toml"
    
    # 软链接路径
    $NpmLink      = "$UserDir\.npmrc"
    $BunLink      = "$UserDir\.bunfig.toml"

    # 2. 检查 D 盘
    if (-not (Test-Path "D:/")) { Write-Error "❌ 错误: 找不到 D 盘！"; return }

    # 3. 初始化目录
    Write-Host "`n[1/5] 初始化目录..." -ForegroundColor Yellow
    if (-not (Test-Path $ConfigBase)) { New-Item -ItemType Directory -Force -Path $ConfigBase | Out-Null }
    
    $DataDirs = @("npm-cache", "pnpm-store", "pnpm-cache", "bun-cache", "pnpm-state")
    foreach ($dir in $DataDirs) {
        $targetPath = "$DataBase/$dir"
        if (-not (Test-Path $targetPath)) {
            New-Item -ItemType Directory -Force -Path $targetPath | Out-Null
            Write-Host "    📂 确认数据目录: $targetPath" -ForegroundColor Gray
        }
    }

    # 4. 写入配置文件
    Write-Host "`n[2/5] 写入配置文件..." -ForegroundColor Yellow
    # npmrc
    Set-Content -Path $NpmRcFile -Encoding UTF8 -Value "registry=https://registry.npmmirror.com/`ncache=$DataBase/npm-cache"
    # pnpmrc
    Set-Content -Path $PnpmRcFile -Encoding UTF8 -Value "store-dir=$DataBase/pnpm-store`ncache-dir=$DataBase/pnpm-cache`nstate-dir=$DataBase/pnpm-state`nregistry=https://registry.npmmirror.com/`nloglevel=warn"
    # bunfig
    Set-Content -Path $BunFigFile -Encoding UTF8 -Value "[install]`nregistry = `"https://registry.npmmirror.com/`"`nrequest-timeout = 30000`nidle-timeout = 30000`n`n[install.cache]`ndir = `"$DataBase/bun-cache`"`ndisableManifest = true"
    Write-Host "    📝 配置文件已生成" -ForegroundColor Gray

    # 5. 刷新软链接 (先做链接，再设变量指向链接)
    Write-Host "`n[3/5] 刷新软链接..." -ForegroundColor Yellow
    $Links = @(
        @{ Src = "$UserDir\.npmrc"; Target = $NpmRcFile },
        @{ Src = "$UserDir\.bunfig.toml"; Target = $BunFigFile },
        @{ Src = "$env:LOCALAPPDATA\pnpm\config\rc"; Target = $PnpmRcFile; Dir = "$env:LOCALAPPDATA\pnpm\config" }
    )
    foreach ($L in $Links) {
        if ($L.Dir -and -not (Test-Path $L.Dir)) { New-Item -ItemType Directory -Force -Path $L.Dir | Out-Null }
        if (Test-Path $L.Src) { Remove-Item -Force $L.Src }
        try { New-Item -ItemType SymbolicLink -Path $L.Src -Target $L.Target | Out-Null } catch {}
    }
    Write-Host "    🔗 软链接已就绪" -ForegroundColor Green

    # 6. 设置系统环境变量 (显式设置所有变量)
    Write-Host "`n[4/5] 设置系统环境变量..." -ForegroundColor Yellow
    
    # (A) Bun 缓存隔离
    $BunCachePath = "$DataBase/bun-cache"
    [System.Environment]::SetEnvironmentVariable("BUN_INSTALL_CACHE_DIR", $BunCachePath, "User")
    $env:BUN_INSTALL_CACHE_DIR = $BunCachePath
    Write-Host "    ✅ [BUN] 缓存隔离: BUN_INSTALL_CACHE_DIR = $BunCachePath" -ForegroundColor Green

    # (B) NPM 缓存隔离
    $NpmCachePath = "$DataBase/npm-cache"
    [System.Environment]::SetEnvironmentVariable("NPM_CONFIG_CACHE", $NpmCachePath, "User")
    $env:NPM_CONFIG_CACHE = $NpmCachePath
    Write-Host "    ✅ [NPM] 缓存隔离: NPM_CONFIG_CACHE = $NpmCachePath" -ForegroundColor Green

    # (C) NPM 配置指向 -> 指向用户目录下的软链接 (.npmrc)
    # 这里的路径使用软链接的绝对路径
    [System.Environment]::SetEnvironmentVariable("NPM_CONFIG_USERCONFIG", $NpmLink, "User")
    $env:NPM_CONFIG_USERCONFIG = $NpmLink
    Write-Host "    ✅ [NPM] 强制配置: NPM_CONFIG_USERCONFIG = $NpmLink" -ForegroundColor Green

    # 7. 自动清理
    Write-Host "`n[5/5] 检查残留..." -ForegroundColor Yellow
    $LeakPath = "$env:APPDATA\npm-cache"
    if (Test-Path $LeakPath) {
        Remove-Item -Recurse -Force $LeakPath
        Write-Host "    🧹 已删除 C 盘残留 npm-cache" -ForegroundColor Green
    }

    Write-Host "`n🎉 部署完成！" -ForegroundColor Cyan
    Write-Host "⚠️  请重启 PowerShell 以确保一切稳妥。" -ForegroundColor Yellow
}