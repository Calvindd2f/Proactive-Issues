Automated Logic:

Next, we need to create the automated logic behind the automation.
=================================================================================================================================
:Pending
-	Automation has not seen the user (or has resolved errors it saw)
:Acknowledged
-	Automation has seen the user and confirmed there are no issues with it (the user is in Azure AD, the forwarding user is in Azure AD)
:Complete
-	The user has been off boarded without any issues.
:Error
-	The user was not found in Azure AD or the forwarding user was not found in Azure AD.


