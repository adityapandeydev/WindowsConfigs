Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

Import-Module -Name Terminal-Icons

Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView # Or InlineView
Set-PSReadLineOption -EditMode Windows

Import-Module PSFzf; Set-PsFzfOption -EnableAltC

# aliases
Set-Alias g git
Remove-Item Alias:ls -Force
Set-Alias ls lsd
Set-Alias c clear

# Function for multi-word commands
function gs { git status }
function ga { git add . }
function gpu { git push }
function gca { git commit -m "$args" }
function gsca {git commit -S -m "$args"}
function lst { lsd --tree }
function q { exit }
function .. { cd .. }

fnm env --use-on-cd | Out-String | Invoke-Expression

# F-14 Tactical Fastfetch startup
$f14FastfetchRoot = 'C:\Users\AdityaPandey\Documents\Configs\fastfetch\fastfetch-f14'
$f14FastfetchConfig = Join-Path $f14FastfetchRoot 'config.jsonc'

if ((Get-Command fastfetch -ErrorAction SilentlyContinue) -and
    (Test-Path -LiteralPath $f14FastfetchConfig)) {
    $env:FASTFETCH_F14_ROOT = $f14FastfetchRoot
    fastfetch --config $f14FastfetchConfig
}