$ErrorActionPreference = "Stop"

$repo = Resolve-Path (Join-Path $PSScriptRoot "..")

winget install --id Microsoft.PowerShell --source winget --accept-package-agreements --accept-source-agreements
winget install --id JanDeDobbeleer.OhMyPosh --source winget --accept-package-agreements --accept-source-agreements

$fonts = Join-Path $repo "fonts\ttf"
$fontShell = New-Object -ComObject Shell.Application
$fontFolder = $fontShell.Namespace(0x14)
Get-ChildItem $fonts -Filter "*.ttf" | ForEach-Object {
    $fontFolder.CopyHere($_.FullName, 0x10)
}

$profileDir = Join-Path $HOME "Documents\PowerShell"
New-Item -ItemType Directory -Force -Path $profileDir | Out-Null
Copy-Item (Join-Path $repo "win\powershell\Microsoft.PowerShell_profile.ps1") `
    (Join-Path $profileDir "Microsoft.PowerShell_profile.ps1") -Force

Copy-Item (Join-Path $repo "win\git\.gitconfig") `
    (Join-Path $HOME ".gitconfig") -Force

$terminalDir = Join-Path $env:LOCALAPPDATA "Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
New-Item -ItemType Directory -Force -Path $terminalDir | Out-Null
Copy-Item (Join-Path $repo "win\terminal\settings.json") `
    (Join-Path $terminalDir "settings.json") -Force

Write-Host "Done. Open PowerShell 7."
