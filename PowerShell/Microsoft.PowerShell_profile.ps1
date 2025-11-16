Invoke-Expression (&starship init powershell)

Import-Module -Name Terminal-Icons

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