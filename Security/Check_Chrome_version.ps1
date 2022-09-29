## Getting Chrome version; because in the current climate the zero in zero-day stands for the amount of days since the last 0-Day

$ResultWow6432 = (Get-ItemProperty -Path HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_ -match 'Chrome' } | Select-Object -ExpandProperty DisplayVersion)
$Result = (Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_ -match 'Chrome' } | Select-Object -ExpandProperty DisplayVersion)

Write-Output -InputObject ("Version Wow6432: {0}`r" -f ($ResultWow6432))
Write-Output -InputObject ("Version: {0}`r" -f ($Result))
