$env:STARSHIP_CONFIG = 'C:\Users\AdityaPandey\Documents\Configs\Prompt-Configs\starship_matugen.toml'
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
Set-Alias ff fastfetch

# Source functions
function gs { git status }
function ga { git add . }
function gpu { git push }
function gca { git commit -m "$args" }
function gsca {git commit -S -m "$args"}
function lst { lsd --tree }
function q { exit }
function .. { cd .. }

fnm env --use-on-cd | Out-String | Invoke-Expression

# Fastfetch startup
# $fastfetchConfig = 'C:\Users\AdityaPandey\Documents\Configs\fastfetch\config.jsonc'

# if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
#     fastfetch --config $fastfetchConfig
# }
