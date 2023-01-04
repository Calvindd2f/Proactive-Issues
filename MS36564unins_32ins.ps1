# uninstall Microsoft Office if it is 64-bit . Then reinstall it as 32-bit.


# Uninstall Microsoft Office 64-bit 
$OfficeProgID = Get-ItemProperty HKLM:\Software\Classes\Installer\Products\* | Where-Object {$_.DisplayName -like "Microsoft*Office*"} | Select-Object -ExpandProperty ProgID
$Office64BitVersion = Get-ItemProperty HKLM:\Software\Classes\Installer\Products\$OfficeProgID | Select-Object -ExpandProperty Version | Where-Object {$_ -like "*x64*"}
if ($Office64BitVersion) {
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/x $OfficeProgID /qn" -Wait
}

# Install Microsoft Office 32-bit 
$Office32BitVersion = Get-ItemProperty HKLM:\Software\Classes\Installer\Products\$OfficeProgID | Select-Object -ExpandProperty Version | Where-Object {$_ -like "*x86*"}
if ($Office32BitVersion) {
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $OfficeProgID /qn" -Wait
}
