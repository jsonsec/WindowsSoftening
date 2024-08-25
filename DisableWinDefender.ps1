# Perma Disable Windows Defender 
# Obviously you should know what youre doing before you run this, dont be an idiot, etc

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

Write-Host "Windows Defender has been permanently disabled, Be careful friend."