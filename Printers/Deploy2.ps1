$serverName  = 'Print_SRV01'       # Endpoint sharing printer.
$printerName = 'Printer2_MFP'      # Printer being shared.
 
$fullprinterName = '\\' + $serverName + '\' + $printerName + ' - ' + $(If ([System.Environment]::Is64BitOperatingSystem) {'x64'} Else {'x86'})
 
 $Computer = Get-ADComputer -Filter *

foreach ($Computer in $Computers)
{
  Remove-Printer -Name $fullprinterName -ErrorAction SilentlyContinue
  Add-Printer -ConnectionName $fullprinterName
}
