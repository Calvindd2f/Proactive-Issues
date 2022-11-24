Function Connect-GraphAPI {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$clientID,
        [Parameter(Mandatory)]
        [string]$tenantID,
        [Parameter(Mandatory)]
        [string]$clientSecret
    )
    begin {
        $ReqTokenBody = @{
            Grant_Type    = "client_credentials"
            Scope		  = "https://graph.microsoft.com/.default"
            client_Id	  = $clientID
            Client_Secret = $clientSecret
        }
    }
    process {

        $tokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody

    }
    end {
        return $tokenResponse
    }

}
