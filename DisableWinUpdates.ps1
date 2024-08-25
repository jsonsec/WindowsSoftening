# Stop updates
Stop-Service -Name "wuauserv" -Force

# Disable it
Set-Service -Name "wuauserv" -StartupType Disabled

# Disable update tasks
$tasks = @(
    "Microsoft\Windows\UpdateOrchestrator\Schedule Scan",
    "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_Display",
    "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_ReadyToReboot",
    "Microsoft\Windows\WindowsUpdate\sih",
    "Microsoft\Windows\WindowsUpdate\sihboot"
)

foreach ($task in $tasks) {
    schtasks /Change /TN $task /Disable
}

# Stop and disable Medic Service
Stop-Service -Name "WaaSMedicSvc" -Force
Set-Service -Name "WaaSMedicSvc" -StartupType Disabled

# Remove Active Hours
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "ActiveHoursStart" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "ActiveHoursEnd" -ErrorAction SilentlyContinue

# No update notifications
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\WindowsUpdate" -Name "NOC_GLOBAL_SETTING_TOASTS_ENABLED" -Value 0 -ErrorAction SilentlyContinue

# Disable automatic update restart
$rebootSettings = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update"
if (-not (Test-Path $rebootSettings)) {
    New-Item -Path $rebootSettings -Force | Out-Null
}
Set-ItemProperty -Path $rebootSettings -Name "NoAutoRebootWithLoggedOnUsers" -Value 1 -PropertyType DWORD -Force | Out-Null

# Disable Windows Defender via registry

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

# Disable Windows Defender Security Center Notifications
$securityCenterPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\WindowsDefender\Windows Defender Security Center"
if (-not (Test-Path $securityCenterPath)) {
    New-Item -Path $securityCenterPath -Force | Out-Null
}
New-ItemProperty -Path $securityCenterPath -Name "Enabled" -Value 0 -PropertyType DWORD -Force | Out-Null

# Disable Tamper Protection (Windows 11 specific)
$tamperProtectionPath = "HKLM:\SOFTWARE\Microsoft\Windows Defender\Features"
if (-not (Test-Path $tamperProtectionPath)) {
    New-Item -Path $tamperProtectionPath -Force | Out-Null
}
New-ItemProperty -Path $tamperProtectionPath -Name "TamperProtection" -Value 0 -PropertyType DWORD -Force | Out-Null

Write-Host "Ready To Install FlairVM"
