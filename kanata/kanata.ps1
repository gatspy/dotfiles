<#
.SYNOPSIS
  Manager for the Kanata key remapper on Windows.

.DESCRIPTION
  Installs the gui (system tray) binary variant, validates the config and
  registers a log-on scheduled task. Daily use = tray icon only.

  Layout:
    Binaries : D:\Program\Kanata  (override with -InstallDir; the chosen
               directory is persisted, later commands reuse it automatically)
    Config   : %USERPROFILE%\.config\kanata (win.kbd + shared-layers.kbd)

  Variant mapping:
    Phase 1 -> winIOv2 build    (admin only, no extra driver)
    Phase 2 -> wintercept build (requires the Interception driver)
  Only *_cmd_allowed builds are installed: app launchers use (cmd ...) actions.

.PARAMETER Action
  install  Download the release zip, extract the tray variant, validate config
  check    Validate win.kbd without starting
  start    Start kanata (tray icon appears)
  stop     Stop kanata and the scheduled task
  restart  stop + start
  task     Register the log-on scheduled task (highest privileges, no time limit)
  untask   Remove the scheduled task
  status   Show process / task state and the last log lines

.PARAMETER Phase
  1 (default) winIOv2, 2 wintercept. Only meaningful for install.

.PARAMETER Version
  Kanata release version to install. Default: 1.12.0

.PARAMETER InstallDir
  Target directory for the binary. Default: D:\Program\Kanata

.EXAMPLE
  .\kanata.ps1 install -Phase 1
  .\kanata.ps1 install -Phase 1 -InstallDir "E:\Tools\kanata"
  .\kanata.ps1 task          # self-elevates via UAC when needed
  .\kanata.ps1 status
  .\kanata.ps1 install -Phase 2   # after installing the Interception driver
#>
[CmdletBinding()]
param(
  [Parameter(Position = 0)]
  [ValidateSet('install', 'check', 'start', 'stop', 'restart', 'task', 'untask', 'status')]
  [string]$Action = 'status',

  [ValidateSet('1', '2')]
  [string]$Phase = '1',

  # Version per phase (empty = auto). Phase 1 rides the LLHOOK path, which
  # has a state-sync regression in v1.12.0 (issue #2115), so it pins 1.11.0.
  # Phase 2 uses the wintercept build -- a different code path immune to
  # that bug -- and tracks the latest release.
  [string]$Version = '',

  # Optional: path to OpenInputBridge's redist\x64\interception.dll. When
  # given (with -Phase 2), it replaces the stock interception.dll next to
  # the binary so kanata talks to the actively maintained OIB driver.
  [string]$OibDll = '',

  [string]$InstallDir = ''
)

$ErrorActionPreference = 'Stop'

$VersionByPhase = @{ '1' = '1.11.0'; '2' = '1.12.0' }
if ($Version -eq '') { $Version = $VersionByPhase[$Phase] }

$ConfigDir       = Join-Path $env:USERPROFILE '.config\kanata'
$MainCfg         = Join-Path $ConfigDir 'win.kbd'
$LogFile         = Join-Path $ConfigDir 'kanata.log'
$ErrFile         = Join-Path $ConfigDir 'kanata.err.log'
$InstallDirState = Join-Path $ConfigDir 'install-dir.txt'
$DefaultInstallDir = 'D:\Program\Kanata'
$TaskName        = 'Kanata'
$ZipUrl          = "https://github.com/jtroo/kanata/releases/download/v$Version/windows-binaries-x64.zip"

# Resolve the binary directory: explicit -InstallDir wins, then the value
# persisted by a previous install, then the default.
if ($InstallDir -ne '') {
  $resolvedInstallDir = $InstallDir.TrimEnd('\')
} elseif (Test-Path $InstallDirState) {
  $resolvedInstallDir = (Get-Content $InstallDirState -Raw).Trim()
} else {
  $resolvedInstallDir = $DefaultInstallDir
}
$KanataExe = Join-Path $resolvedInstallDir 'kanata.exe'

# The gui build runs as a system tray application (no console window).
$VariantByPhase = @{
  '1' = "kanata_windows_gui_winIOv2_cmd_allowed_x64.exe"
  '2' = "kanata_windows_gui_wintercept_cmd_allowed_x64.exe"
}

function Test-IsAdmin {
  $identity  = [Security.Principal.WindowsIdentity]::GetCurrent()
  $principal = New-Object Security.Principal.WindowsPrincipal($identity)
  return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Invoke-SelfElevated {
  param([string[]]$PassthroughArgs)
  Write-Host "Elevating to Administrator (accept the UAC prompt)..." -ForegroundColor Yellow
  $argList = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $PSCommandPath) + $PassthroughArgs
  Start-Process -FilePath 'powershell.exe' -Verb RunAs -ArgumentList $argList
}

function Assert-ConfigPresent {
  if (-not (Test-Path $MainCfg)) {
    throw "Config not found: $MainCfg. Sync your dotfiles first."
  }
}

function Invoke-ConfigCheck {
  Assert-ConfigPresent
  # The gui build is a GUI-subsystem binary: a plain `&` invocation returns
  # before the process exits and $LASTEXITCODE is garbage. -Wait -PassThru
  # blocks until completion and yields the real exit code.
  $proc = Start-Process -FilePath $KanataExe -ArgumentList @('--check', '--cfg', $MainCfg) -Wait -PassThru -NoNewWindow
  if ($proc.ExitCode -ne 0) { throw "Config validation failed for $MainCfg (exit $($proc.ExitCode))" }
  Write-Host "Config OK: $MainCfg" -ForegroundColor Green
}

function Invoke-Install {
  $zipPath = Join-Path $env:TEMP "kanata-$Version-x64.zip"
  $extractDir = Join-Path $env:TEMP "kanata-$Version-x64"

  Write-Host "Downloading $ZipUrl ..."
  Invoke-WebRequest -Uri $ZipUrl -OutFile $zipPath -UseBasicParsing
  $zipSize = (Get-Item $zipPath).Length
  if ($zipSize -lt 1MB) {
    throw "Downloaded file is only $zipSize bytes - probably an error page, not the release zip."
  }

  if (Test-Path $extractDir) { Remove-Item $extractDir -Recurse -Force }
  Expand-Archive -Path $zipPath -DestinationPath $extractDir -Force

  try {
    New-Item -ItemType Directory -Path $resolvedInstallDir -Force | Out-Null
  } catch [System.UnauthorizedAccessException] {
    throw "Cannot create $resolvedInstallDir (access denied). Re-run elevated: install -Phase $Phase -InstallDir `"$resolvedInstallDir`""
  }

  $src = Join-Path $extractDir $VariantByPhase[$Phase]
  if (-not (Test-Path $src)) { throw "Variant not found in zip: $src" }
  Copy-Item $src $KanataExe -Force
  Write-Host "  installed $KanataExe (system tray variant)"

  if ($Phase -eq '2' -and $OibDll -ne '') {
    if (-not (Test-Path $OibDll)) { throw "OibDll not found: $OibDll" }
    Copy-Item $OibDll (Join-Path $resolvedInstallDir 'interception.dll') -Force
    Write-Host "  installed OIB interception.dll"
  }

  New-Item -ItemType Directory -Path $ConfigDir -Force | Out-Null
  Set-Content -Path $InstallDirState -Value $resolvedInstallDir -Encoding ASCII

  Remove-Item $zipPath -Force
  Remove-Item $extractDir -Recurse -Force

  Assert-ConfigPresent
  Invoke-ConfigCheck
  Write-Host "`nInstalled Phase $Phase tray binary to $resolvedInstallDir and validated config." -ForegroundColor Green

  if ($Phase -eq '2') {
    Write-Host "Reminder: Phase 2 needs the Interception driver installed beforehand." -ForegroundColor Yellow
  }
}

function Invoke-Start {
  Assert-ConfigPresent
  $existingTask = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
  if ($existingTask) {
    Start-ScheduledTask -TaskName $TaskName
    Write-Host "Started scheduled task '$TaskName' (tray icon should appear)."
    return
  }

  if (-not (Test-Path $KanataExe)) { throw "Binary not found: $KanataExe. Run '.\kanata.ps1 install' first." }
  Start-Process -FilePath $KanataExe -ArgumentList @('--cfg', $MainCfg) -WorkingDirectory $resolvedInstallDir
  Write-Host "Started kanata. Look for the tray icon."
}

function Invoke-Stop {
  Get-Process -Name 'kanata' -ErrorAction SilentlyContinue | Stop-Process -Force
  $existingTask = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
  if ($existingTask) { Stop-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue }
  Write-Host "Stopped."
}

function Invoke-RegisterTask {
  Assert-ConfigPresent
  if (-not (Test-Path $KanataExe)) { throw "Binary not found: $KanataExe. Run '.\kanata.ps1 install' first." }

  $action   = New-ScheduledTaskAction -Execute $KanataExe -Argument "--cfg `"$MainCfg`"" -WorkingDirectory $resolvedInstallDir
  $trigger  = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME
  $principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -RunLevel Highest
  # ExecutionTimeLimit 0 disables the default 72h kill that would stop the
  # long-running remapper.
  $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries `
    -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 1) -ExecutionTimeLimit (New-TimeSpan -Seconds 0)

  $existingTask = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
  if ($existingTask) { Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false }
  Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger `
    -Principal $principal -Settings $settings | Out-Null
  Start-ScheduledTask -TaskName $TaskName
  Write-Host "Scheduled task '$TaskName' registered and started (runs at log-on, highest privileges)." -ForegroundColor Green
}

function Invoke-ShowStatus {
  $procs = Get-Process -Name 'kanata' -ErrorAction SilentlyContinue
  if ($procs) {
    $procs | ForEach-Object { Write-Host ("RUNNING  {0}  pid={1}" -f $_.Name, $_.Id) -ForegroundColor Green }
  } else {
    Write-Host "NOT RUNNING" -ForegroundColor Red
  }

  Write-Host ("BINARY   {0} (exists: {1})" -f $KanataExe, (Test-Path $KanataExe))

  $existingTask = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
  if ($existingTask) {
    Write-Host ("TASK     {0}  state={1}" -f $TaskName, $existingTask.State)
  } else {
    Write-Host "TASK     not registered"
  }

  if (Test-Path $LogFile) {
    Write-Host "`n--- last 5 log lines ---"
    Get-Content $LogFile -Tail 5
  }
}

# Admin is required to run the remapper and to register the task; install and
# check deliberately stay unprivileged (auto-elevates only on access denial).
$needsAdmin = @('start', 'stop', 'restart', 'task', 'untask') -contains $Action
if ($needsAdmin -and -not (Test-IsAdmin)) {
  Invoke-SelfElevated @('-Action', $Action, '-Phase', $Phase, '-Version', $Version, '-InstallDir', $resolvedInstallDir)
  exit 0
}

try {
  switch ($Action) {
    'install' { Invoke-Install }
    'check'   { Invoke-ConfigCheck }
    'start'   { Invoke-Start }
    'stop'    { Invoke-Stop }
    'restart' { Invoke-Stop; Start-Sleep -Seconds 1; Invoke-Start }
    'task'    { Invoke-RegisterTask }
    'untask'  { Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false; Write-Host "Task removed." }
    'status'  { Invoke-ShowStatus }
  }
} catch {
  Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
  exit 1
}
