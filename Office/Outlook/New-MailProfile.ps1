function New-MailProfile
{
  <#
    .SYNOPSIS
    Create new mail profile
    .DESCRIPTION
   Nothing much, can't autofill creds
    .EXAMPLE
    Get-Something
    simplly call function
    can be multiple lines
    .EXAMPLE
    New-MailProfile
  #>
  # Script to create a new empty Outlook profile
  $ofc = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
  $OfficeInstall = Get-ChildItem -Path $ofc -Recurse | Where-Object {
    $_.GetValue('DisplayName') -like 'Microsoft Office*' -or $_.GetValue('DisplayName') -like 'Microsoft 365 Apps*'
  }
  
  # We only care about the major and minor version for the next part
  $Version = $OfficeInstall.GetValue('DisplayVersion')[0..3] -join ''
  $RegPath = ('HKCU:\SOFTWARE\Microsoft\Office\{0}\Outlook' -f $Version)
  
  New-Item -Path ('{0}\Profiles' -f $RegPath) -Name 'Zimbra Profile'
  Set-ItemProperty -Path $RegPath -Name 'DefaultProfile' -Value 'NewProfile'
  Write-Verbose -Message 'Restart Outlook to setup new profile'
}

