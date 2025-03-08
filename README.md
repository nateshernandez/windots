<h1 align="center">windots</h1>

My personal Windows dotfiles. Automatically installs dependencies and configures shell.

## ✅ Requirements

1. [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

## 🚀 Installation

1. Clone the repository.
2. Create a new PowerShell profile: `New-Item -Path $PROFILE -ItemType "file" -Force`
3. Run `./Setup.ps1` from an elevated PowerShell prompt.
4. Copy the contents `./windowsterminal/settings.json` into your [Windows Terminal settings file](https://learn.microsoft.com/en-us/windows/terminal/install#settings-json-file).
