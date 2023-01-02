# Requires Microsoft Graph & ExchangeOnlineManagement
Connect-MgGraph
Connect-ExchangeOnline



# Convert to shared mailbox
Set-Mailbox -Identity $user -Type Shared

# Reset password
Select-MgProfile -Name beta
$user = user1@example.com
$method = Get-MgUserAuthenticationPasswordMethod -UserId $user
Reset-MgUserAuthenticationMethodPassword -UserId $user -RequireChangeOnNextSignIn -AuthenticationMethodId $method.id -NewPassword "zQ7!Ra3MM6ha"

# Block sign-in
$params = @{
     AccountEnabled = "false"
             }
 Update-MgUser -UserId $User.Id -BodyParameter $params
 
# Remove from groups
# Change AAD Description
# Remove MFA methods, revoke sessions [both MFA and standard]
# Disable user
# Double check that mailbox is shared
# Revoke Licenses
