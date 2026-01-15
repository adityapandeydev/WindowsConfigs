$ErrorActionPreference = 'SilentlyContinue'

$wallpaperDir = "$env:APPDATA\Microsoft\Windows\Themes"
$wallpaperFile = "TranscodedWallpaper"
$matugenConfig = "C:\Users\AdityaPandey\Documents\Configs\matugen\matugen.toml"

function Update-Theme {
    $path = Join-Path $wallpaperDir $wallpaperFile
    if (Test-Path $path) {
        # Generate new starship config based on current wallpaper without prompting
        matugen image $path -c $matugenConfig --source-color-index 0
    }
}

# Run once at startup to ensure it's synced
Update-Theme

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $wallpaperDir
$watcher.Filter = $wallpaperFile
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

$action = {
    # Brief delay to ensure file isn't locked by Windows
    Start-Sleep -Milliseconds 500
    Update-Theme
}

Register-ObjectEvent $watcher "Changed" -Action $action | Out-Null
Register-ObjectEvent $watcher "Created" -Action $action | Out-Null

Write-Host "Watching for wallpaper changes in $wallpaperDir..."

# Keep the script alive
while ($true) {
    Start-Sleep -Seconds 10
}
