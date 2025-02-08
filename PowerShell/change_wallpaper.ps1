$wallpaperFolder = "D:\Aditya\Wallpapers"
$wallpapers = Get-ChildItem -Path "$wallpaperFolder\*" -File | Where-Object { $_.Extension -match "jpg|jpeg|png|webp" } | Get-Random
$currentWallpaper = Get-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name WallPaper
$nextWallpaper = $wallpapers | Where-Object { $_.FullName -ne $currentWallpaper.WallPaper } | Select-Object -First 1

If ($nextWallpaper) {
    $path = $nextWallpaper.FullName
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

    [Wallpaper]::SetWallpaper($path)
}

# powershell.exe -ExecutionPolicy Bypass -File "C:\Users\AdityaPandey\Documents\PowerShell\change_wallpaper.ps1"