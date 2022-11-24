function Searchfor-User
{
	param (
		[system.string]$UPN,
		[system.string]$AccessToken
	)
	Begin
	{
		$request = @{
			Method = "Get"
			Uri    = "https://graph.microsoft.com/v1.0/users/?`$filter=(userPrincipalName eq '$UPN')"
			ContentType = "application/json"
			Headers = @{ Authorization = "Bearer $AccessToken" }
		}
	}
	Process
	{
		$Data = Invoke-RestMethod @request
	}
	End
	{
        return $Data
	}
}