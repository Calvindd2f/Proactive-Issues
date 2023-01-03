$env:firstname
$env:lastname
$LUSER = Get-ADUser -Filter 'GivenName -like "$env:firstname" -and sn -like "$env:lastname"'

$nameOU = "Disabled Users"
New-ADOrganizationUnit -Name $nameOU
$DN = Get-ADOrganizationalUnit -Filter 'Name -like "$nameOU"'

$Date = date
$Detailed = $Date.ToShortDateString() + ' ' + $Date.ToShortTimeString() + ' By: ' + $env:USERDOMAIN + '\' + $env:USERNAME

Get-ADuser $LUSER {
    Move-ADObject -TargetPath $DN
    Set-ADUser -Description "Disabled on $Detailed" -Identity $LUSER -Enabled $False
}
