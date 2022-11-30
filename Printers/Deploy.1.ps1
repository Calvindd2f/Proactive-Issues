set-ErrorAction SilentlyContinue
Expand-Archive -Path .\drivers.zip -DestinationPath .\

if ($env:USERDNSDomai -eq $null)
{
pnputil.exe /a ".\drivers\XeroxAltaLinkC81xx_PCL6.inf"
Add-PrinterDriver -Name "Xerox AltaLink C8145 V4 PCL6" -InfPath "C:\Windows\System32\DriverStore\FileRepository\xeroxaltalinkc81xx_pcl6.inf_amd64_cd97e831cee685b7\XeroxAltaLinkC81xx_PCL6.inf"
Add-PrinterPort -Name "1234 Xerox" -PrinterHostAddress "1.2.3.4"
Add-Printer -DriverName "Xerox AltaLink C8145 V4 PCL6" -Name "1234 Xerox" -PortName "1234 Xerox"
}

Write-Host "Diag"
Write-Host "Site Name:" $env:CS_PROFILE_NAME
Write-Host ""
Write-Host ""
Get-Item -Path ".\drivers.zip"
Get-Item -Path "C:\Windows\System32\DriverStore\FileRepository\xeroxaltalinkc81xx_pcl6.inf_amd64_cd97e831cee685b7\XeroxAltaLinkC81xx_PCL6.inf"
Get-Item -Path ".\drivers\XeroxAltaLinkC81xx_PCL6.inf"
Write-Host ""
ping 1.2.3.4
Write-Host "checking if the printer installed sucessfully"
Get-Printer -Name "211 Call Center" | Format-List

if ((Get-Printer -Name "211 Call Center" | Format-List) -eq $null) {exit 1}
