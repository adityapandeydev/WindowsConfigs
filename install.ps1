$ErrorActionPreference = 'Stop'

Write-Host "Setting up Windows Configs..."

$repoPath = $PSScriptRoot
$psProfileSrc = Join-Path $repoPath "PowerShell\Microsoft.PowerShell_profile.ps1"
$psProfileDest = Join-Path $env:USERPROFILE "Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# Create destination folder if not exists
$psProfileDir = Split-Path $psProfileDest -Parent
if (-not (Test-Path $psProfileDir)) {
    New-Item -ItemType Directory -Path $psProfileDir | Out-Null
}

# Create Symlink
if (Test-Path $psProfileDest) {
    Remove-Item $psProfileDest -Force
}
New-Item -ItemType SymbolicLink -Path $psProfileDest -Target $psProfileSrc | Out-Null

# Create Startup Shortcut for Matugen Watcher
$startupFolder = [Environment]::GetFolderPath('Startup')
$shortcutPath = Join-Path $startupFolder "MatugenWatcher.lnk"
$wshShell = New-Object -ComObject WScript.Shell
$shortcut = $wshShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = Join-Path $repoPath "matugen\Start-Watcher.vbs"
$shortcut.WorkingDirectory = Join-Path $repoPath "matugen"
$shortcut.Save()

Write-Host "Done!"
