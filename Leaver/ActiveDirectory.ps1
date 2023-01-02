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

## CreateOU -name "Groups" -path "DC=ad,DC=example,DC=com" -description "What a wonderful OU this is"


#Find Disabled Users outside this OU ; then move them to the OU

#Find user that is leaving.

#Disable User Account.

#Reset Password

#Clear Group Membership

#Set description "Disabled - Date"

#Move that user to Disabled Users OU

-- Check for ADSyncServer ; if it exists , Run a delta sync. If not, exit.
