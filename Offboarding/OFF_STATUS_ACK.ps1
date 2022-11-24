ElseIf ($i.status -eq "Acknowledged")
    {
        #Figure out how many days and hours  until the user is to be off-boarded, if days left is less than or equal to 0 and hours is less than or equal to 0, then the user is to be off-boarded. NOTE: the default time in the timepicker is 7PM but can be changed in SharePoint
        $Timespan = New-TimeSpan -Start (Get-Date) -End $i.OffboardDate
        if (($Timespan.days -le 0) -and ($timespan.hours -le 0))
        {
            #Remove liceses from the user
            #Get all licenses for the user
            $Licenses = Get-UserLicenses -userPrincipalName $user.userPrincipalName -accessToken $token.access_token
            foreach ($license in $Licenses) {
                $Notes += "Removing $($license.skuPartNumber) license from $($i.Title)`n"
                Remove-UserLicenses -userPrincipalName $user.userPrincipalName -accessToken $token.access_token -licenseSkuID $license.skuId
            }

            #set the automatic mail forwarding rule
            $Notes += "Setting automatic mail forwarding rule to forward email to $($i.ForwardingAddress)`n"
            Set-MailboxForwarding -userPrincipalName $i.Title -accessToken $token.access_token -ForwardingAddress $i.ForwardingAddress
            $MailRuleCheck = Get-MailboxForwarding -userPrincipalName $i.Title -accessToken $token.access_token
            if ($MailRuleCheck) {
                $Notes += "Mail forwarding rule was set`n"
            }
            else {
                $Notes += "Mail forwarding rule was not set`n"
            }

            #Remove the user from the groups
            $groups = Get-GroupMembership -userPrincipalName $user.userPrincipalName -accessToken $token.access_token
            foreach ($group in $groups) {
                $Notes += "Removing $($user.DisplayName) from $($group.displayName)`n"
                Remove-GroupMembership -userID $user.id -accessToken $token.access_token -groupID $group.id
            }

        #If there were no errors, then change the status to Complete
        $Notes += "Setting status to Complete`n"
        Set-ListItemField -AccessToken $token.access_token -Field "Status" -ItemNumber $i.id -Data "Complete" -listID '1baffb5c-d51a-4803-b534-2a83c3c867fd' -siteID 'bwya77.sharepoint.com,218d5607-899f-4ec4-888a-0657c4fa2b11,af51a2a9-880d-4109-a7b1-84962fafb8a2' 

        }
    }