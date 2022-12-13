#	Adding a network printer

```powershell
(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection("\\Printserver01\Xerox5")
```

##	Setting a default printer

```powershell
(New-Object -ComObject WScript.Network).SetDefaultPrinter('HP LaserJet 5Si')
```

##	Removing a printer connection

```powershell
(New-Object -ComObject WScript.Network).RemovePrinterConnection("\\Printserver01\Xerox5")
```

#	Creating a network share

```powershell
Invoke-CimMethod -ClassName Win32_Share -MethodName Create -Arguments @{
    Path = 'C:\temp'
    Name = 'TempShare'
    Type = [uint32]0 #Disk Drive
    MaximumAllowed = [uint32]25
    Description = 'test share of the temp folder'
}
```

##	Removing a network share

```powershell
$wql = 'SELECT * from Win32_Share WHERE Name="TempShare"'
Invoke-CimMethod -MethodName Delete -Query $wql
```

##	Connecting a Windows network drive

```powershell
New-PSDrive -Persist -Name "X" -PSProvider "FileSystem" -Root "\\Server01\Public"
```

*Persistently mapped drives may not be available when running in an elevated context.*


#	Installing applications

```powershell
Invoke-CimMethod -ClassName Win32_Product -MethodName Install -Arguments @{PackageLocation='\\AppSrv\dsp\NewPackage.msi'}

```

#	Removing applications

```powershell
Get-CimInstance -Class Win32_Product -Filter "Name='ILMerge'" |
    Invoke-CimMethod -MethodName Uninstall
```
