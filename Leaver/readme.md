# Leaver playbook, should not be difficult.
- # Adding bullet points of exactly what is done so that those not au fae with powershell can understand what to do.
=========================================================================================

# Active Directory

- Check for / Create OU=Disabled Users

- Find Disabled Users outside this OU ; then move them to the OU

- Find user that is leaving.
- Disable User Account.
- Reset Password
- Clear Group Membership
- Set description "Disabled - Date"
- Move that user to Disabled Users OU

-- Check for ADSyncServer ; if it exists , Run a delta sync. If not, exit.

=========================================================================================

# 365 / AAD / Office

- Convert to shared mailbox
- Reset password
- Block sign-in
- Remove from groups
- Change AAD Description
- Remove MFA methods, revoke sessions [both MFA and standard]
- Disable user
- Double check that mailbox is shared
- Revoke Licenses
