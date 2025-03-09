$wallpaperFolder = "D:\Aditya\Wallpapers"
$lastWallpaperFile = "$wallpaperFolder\lastWallpaper.txt"

# Get all wallpapers sorted numerically
$wallpapers = Get-ChildItem -Path "$wallpaperFolder\*" -File | 
    Where-Object { $_.Extension -match "jpg|jpeg|png|webp" } | 
    Sort-Object { [int]($_.BaseName) }  # Sort based on numerical order

# Read the last used wallpaper number
if (Test-Path $lastWallpaperFile) {
    $lastUsed = Get-Content $lastWallpaperFile
    $lastUsed = [int]$lastUsed
} else {
    $lastUsed = 0  # Start from the first wallpaper if no history exists
}

# Find the next wallpaper
$nextWallpaper = $wallpapers | Where-Object { [int]($_.BaseName) -gt $lastUsed } | Select-Object -First 1

# If no next wallpaper is found, start from the first one
if (-not $nextWallpaper) {
    $nextWallpaper = $wallpapers | Select-Object -First 1
}

if ($nextWallpaper) {
    $path = $nextWallpaper.FullName

    # Save the current wallpaper number for next run
    $nextNumber = [int]$nextWallpaper.BaseName
    Set-Content -Path $lastWallpaperFile -Value $nextNumber

    # C# Interop for setting wallpaper
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
        public static void SetWallpaper(string path) {
            SystemParametersInfo(20, 0, path, 3);
        }
    }
"@ -Language CSharp

    # Set the new wallpaper
    [Wallpaper]::SetWallpaper($path)
}

# powershell.exe -ExecutionPolicy Bypass -File "C:\Users\AdityaPandey\Documents\PowerShell\change_wallpaper.ps1"