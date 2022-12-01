function Use-Printer
{
  <#
    .SYNOPSIS
    Add a printer shared on a DC
    .DESCRIPTION
    Use-Printer -serverName DC-01  -printername CanonMFP_356i
    DC being the Domain Controller or Print Server. The printer name being the name that is displayed when you 
    navigate to \\DC-01.
    .EXAMPLE
    Use-Printer -serverName DC-01  -printername CanonMFP_356i
  #>
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory=$True, Position=0)]
    [System.String]
    $serverName = 'Print_SRV01',
    
    [Parameter(Mandatory=$True, Position=1)]
    [System.String]
    $printerName = 'Printer2_MFP'
  )
  $fullprinterName = '\\' + $serverName + '\' + $printerName + ' - ' + $(If ([Environment]::Is64BitOperatingSystem) {'x64'} Else {'x86'})
  
  Remove-Printer -Name $fullprinterName -ErrorAction SilentlyContinue
  Add-Printer -ConnectionName $fullprinterName
}

