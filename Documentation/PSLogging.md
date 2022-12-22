# Loggging your scripts in powershell


```powershell
$Logfile = "$env:USERPROFILE\log.txt"<#
    if (!(Test-Path $Logfile)){
    New-Item -path "C:\users\c\" -name "log.txt" -type "file"
    }
    Else{
    break
   }#>

# Get-DateSortable
function Get-datesortable
{
  $global:datesortable = Get-Date -Format "HH':'mm':'ss"
  return $global:datesortable
}# Get-DateSortable


# Add-Logs
function Add-Logs
{
  [CmdletBinding()]
  param ([Object]$text)
  Get-datesortable
  Add-content -Path $Logfile -Value ('[{0}] - {1}' -f $global:datesortable, $text)
  
  Set-Alias -Name alogs -Value Add-Logs -Description 'Add shit to Logs'
  Set-Alias -Name Add-Log -Value Add-Logs -Description 'Add shit to Logs'
}# Add Logs


Add-Logs "$env:COMPUTERNAME is cool"
Add-Logs "$env:LOGONSERVER is not cool" 
```

### OUTPUT

```powershell
PS C:\Users\c> cat .\log.txt

[01:41:03] - EXIT is ass
[01:41:03] - \\EXIT is not ass
```
