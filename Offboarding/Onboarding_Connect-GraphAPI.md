Create Azure AD Application:
Required to interface with Graph API

===========================================================================================
:Azure Active Directory
- App Registrations > New Registration
- Take note of the Application (client) ID and tenantID value.
- Give your new Application a valid anme and a redirect URI
:Afterwards
- Next, go to Certificates and Secret and click “New Client Secret”
- Note the secret value. You will not be able to view it again.
- Use powershell function to to conenct. You should receive a bearer token
:OffboardingToken
-	expires:  5/24/2024
-	Value:	  vLy8Q~yia2uWsEZt5yE3J9tDVjzTjxj5Tt42.bGj 
-	SecretID: 134d63d0-ebb4-49e4-b478-2f57b4f39d30
:Verbose
-	 Application (client) ID =	a314c1d3-90b1-4e1c-8881-db23b49c1575
- 	 Object ID = 	            8f76ed4-1db8-40ee-a79c-ef8e17c62723
-	 Directory (tenant) ID = 	fafb46b1-4b64-41ef-8f52-68ed0ccae30f
===========================================================================================

Point2:

