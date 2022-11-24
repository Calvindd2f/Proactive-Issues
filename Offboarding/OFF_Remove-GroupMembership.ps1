function Remove-GroupMembership {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$userID,
        [Parameter(Mandatory)]
        [string]$accessToken,
        [Parameter(Mandatory)]
        [string]$GroupID
    )
    begin {
        $headers = @{
            Authorization = "Bearer $accessToken"
        }
        $apiUrl = "https://graph.microsoft.com/v1.0/groups/$GroupID/members/$userID/`$ref"
    }
    process {
        $removeGroupMember = Invoke-RestMethod -Uri $apiURL -Headers $headers -Method DELETE
    }
    end {
        return $removeGroupMember
    }
}