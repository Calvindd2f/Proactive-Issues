## Getting Chrome version; because in the current climate the zero in zero-day stands for the amount of days since the last 0-Day

$ResultWow6432 = (Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_ -match "Chrome" } | Select-Object -ExpandProperty DisplayVersion)
$Result = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_ -match "Chrome" } | Select-Object -ExpandProperty DisplayVersion)

if ($ResultWow6432) {
    
}
Write-Output "Version Wow6432: $($ResultWow6432)`r"
Write-Output "Version: $($Result)`r"
