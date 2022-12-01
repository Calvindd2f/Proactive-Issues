$PrintNick = '211 Call Center'
$IP_OEM = '1234 Xerox'
$printerIP = '1.2.3.4'
$DriverDir = "$env:windir\System32\DriverStore\FileRepository\xeroxaltalinkc81xx_pcl6.inf_amd64_cd97e831cee685b7\XeroxAltaLinkC81xx_PCL6.inf"
$PrinterName = 'Xerox AltaLink C8145 V4 PCL6'
$inf = '.\drivers\XeroxAltaLinkC81xx_PCL6.inf'
$driverzip = '.\drivers.zip'
set-ErrorAction SilentlyContinue
Expand-Archive -Path $driverzip -DestinationPath .\

if ($env:USERDNSDomai -eq $null)
{
& "$env:windir\system32\pnputil.exe" /a $inf
Add-PrinterDriver -Name $PrinterName -InfPath $DriverDir
Add-PrinterPort -Name $IP_OEM -PrinterHostAddress $printerIP
Add-Printer -DriverName $PrinterName -Name $IP_OEM -PortName $IP_OEM
}

Write-Verbose -Message 'Diag'
Write-Verbose -Message 'Site Name:'
Write-Verbose -Message ''
Write-Verbose -Message ''
Get-Item -Path $driverzip
Get-Item -Path $DriverDir
Get-Item -Path $inf
Write-Verbose -Message ''
& "$env:windir\system32\ping.exe" $printerIP
Write-Verbose -Message 'checking if the printer installed sucessfully'
Get-Printer -Name $PrintNick | Format-List

if ((Get-Printer -Name $PrintNick | Format-List) -eq $null) {exit 1}
