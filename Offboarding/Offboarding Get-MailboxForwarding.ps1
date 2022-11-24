Offboarding Get-MailboxForwarding {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$userPrincipalName,
        [Parameter(Mandatory)]
        [string]$accessToken,
        [Parameter()]
        [string]$RuleName = 'Automation - Offboarding Forwarding'
    )
    begin {
        $headers = @{
            Authorization = "Bearer $accessToken"
        }
        $apiUrl = "https://graph.microsoft.com/v1.0/users/$userPrincipalName/mailFolders/inbox/messageRules"
    }
    process {
        $mailboxForwarding = Invoke-RestMethod -Uri $apiURL -Headers $headers -Method GET

    }
    end {
        return $mailboxForwarding.value | Where-Object {$_.DisplayName -eq $RuleName}
    }
}