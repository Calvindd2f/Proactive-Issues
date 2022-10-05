#Calvin ODBD

#1. Check for the SQL Driver

$Check =  Get-OdbcDriver | ? { $_.Name -cmatch 'SQL*'}

if ($Check -cnotmatch 'SQL') 
{
    echo 'Drivers Installed already'
}

if ($Check -cmatch 'SQL') 
{
    echo 'downloading'
    iwr 'https://go.microsoft.com/fwlink/?linkid=2202930&clcid=0x409' -OutFile $env:TEMP\SQLx64.Driver.msi
    cd $env:TEMP 
  & "$env:windir\system32\msiexec.exe" /i .\SQLx64.Driver.msi /quiet
    echo 'done'
}


#2. Add the new DSN

$NewDsn = Add-OdbcDsn -Name 'Client' -DriverName 'SQL Server Native Client 10.0' -DsnType 'System' -SetPropertyValue @('Server=SQLSERVER', 'Trusted_Connection=Yes', 'Database=Client', 'Description=Client') -PassThru

#3.Disable Perf Counter

Disable-OdbcPerfCounter -InputObject


#4. End

Echo 'finished without error'
