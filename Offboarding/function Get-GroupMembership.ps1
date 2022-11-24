function Get-GroupMembership {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$userPrincipalName,
        [Parameter(Mandatory)]
        [string]$accessToken
    )
    begin {
        $headers = @{
            Authorization = "Bearer $accessToken"
        }
        $apiUrl = "https://graph.microsoft.com/v1.0/users/$userPrincipalName/memberOf"
    }
    process {
        $groupMembers = Invoke-RestMethod -Uri $apiURL -Headers $headers -Method GET
    }
    end {
        return $groupMembers.value | where-object {$_.roleTemplateId -eq $null}
    }
}