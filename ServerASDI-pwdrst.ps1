# Get the User object
$user = [ADSI]"WinNT://<domain>/<username>"
# Set the new password
$user.SetPassword("<new_password>")
# Enable the user to change password at next logon
$user.psbase.InvokeSet("PasswordExpired", $true)
# Commit the changes
$user.psbase.CommitChanges()
