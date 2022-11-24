function Remove-UserLicenses {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$userPrincipalName,
        [Parameter(Mandatory)]
        [string]$accessToken,
        [Parameter(Mandatory)]
        [string]$LicenseSkuID
    )
    begin {
        $headers = @{
            Authorization = "Bearer $accessToken"
        }
        $apiUrl = "https://graph.microsoft.com/v1.0/users/$userPrincipalName/assignLicense"
    }
    process {
        $body = @{
            addLicenses = @()
            removeLicenses= @($LicenseSkuID)
        } | ConvertTo-Json -Depth 10
        $removeLicense = Invoke-RestMethod -Uri $apiURL -Headers $headers -Method POST -Body $body -ContentType "application/json"
    }
    end {
        return $removeLicense
    }
}