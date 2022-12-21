 #Parameters
 $TenantAdminURL = "https://yourwebsite.sharepoint.com"
     
 #Connect to PnP Online
 Connect-PnPOnline -Url $TenantAdminURL -Interactive
     
 #Disable Add Shortcut to OneDrive
 Set-PnPTenant -DisableAddToOneDrive $True
