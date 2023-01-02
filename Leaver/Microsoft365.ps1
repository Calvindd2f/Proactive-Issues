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

# Reset c@lvin.ie's password
$passwordProfile = New-Object -TypeName Microsoft.Graph.PasswordProfile
$passwordProfile.Password = 'GeneratedPassword'
Set-MSGraphUserPassword -User $user -PasswordProfile $passwordProfile

# Block sign-in
$params = @{
     AccountEnabled = "false"
             }
 Update-MgUser -UserId $User.Id -BodyParameter $params
 
 Set-MSGraphUser -User $user -BlockSignIn $true
 
 
# Remove from groups
Get-MSGraphGroup -Tenant lvin.ie | Where-Object {$_.Members -contains $user.id} | ForEach-Object {
    Remove-MSGraphGroupMember -Group $_ -Member $user
}

# Change AAD Description
$userProfile = Get-MSGraphUserProfile -User $user
$userProfile.AboutMe = "Disabled on $(Get-Date -Format 'dd/MM/yyyy')"
Set-MSGraphUserProfile -UserProfile $userProfile

# Remove MFA methods, revoke sessions [both MFA and standard]
Get-MSGraphMFA -Tenant lvin.ie -UserPrincipalName c@lvin.ie | ForEach-Object {
    Remove-MSGraphMFA -MFA $_
}

# Disable user
Set-MSGraphUser -User $user -AccountEnabled $false
# Double check that mailbox is shared
$Shared = Get-Mailbox -Identity $user -Type Shared
if ($Shared -eq $True) {
     # Revoke Licenses
     Get-MsolUser -UserPrincipalName c@lvin.ie | Select-Object -ExpandProperty Licenses | ForEach-Object {
    Remove-MsolUserLicense -UserPrincipalName c@lvin.ie -RemoveLicenses $_.AccountSkuId
}
}Else{
Write-Verbose "User licenses were not unassigned as the mailbox was unable to be converted to shared."
Exit
}

