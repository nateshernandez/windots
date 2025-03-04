#Requires -RunAsAdministrator

# -----------------
#
# Winget packages
#
# -----------------

# Upgrade packages
# Write-Output "Upgrading packages..."
# winget upgrade --all

$installedWingetPackages = winget list | Out-String

# Chrome
if ( $installedWingetPackages -notmatch "Google.Chrome" ) {
	Write-Output "Installing Google Chrome..."
	winget install --id Google.Chrome --source winget
}

# Powershell Core
if ( $installedWingetPackages -notmatch "Microsoft.PowerShell" ) {
	Write-Output "Installing PowerShell Core..."
	winget install --id Microsoft.PowerShell --source winget
}

# Flow Launcher
if ( $installedWingetPackages -notmatch "Flow-Launcher.Flow-Launcher" ) {
	Write-Output "Installing Flow Launcher..."
	winget install --id Flow-Launcher.Flow-Launcher --source winget
}

# Oh My Posh
if ( $installedWingetPackages -notmatch "JanDeDobbeleer.OhMyPosh" ) {
	Write-Output "Installing Oh My Posh..."
	winget install --id JanDeDobbeleer.OhMyPosh --source winget
}

# Git
if ( $installedWingetPackages -notmatch "Git.Git" ) {
	Write-Output "Installing Git..."
	winget install --id Git.Git --source winget
}

# Github CLI
if ( $installedWingetPackages -notmatch "GitHub.cli" ) {
	Write-Output "Installing GitHub CLI..."
	winget install --id GitHub.cli --source winget
}

# NVM
if ( $installedWingetPackages -notmatch "CoreyButler.NVMforWindows" ) {
	Write-Output "Installing NVM for Windows..."
	winget install --id CoreyButler.NVMforWindows --source winget
}

# Visual Studio 2022
if ( $installedWingetPackages -notmatch "Microsoft.VisualStudio.2022.Community" ) {
	Write-Output "Installing Visual Studio 2022..."
	winget install --id Microsoft.VisualStudio.2022.Community --source winget
}

# Cursor
if ( $installedWingetPackages -notmatch "Anysphere.Cursor" ) {
	Write-Output "Installing Cursor..."
	winget install --id Anysphere.Cursor --source winget
}

# Python
if ( $installedWingetPackages -notmatch "Python.Python.3.11" ) {
	Write-Output "Installing Python 3.11..."
	winget install --id Python.Python.3.11 --source winget
}

# LMStudio
if ( $installedWingetPackages -notmatch "ElementLabs.LMStudio" ) {
	Write-Output "Installing LMStudio..."
	winget install --id ElementLabs.LMStudio --source winget
}

# More...

# Chocolatey
if ( $installedWingetPackages -notmatch "Chocolatey.Chocolatey" ) {
	Write-Output "Installing Chocolatey..."
	winget install --id Chocolatey.Chocolatey --source winget
}

# -----------------
#
# Chocolatey Packages
#
# -----------------

# Path Refresh
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$installedChocolateyPackages = choco list --limit-output --id-only | Out-String

# Cascadia Code Nerd Font
if ( $installedChocolateyPackages -notmatch "nerd-fonts-cascadiacode") {
	Write-Output "Installing Cascadia Code Nerd Font..."
	choco install nerd-fonts-cascadiacode -y
}

# Terminal Icons
if ( $installedChocolateyPackages -notmatch "terminal-icons.powershell") {
	Write-Output "Installing PowerShell Terminal Icons..."
	choco install terminal-icons.powershell -y
}

# -----------------
#
# Symlinks (Destination => Source)
#
# -----------------

$symlinks = @{
	$PROFILE                 = "./Profile.ps1"
	"$env:LOCALAPPDATA/nvim" = "./nvim"
}

Write-Host "Creating Symbolic Links..."
foreach ($symlink in $symlinks.GetEnumerator()) {
	Get-Item -Path $symlink.Key -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
	New-Item -ItemType SymbolicLink -Path $symlink.Key -Target (Resolve-Path $symlink.Value) -Force | Out-Null
}
Write-Host "Created Symbolic Links..."
