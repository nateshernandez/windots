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

# Cursor
if ( $installedWingetPackages -notmatch "Anysphere.Cursor" ) {
	Write-Output "Installing Cursor"
	winget install --id Anysphere.Cursor --source winget
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
# PowerShell Installations
#
# -----------------

# Path Refresh
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# posh-git
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force

# -----------------
#
# Symlinks (Destination => Source)
#
# -----------------

$symlinks = @{
	$PROFILE = "./Profile.ps1"
}

Write-Host "Creating Symbolic Links..."

foreach ($symlink in $symlinks.GetEnumerator()) {
	Get-Item -Path $symlink.Key -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
	New-Item -ItemType SymbolicLink -Path $symlink.Key -Target (Resolve-Path $symlink.Value) -Force | Out-Null
}

Write-Host "Created Symbolic Links..."
