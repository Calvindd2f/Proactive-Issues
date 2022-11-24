function Get-MailboxSettings {
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
        $apiUrl = "https://graph.microsoft.com/beta/users/$userPrincipalName/mailboxSettings"
    }
    process {
        $mailboxSettings = Invoke-RestMethod -Uri $apiURL -Headers $headers -Method GET
    }
    end {
        return $mailboxSettings
    }
}