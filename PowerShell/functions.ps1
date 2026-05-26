# Function for multi-word commands
function gs { git status }
function ga { git add . }
function gpu { git push }
function gca { git commit -m "$args" }
function gsca {git commit -S -m "$args"}
function lst { lsd --tree }
function q { exit }
function .. { cd .. }
