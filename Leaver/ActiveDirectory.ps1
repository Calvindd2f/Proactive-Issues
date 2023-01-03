# Check for / Create OU=Disabled Users
function CreateOU ([string]$name, [string]$path, [string]$description) {
    $ouDN = "OU=$name,$path"

    # Check if the OU exists
    try {
        Get-ADOrganizationalUnit -Identity $ouDN | Out-Null
        Write-Verbose "OU '$ouDN' already exists."
    }
    catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
        Write-Verbose "Creating new OU '$ouDN'"
        New-ADOrganizationalUnit -Name $name -Path $path -Description $description
    }
}
CreateOU -name "Disabled Users" -description "disabled user ou"

# Find Disabled Users outside this OU ; then move them to the OU
$ouDN = Get-ADOrganizationalUnit -Filter 'Name -like "Disabled Users"'

Get-ADUser -filter {Enabled -eq $false } | Foreach-object {
  Move-ADObject -Identity $_.DistinguishedName -TargetPath $ouDN
}
# Find user that is leaving.
$users = Get-ADUser *
foreach ($user in $users) {
    $env:firstname = $user.first
    $env:lastname = $user.last
    #Disable User Account.
    $lUSER = Get-ADUser -Filter 'GivenName -like $env:firstname -and sn -like $env:lastname'
    $lUSER | Disable-ADAccount
    }
    
# Reset Password
function Get-RandomPassword {
    param (
        [Parameter(Mandatory)]
        [int] $length,
        [int] $amountOfNonAlphanumeric = 1
    )
    Add-Type -AssemblyName 'System.Web'
    return [System.Web.Security.Membership]::GeneratePassword($length, $amountOfNonAlphanumeric)
}
$DisabledPassword = Get-RandomPassword 16
Set-ADAccountPassword -Identity $ADUSER -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$DisabledPassword" -Force)

# Clear Group Membership
Get-ADUser -Identity $ADUSER -Properties MemberOf | ForEach-Object {
  $_.MemberOf | Remove-ADGroupMember -Members $_.DistinguishedName -Confirm:$false
}

# Set description "Disabled - Date"
$Date = date
$Detailed = $Date.ToShortDateString() + ' ' + $Date.ToShortTimeString() + ' By: ' + $env:USERDOMAIN + '\' + $env:USERNAME
Set-ADUser -Description 'Disabled on "$Detailed"'

# Move that user to Disabled Users OU
Get-ADUser -filter {Enabled -eq $false } | Foreach-object {
  Move-ADObject -TargetPath $ouDN
}

# Check for ADSyncServer ; if it exists , Run a delta sync. If not, exit.
Start-ADSyncSyncCycle -PolicyType Delta -Force -ErrorAction SilentlyContinue

# Ending Comment
