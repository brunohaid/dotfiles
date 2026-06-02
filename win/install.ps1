$ErrorActionPreference = "Stop"

$repo = Resolve-Path (Join-Path $PSScriptRoot "..")
$ompInit = 'oh-my-posh init pwsh --config "$HOME\dotfiles\omp\brunoshell.omp.json" | Invoke-Expression'

try {
    Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force
} catch {
    Write-Warning "Could not set PowerShell execution policy automatically. If profile scripts do not load, run: Set-ExecutionPolicy -Scope CurrentUser RemoteSigned"
}

winget install --id Microsoft.PowerShell --source winget --accept-package-agreements --accept-source-agreements
winget install --id JanDeDobbeleer.OhMyPosh --source winget --accept-package-agreements --accept-source-agreements

$fonts = Join-Path $repo "fonts\ttf"
$fontShell = New-Object -ComObject Shell.Application
$fontFolder = $fontShell.Namespace(0x14)
Get-ChildItem $fonts -Filter "*.ttf" | ForEach-Object {
    $fontFolder.CopyHere($_.FullName, 0x10)
}

$documentsDir = [Environment]::GetFolderPath("MyDocuments")
foreach ($profileDirName in @("PowerShell", "WindowsPowerShell")) {
    $profileDir = Join-Path $documentsDir $profileDirName
    $profilePath = Join-Path $profileDir "Microsoft.PowerShell_profile.ps1"
    New-Item -ItemType Directory -Force -Path $profileDir | Out-Null
    if (-not (Test-Path $profilePath)) {
        New-Item -ItemType File -Path $profilePath | Out-Null
    }
    if (-not (Select-String -Path $profilePath -SimpleMatch $ompInit -Quiet)) {
        Add-Content -Path $profilePath -Value "`n$ompInit"
    }
}

Copy-Item (Join-Path $repo "win\git\.gitconfig") `
    (Join-Path $HOME ".gitconfig") -Force

$terminalDir = Join-Path $env:LOCALAPPDATA "Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
New-Item -ItemType Directory -Force -Path $terminalDir | Out-Null
Copy-Item (Join-Path $repo "win\terminal\settings.json") `
    (Join-Path $terminalDir "settings.json") -Force

Write-Host "Done. Open PowerShell 7."
