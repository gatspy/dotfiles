#Requires -Version 7.0
<#
  ============================================================================
  Dotfiles Windows Bootstrap (PowerShell 引导器)
  ============================================================================
  用法:
    pwsh -File script\bootstrap.ps1              # 部署（缺啥建啥，幂等）
    pwsh -File script\bootstrap.ps1 -CheckOnly    # 只检查不改动

  设计原则（与 script/bootstrap bash 版对齐）:
    - 目标已是正确链接  → 跳过
    - 目标是其他链接    → 报告并跳过（不擅自改向）
    - 目标是普通文件/目录 → 改名为 *.bootstrap-bak-<时间戳> 后建链（永不直接删除）
    - 文件符号链接失败（未开开发者模式/无管理员）→ 回退为拷贝并警告
  ============================================================================
#>
param(
    [switch]$CheckOnly,
    [switch]$FixPath
)

$ErrorActionPreference = 'Stop'
$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$U        = $env:USERPROFILE
$Stamp    = Get-Date -Format 'yyyyMMdd-HHmmss'

# ──────────────────────────────────────────────────────────────────────────
# 工具函数
# ──────────────────────────────────────────────────────────────────────────

function Write-Step { param($m) Write-Host "› $m" -ForegroundColor Cyan }
function Write-Ok   { param($m) Write-Host "  ✅ $m" -ForegroundColor Green }
function Write-Skip { param($m) Write-Host "  ⏭  $m" -ForegroundColor DarkGray }
function Write-Warn2 { param($m) Write-Host "  ⚠️  $m" -ForegroundColor Yellow }

# 判定目标当前状态: CorrectLink / OtherLink / RealFile / RealDir / Missing
function Get-LinkState {
    param([string]$Path, [string]$ExpectedTarget)
    if (-not (Test-Path $Path)) { return 'Missing' }
    $item = Get-Item $Path -Force
    if ($item.LinkType) {
        $actual = if ($item.Target) { ($item.Target | Select-Object -First 1) } else { $null }
        if ($actual -and ((Resolve-Path $actual -ErrorAction SilentlyContinue).Path -eq
                          (Resolve-Path $ExpectedTarget -ErrorAction SilentlyContinue).Path)) { return 'CorrectLink' }
        return 'OtherLink'
    }
    if ($item.PSIsContainer) { return 'RealDir' }
    return 'RealFile'
}

# 目录 junction（免管理员）；已存在实体目录则先备份改名
function Set-DirJunction {
    param([string]$Link, [string]$Target)
    $state = Get-LinkState $Link $Target
    switch ($state) {
        'CorrectLink' { Write-Skip "$Link （已是正确链接）"; return $true }
        'OtherLink'   { Write-Warn2 "$Link 指向其他位置，跳过（请手工处理）"; return $false }
        default {
            if ($state -eq 'RealDir') {
                $bak = "${Link}.bootstrap-bak-$Stamp"
                Rename-Item $Link $bak
                Write-Warn2 "原目录已备份: $bak"
            }
            if (-not (Test-Path (Split-Path $Link))) { New-Item -ItemType Directory -Force (Split-Path $Link) | Out-Null }
            New-Item -ItemType Junction -Path $Link -Target $Target | Out-Null
            Write-Ok "$Link -> $Target (junction)"
            return $true
        }
    }
}

# 文件符号链接（失败回退拷贝）；已存在实体文件则先备份改名
function Set-FileLink {
    param([string]$Link, [string]$Target)
    $parent = Split-Path $Link
    if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Force $parent | Out-Null }
    $state = Get-LinkState $Link $Target
    switch ($state) {
        'CorrectLink' { Write-Skip "$Link （已是正确链接）"; return $true }
        'OtherLink'   { Write-Warn2 "$Link 指向其他位置，跳过（请手工处理）"; return $false }
        default {
            if ($state -eq 'RealFile') {
                $bak = "${Link}.bootstrap-bak-$Stamp"
                Rename-Item $Link $bak
                Write-Warn2 "原文件已备份: $bak"
            }
            try {
                New-Item -ItemType SymbolicLink -Path $Link -Target $Target -Force | Out-Null
                Write-Ok "$Link -> $Target (symlink)"
            } catch {
                Copy-Item $Target $Link -Force
                Write-Warn2 "$Link 无法建符号链接（需开发者模式或管理员），已回退为拷贝"
            }
            return $true
        }
    }
}

# ──────────────────────────────────────────────────────────────────────────
# 环境检查
# ──────────────────────────────────────────────────────────────────────────

Write-Step '环境检查'
$RepoRoot | ForEach-Object { Write-Ok "仓库根: $_" }
foreach ($tool in 'git', 'pwsh', 'mise', 'starship', 'zoxide', 'scoop', 'gh') {
    $cmd = Get-Command $tool -ErrorAction SilentlyContinue
    if ($cmd) { Write-Ok "$tool : $($cmd.Source)" }
    else      { Write-Warn2 "$tool : 未安装（对应功能将不可用）" }
}
Write-Host ''

# 用户级 PATH 修复：mise shims 前置（双轨第一轨）+ 去重（不动机器级 PATH）
function Repair-UserPath {
    $candidates = @(
        "$env:MISE_INSTALL_DIR\shims",
        "$env:LOCALAPPDATA\mise\shims",
        'D:\Program\Develop\mise\shims'
    ) | Where-Object { $_ -and (Test-Path $_) }
    if (-not $candidates) { Write-Warn2 '找不到 mise shims 目录，跳过 PATH 修复'; return }
    # 注意：管道单元素输出会退化为标量字符串，必须 @() 包一层再取下标，
    # 否则 $candidates[0] 取到的是字符串首字符（曾因此把裸 'D' 写进 PATH）
    $miseShims = @($candidates)[0]
    $current = [Environment]::GetEnvironmentVariable('Path', 'User') -split ';'
    # 清理无效条目（空串 / 裸盘符）+ 精确去重，保持其余原序
    $clean = @($miseShims) + ($current | Where-Object { $_ -and ($_ -notmatch '^[A-Za-z]:?$') -and ($_ -ne $miseShims) } | Select-Object -Unique)
    [Environment]::SetEnvironmentVariable('Path', ($clean -join ';'), 'User')
    $env:Path = $clean -join ';'
    Write-Ok "用户 PATH 已修复：前置 $miseShims，清理无效条目并去重（共 $($clean.Count) 条）"
}

if ($FixPath) {
    Write-Step '用户 PATH 修复（-FixPath）'
    Repair-UserPath
    Write-Host ''
}

# ──────────────────────────────────────────────────────────────────────────
# 链接清单（junction 目录 + symlink 文件）
# ──────────────────────────────────────────────────────────────────────────

$junctions = @(
    @{ Link = "$U\.config\powershell"; Target = "$RepoRoot\config\powershell" }
)

$links = @(
    @{ Link = "$U\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"; Target = "$RepoRoot\config\powershell\Microsoft.PowerShell_profile.ps1" }
    @{ Link = "$U\.config\mise\config.toml";                              Target = "$RepoRoot\config\mise\config.toml.symlink" }
    @{ Link = "$U\.config\starship.toml";                                 Target = "$RepoRoot\config\starship.windows.toml" }
    @{ Link = "$U\.gitconfig";                                            Target = "$RepoRoot\git\gitconfig.windows.symlink" }
    @{ Link = "$U\.gitmessage";                                           Target = "$RepoRoot\git\gitmessage.symlink" }
    @{ Link = "$U\.config\git\ignore";                                    Target = "$RepoRoot\config\git\ignore.symlink" }
)

# Windows Terminal（UWP 打包路径存在才处理）
$wtSettings = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
if (Test-Path (Split-Path $wtSettings)) {
    $links += @{ Link = $wtSettings; Target = "$RepoRoot\config\windows-terminal\settings.json" }
}

# Scoop 清单（仓库已有该文件才处理；A4 阶段生成）
$scoopManifest = "$RepoRoot\config\scoop\scoopfile.json"
if (Test-Path $scoopManifest) {
    $links += @{ Link = "$U\.config\scoop\scoopfile.json"; Target = $scoopManifest }
}

# ──────────────────────────────────────────────────────────────────────────
# 执行
# ──────────────────────────────────────────────────────────────────────────

Write-Step '目录 junction'
$ok = $true
foreach ($j in $junctions) {
    if ($CheckOnly) { Write-Host "  [check] $($j.Link) => $(Get-LinkState $j.Link $j.Target)" -ForegroundColor DarkCyan }
    else            { $ok = (Set-DirJunction $j.Link $j.Target) -and $ok }
}

Write-Step '文件符号链接'
foreach ($l in $links) {
    if ($CheckOnly) { Write-Host "  [check] $($l.Link) => $(Get-LinkState $l.Link $l.Target)" -ForegroundColor DarkCyan }
    else            { $ok = (Set-FileLink $l.Link $l.Target) -and $ok }
}

Write-Host ''
if ($CheckOnly) {
    Write-Host '（-CheckOnly 模式仅做干跑检查，不应有改动发生）' -ForegroundColor Cyan
    return
}

# ──────────────────────────────────────────────────────────────────────────
# 一次性环境动作清单（不自动执行，逐项人工确认）
# ──────────────────────────────────────────────────────────────────────────

Write-Host '──────────────────────────────────────────────────────────' -ForegroundColor Cyan
Write-Host ' 一次性动作清单（按需人工执行，详见 docs/windows-setup.md）' -ForegroundColor Cyan
Write-Host '──────────────────────────────────────────────────────────' -ForegroundColor Cyan
Write-Host @'
 1. PATH 双轨修复: pwsh -File script\bootstrap.ps1 -FixPath（mise shims 前置 + 去重）
 2. Defender 排除（管理员 PowerShell）:
    Add-MpPreference -ExclusionPath @("$env:LOCALAPPDATA\mise", "D:\Program\Develop\mise", "$env:USERPROFILE\.cargo", "$env:USERPROFILE\.rustup", "D:\Program\Scoop\main")
 3. Go 代理刻入全局（[env] 的 GOPROXY 在 mise 解析期不生效）:
    go env -w GOPROXY=https://goproxy.cn,direct
 4. Scoop 卸载已由 mise 接管的 CLI（28 项，见 docs/windows-setup.md）
 5. 清理 mise Roaming 残留: Remove-Item -Recurse -Force "$env:APPDATA\mise"（存在才删）
 6. 工具收敛: mise reshim --force; mise prune -y
'@
Write-Host ''
if ($ok) { Write-Host '🎉 Windows 部署完成！重开 Windows Terminal 标签页验证。' -ForegroundColor Green }
else     { Write-Host '⚠️ 部署部分完成，上方有 ⚠️ 项需人工处理。' -ForegroundColor Yellow }
