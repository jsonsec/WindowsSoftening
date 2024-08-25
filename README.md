# badideas

Welcome to the **badideas** repository! This repo contains PowerShell scripts that perform some rather questionable actions, specifically aimed at disabling Windows Updates and Windows Defender. Use these scripts with caution and be fully aware of the security implications.

## Scripts

### 1. `DisableWinUpdates.ps1`

This script permanently disables Windows Updates by stopping the relevant services, disabling associated scheduled tasks, and preventing notifications. It ensures that Windows Updates won't restart on their own.

### 2. `DisableWinDefender.ps1`

This script modifies the Windows Registry to permanently disable Windows Defender, including its real-time protection features. The script creates necessary registry keys and sets values to disable various Defender functionalities.

## PowerShell One-Liner

If you're feeling adventurous (or reckless), here's a one-liner that will download and execute both scripts directly from this repository:

```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/jsonsec/badideas/main/DisableWinUpdates.ps1')); iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/yourusername/badideas/main/DisableWinDefender.ps1'))
