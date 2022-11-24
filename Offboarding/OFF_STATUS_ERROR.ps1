Elseif ($i.status -eq "Error")
    {
        #If we could not find the user in Azure AD, attempt to self clear
        if ($i.notes -like "*User was not found*") {
            $User = Searchfor-User -UPN $i.Title -AccessToken $token.access_token
            if ($User) {
                $Notes = $Notes.Replace("User was not found in Azure AD","")
            }
        }
        #See if the error was because of the forwarding user not being in Azure AD
        if ($i.notes -like "*Forwarding user was not found*") {
            $ForwardingUser = Searchfor-User -UPN $i.ForwardingAddress -AccessToken $token.access_token
            if ($ForwardingUser) {
                $Notes = $Notes.Replace("Forwarding user was not found in Azure AD","")
            }
        }

        If ($Notes -notlike "*not*")
        {
            #If our notes contain no errors, we know all have cleared and we can set the status to Pending again
            Set-ListItemField -AccessToken $token.access_token -Field "Status" -ItemNumber $i.id -Data "Pending" -listID '1baffb5c-d51a-4803-b534-2a83c3c867fd' -siteID 'bwya77.sharepoint.com,218d5607-899f-4ec4-888a-0657c4fa2b11,af51a2a9-880d-4109-a7b1-84962fafb8a2' 
        }
    }