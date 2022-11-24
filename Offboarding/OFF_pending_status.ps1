 if ($i.status -eq "Pending")
    {
        #Only search of the user if we have not done it prior 
        if ($i.notes -notlike "*User was found in Azure AD*")
        {
            if ($User) {
                $Notes += "User was found in Azure AD`n"

                #Set the email field in the SharePoint List
                $Notes += "Email Address: $($User.mail)`n"
                Set-ListItemField -AccessToken $token.access_token -Field "Email" -ItemNumber $i.id -Data $User.Mail -listID '1baffb5c-d51a-4803-b534-2a83c3c867fd' -siteID 'bwya77.sharepoint.com,218d5607-899f-4ec4-888a-0657c4fa2b11,af51a2a9-880d-4109-a7b1-84962fafb8a2' 

                #Get all licenses for the user
                $Licenses = Get-UserLicenses -userPrincipalName $user.userPrincipalName -accessToken $token.access_token
                #Iterate through all licenses and create a clean array
                $Licenses | foreach-object {
                    $licenseArray += "$($_.skupartnumber) `n"
                }
                #Get the mailbox type for the user (the property will be userPurpose)
                $mailboxSettings = Get-MailboxSettings -userPrincipalName $user.userPrincipalName -accessToken $token.access_token
                 
                #Write the mailbox type for the user
                $Notes += "Mailbox Type: $($mailboxSettings.userPurpose)`n"
                Set-ListItemField -AccessToken $token.access_token -Field "MailboxType" -ItemNumber $i.id -Data $mailboxSettings.userPurpose -listID '1baffb5c-d51a-4803-b534-2a83c3c867fd' -siteID 'bwya77.sharepoint.com,218d5607-899f-4ec4-888a-0657c4fa2b11,af51a2a9-880d-4109-a7b1-84962fafb8a2'   
                
                #Write the licenses the user has back to the SharePoint List
                $Notes += "Licenses: $($licenseArray)`n"
                Set-ListItemField -AccessToken $token.access_token -Field "Licenses" -ItemNumber $i.id -Data $licenseArray -listID '1baffb5c-d51a-4803-b534-2a83c3c867fd' -siteID 'bwya77.sharepoint.com,218d5607-899f-4ec4-888a-0657c4fa2b11,af51a2a9-880d-4109-a7b1-84962fafb8a2' 

                #Get the groups the user is a member of
                $groupMembership = Get-GroupMembership -userPrincipalName $user.userPrincipalName -accessToken $token.access_token
                $grouparray = @()
                $groupMembership | foreach-object {
                    $Notes += "Adding the Group: $($_.displayName)`n"
                    $grouparray += "$($_.displayName) `n"
                }
                Set-ListItemField -AccessToken $token.access_token -Field "Groups" -ItemNumber $i.id -Data $grouparray -listID '1baffb5c-d51a-4803-b534-2a83c3c867fd' -siteID 'bwya77.sharepoint.com,218d5607-899f-4ec4-888a-0657c4fa2b11,af51a2a9-880d-4109-a7b1-84962fafb8a2' 
            }
            Else {
                $Notes += "User was not found in Azure AD`n"
                #Set the status to Error
                Set-ListItemField -AccessToken $token.access_token -Field "Status" -ItemNumber $i.id -Data "Error" -listID '1baffb5c-d51a-4803-b534-2a83c3c867fd' -siteID 'bwya77.sharepoint.com,218d5607-899f-4ec4-888a-0657c4fa2b11,af51a2a9-880d-4109-a7b1-84962fafb8a2' 
            }
        }
        #Only search of the forwarding user if we have not done it prior
        if ($i.notes -notlike "*Forwarding user was found in Azure AD*") {
            #See if the forwarding user is in Azure Active Directory
            $ForwardingUser = Searchfor-User -UPN $i.ForwardingAddress -AccessToken $token.access_token
            if ($ForwardingUser) {
                $Notes += "Forwarding user was found in Azure AD`n"
            }
            Else {
                $Notes += "Forwarding user was not found in Azure AD`n"
                #Set the status to Error
                Set-ListItemField -AccessToken $token.access_token -Field "Status" -ItemNumber $i.id -Data "Error" -listID '1baffb5c-d51a-4803-b534-2a83c3c867fd' -siteID 'bwya77.sharepoint.com,218d5607-899f-4ec4-888a-0657c4fa2b11,af51a2a9-880d-4109-a7b1-84962fafb8a2' 
            }
        }
        #If there were no errors, then change the status to Acknowledged
        $Notes += "Setting status to Acknowledged`n"
        Set-ListItemField -AccessToken $token.access_token -Field "Status" -ItemNumber $i.id -Data "Acknowledged" -listID '1baffb5c-d51a-4803-b534-2a83c3c867fd' -siteID 'bwya77.sharepoint.com,218d5607-899f-4ec4-888a-0657c4fa2b11,af51a2a9-880d-4109-a7b1-84962fafb8a2' 
    }