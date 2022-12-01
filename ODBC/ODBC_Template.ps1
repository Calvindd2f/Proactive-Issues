<#
Calvin ODBD
Check for the SQL Driver
#>

function Get-Sqlver
{
  param
  (
    [Parameter(Mandatory=$true, ValueFromPipeline=$true, HelpMessage='Data to filter')]
    [Object]$InputObject
  )
  process
  {
    if ($InputObject.Name -cmatch 'SQL*')
    {
      $InputObject
    }
  }
}

$Check =  Get-OdbcDriver | Get-Sqlver

if ($Check -cnotmatch 'SQL') 
{
    Write-Output -InputObject 'Drivers Installed already'
}

if ($Check -cmatch 'SQL') 
{
    Write-Output -InputObject 'downloading'
    Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?linkid=2202930&clcid=0x409' -OutFile $env:TEMP\SQLx64.Driver.msi
    Set-Location -Path $env:TEMP 
  & "$env:windir\system32\msiexec.exe" /i .\SQLx64.Driver.msi /quiet
    Write-Output -InputObject 'done'
}


<#
Add the new DSN
Disable Perf Counter
#>
$NewDsn = Add-OdbcDsn -Name 'Client' -DriverName 'SQL Server Native Client 10.0' -DsnType 'System' -SetPropertyValue @('Server=SQLSERVER', 'Trusted_Connection=Yes', 'Database=Client', 'Description=Client') -PassThru
Invoke-Command -ScriptBlock $NewDsn
Disable-OdbcPerfCounter -InputObject
Write-Output -InputObject 'finished without error'
