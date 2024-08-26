#Soften Windows 10/11
Write-Host "By running this script you ackowledge that you'll be removing all security settins from your Windows Installation making it prone to attack. All revert must be done manually"

Write-Host "1. Disabling Windows Defender"
# Path to Windows Defender policies
$defenderPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender"

# Create the key if it doesn't exist
if (-not (Test-Path $defenderPath)) {
    New-Item -Path $defenderPath -Force | Out-Null
}

# Disable AntiSpyware
New-ItemProperty -Path $defenderPath -Name "DisableAntiSpyware" -Value 1 -PropertyType DWORD -Force | Out-Null

# Path to Real-Time Protection settings
$realTimeProtectionPath = "$defenderPath\Real-Time Protection"

# Create the Real-Time Protection key if it doesn't exist
if (-not (Test-Path $realTimeProtectionPath)) {
    New-Item -Path $realTimeProtectionPath -Force | Out-Null
}

# Disable various real-time protection features
New-ItemProperty -Path $realTimeProtectionPath -Name "DisableBehaviorMonitoring" -Value 1 -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $realTimeProtectionPath -Name "DisableOnAccessProtection" -Value 1 -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $realTimeProtectionPath -Name "DisableScanOnRealtimeEnable" -Value 1 -PropertyType DWORD -Force | Out-Null

Write-Host "Windows Defender has been permanently disabled"

Write-Host "2. Disabling Powershell Execution Policy"
Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force
Write-Host "Execution Policy Set to Unrestricted"


Write-Host "3. Now Disabling Firewall"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Write-Host "Firewall Disabled"

Write-Host "4. Now Disabling Firewall"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Write-Host "Firewall Disabled"

Write-Host "5. Now Disabling UAC"
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA' -Value 0 -Force
Write-Host "5. UAC Disabled"

Write-Host "Your Windows Instance is now officially SOFT. Please Restart your Computer"



