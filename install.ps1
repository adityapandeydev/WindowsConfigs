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

Write-Host "Done!"
