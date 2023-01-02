function Connect-Tenant {
     <#
    .Description
    This function uses the various PowerShell modules to establish
    a connection to an M365 Tenant associated with provided
    credentials
    .Functionality
    Internal
    #>
    param (
    [Parameter(Mandatory=$true)]
    [string]
    $ProductNames,

    [Parameter(Mandatory=$false)]
    [string]
    $Endpoint
    )
	
	# Initialize variable
	$EXOAuthRequired = $true
    	$SPOAuthRequired = $true
    	$AADAuthRequired = $true
	
	# Get length of ProductNames array
	$len = $ProductNames.length
	
	# Loop through ProductNames
	foreach ($Product in $ProductNames) {
		switch ($Product) {
            {($_ -eq "exo") -or ($_ -eq "defender")} {
                if ($EXOAuthRequired) {
                    Connect-ExchangeOnline -ShowBanner:$false | Out-Null
                    Write-Verbose "Defender will require a sign in every single run regardless of what the LogIn parameter is set"
                    $EXOAuthRequired = $false
                }
            }
            "aad" {
                Connect-MgGraph -Scopes User.Read.All, Policy.Read.All, Organization.Read.All, UserAuthenticationMethod.Read.All, RoleManagement.Read.Directory, GroupMember.Read.All, Policy.ReadWrite.AuthenticationMethod, Directory.Read.All -ErrorAction Stop | Out-Null
                Select-MgProfile Beta | Out-Null
                $AADAuthRequired = $false
            }
            "powerplatform"{
                if (!$Endpoint) {
                    Write-Output "Power Platform needs an endpoint please specify one as a script arg"
                }
                else {
                    Add-PowerAppsAccount -Endpoint $Endpoint | Out-Null
                }
            }
            {($_ -eq "onedrive") -or ($_ -eq "sharepoint")} {
                if ($AADAuthRequired) {
                    Connect-MgGraph | Out-Null
                    Select-MgProfile Beta | Out-Null
                    $AADAuthRequired = $false
                }
                if ($SPOAuthRequired) {
                    $InitialDomain = (Get-MgOrganization).VerifiedDomains | Where-Object {$_.isInitial}
                    $InitialDomainPrefix = $InitialDomain.Name.split(".")[0]
                    Connect-SPOService -Url "https://$($InitialDomainPrefix)-admin.sharepoint.com" | Out-Null
                    $SPOAuthRequired = $false
                }
            }
            "teams" {
                Connect-MicrosoftTeams | Out-Null
            }
            default {
                Write-Error -Message "Invalid ProductName argument"
            }
        }
		$Progress = ($ProductNames.IndexOf($Product))/$len
		Write-Progress -Activity "Authenticating to each service" -Status "Authenticating to $($Product); $($ProductNames.IndexOf($Product)) of $($Len) Products authenticated to." -PercentComplete $Progress
    }
    Write-Progress -Activity "Authenticating to each service" -Status "Ready" -Completed
}

function Disconnect-Tenant {
    <#
    .Description
    This function disconnects the various PowerShell module sessions from the
    M365 Tenant. Useful to disconnect then connect to other M365 tenants
    Currently Disconect-MgGraph is buggy and may not disconnect properly.
    .Functionality
    Public
    #>
    Disconnect-MicrosoftTeams # Teams
    Disconnect-MgGraph # AAD
    Disconnect-ExchangeOnline -Confirm:$false -InformationAction Ignore -ErrorAction SilentlyContinue | Out-Null # Exchange and Defender
    Remove-PowerAppsAccount # Power Platform
    Disconnect-SPOService # OneDrive and Sharepoint
}

Export-ModuleMember -Function @(
    'Connect-Tenant',
    'Disconnect-Tenant'
)
