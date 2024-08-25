# Perm Disable all win updates
# Obviously you should know what youre doing before you run this, dont be an idiot, etc
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

Write-Host "Windows Update wont bug you again."
