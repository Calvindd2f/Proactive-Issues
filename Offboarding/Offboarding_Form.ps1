<# Create a SPO site with below list & fields.


Email: Single string
Groups: Multiple lines
Licenses: Multiple lines
Mailbox Type: single string
Forwarding Address: single string
Status: Choice
Notes: #>


#Connect to Sharepoint for column info.

$Site = 'https://vdbdx.sharepoint.com/sites/Offboarding'
Connect-PnPOnline -Url $Site -UseWebLogin 
#---------------------------------------------------------
#Get-PnPList cmdlet to get the ID for your newly created list. Take note of the ID value.
Get-PnPList -Identity "Offboarding"
#0ea7eba1-5efc-434e-a5ec-914ff57e914a
Get-PnPField -List "Offboarding"