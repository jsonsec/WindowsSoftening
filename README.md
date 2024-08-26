# Windows Softening

This repo contains PowerShell scripts that perform some rather questionable actions, specifically aimed at softening a Windows image by disabling Windows Updates and Windows Defender, UAC, Firewall, etc. Use these scripts with extreme caution and be fully aware of the security implications.

> **Disclaimer:** These scripts will significantly reduce the security of your Windows installation. Running them will disable critical security features like Windows Updates, Windows Defender, UAC, and the Firewall. Only proceed if you fully understand the risks and are prepared for the consequences. These scripts should ideally be used in a controlled environment, such as a virtual machine, rather than on a production system. The author is not responsible for any damage or security breaches that may result from using these scripts.

## Scripts

### 0. Soften.ps1
This script is the combination of all other scripts executed in one go. It provides a one-click solution to apply all the "softening" modifications, making it convenient but also very potent. This script should be used with extra caution as it performs multiple significant changes to the system's security settings.

### 1. DisableWinUpdates.ps1
This script permanently disables Windows Updates by stopping the relevant services, disabling associated scheduled tasks, and preventing notifications. It ensures that Windows Updates won't restart on their own, thereby preventing the system from automatically receiving updates and patches.

### 2. DisableWinDefender.ps1
This script modifies the Windows Registry to permanently disable Windows Defender, including its real-time protection features. The script creates necessary registry keys and sets values to disable various Defender functionalities, effectively turning off the built-in antivirus protection.

### 3. DisableWinFW.ps1
This script disables the Windows Firewall across all profiles (Domain, Private, Public). It ensures that no firewall protection is active, potentially exposing the system to network-based attacks. The script stops the firewall services and prevents them from restarting.

### 4. DisableUAC.ps1
This script permanently disables User Account Control (UAC) by modifying the registry. UAC is responsible for prompting users when elevated privileges are required, and disabling it will remove those prompts, making it easier to run applications with administrative rights but increasing the risk of unintended changes or malware execution.

### 5. DisableExecutionPolicy.ps1
This script sets the PowerShell Execution Policy to `Unrestricted`, allowing all scripts to run without any restrictions. This change removes the built-in security feature that prevents the execution of potentially harmful scripts.

## Executing All Scripts with Winsoft.ps1
```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/jsonsec/WindowsSoftening/main/WinSoft.ps1'));
```
