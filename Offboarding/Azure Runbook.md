Set up the Azure Runbook:

Next, we need to create the automated logic behind the automation.
=================================================================================================================================
:Create your Resource Group
-	Keep my runbook and automation account.
:Create Automation Account
-	create the automation account 
:Modify the Runbook
-	Next ,we need to store our secrets securely in the Automation Account. 
-	Go to Variables and add the clientID, clientSecret, and tenantID that we got earlier for our Azure AD application. 
-	Ensure that you select that they are encrypted. We will retrieve the values in the runbook by using the code below:

		$clientId = Get-AutomationVariable -Name "clientID"
		$tenantID = Get-AutomationVariable -Name "tenantID"
		$clientSecret = Get-AutomationVariable -Name "clientSecret"

		#Connect to MSGraph API
		$token = Connect-GraphAPI -clientID $clientId -tenantID $tenantID -clientSecret $clientSecret

:Create the Runbook
-	You will need to change the listID and siteID to match your own, as well as the field names if they do not match.
:Set a Recurrence
-	every 1 hours.
# TODO
:Email the users manager when they are offboarded. 
:Locked the SharePoint site to just them so nobody else can access it.
