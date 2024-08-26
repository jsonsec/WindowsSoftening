# Stop updates
Stop-Service -Name "wuauserv" -Force

# Disable it
Set-Service -Name "wuauserv" -StartupType Disabled

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
