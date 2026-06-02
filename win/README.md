# Windows setup

From the dotfiles repo root, run PowerShell as your user:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
.\win\install.ps1
```

This installs PowerShell 7 and Oh My Posh, installs the Berkeley Mono fonts from `fonts/ttf`, appends the Oh My Posh init line to both PowerShell 7 and Windows PowerShell profiles, and copies Windows Terminal settings and Git config.

The installer uses Windows' actual Documents folder, so it works whether Documents is local or redirected to OneDrive. Windows Terminal is configured to default to PowerShell 7.
