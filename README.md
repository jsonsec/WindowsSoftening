# Windows Softening

This repo contains PowerShell scripts that perform some rather questionable actions, specifically aimed at softening a windows image by  disabling Windows Updates and Windows Defender, UAC, Firewall, etc. Use these scripts with extreme caution and be fully aware of the security implications.

## Scripts
### 0. `Soften.ps1`

This script is the combination of all other scripts executed in one go.

### 1. `DisableWinUpdates.ps1`

This script permanently disables Windows Updates by stopping the relevant services, disabling associated scheduled tasks, and preventing notifications. It ensures that Windows Updates won't restart on their own.

### 2. `DisableWinDefender.ps1`

This script modifies the Windows Registry to permanently disable Windows Defender, including its real-time protection features. The script creates necessary registry keys and sets values to disable various Defender functionalities.

### 3. `DisableWinFW.ps1`


### 4. `DisableUAC.ps1`


### 5. `DisableExecutionPolicy.ps1`

