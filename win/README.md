# Windows setup

From the dotfiles repo root, run PowerShell as your user:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
.\win\install.ps1
```

This installs PowerShell 7 and Oh My Posh, installs the Berkeley Mono fonts from `fonts/ttf`, and copies the PowerShell profile, Windows Terminal settings, and Git config.
