# Fix Network Location Awareness service not starting

# Step 1: Stop and Start the Network Location Awareness service

Stop-Service -Name NlaSvc
Start-Service -Name NlaSvc

# Step 2: Reset Winsock

netsh winsock reset

# Step 3: Re-register the Network Location Awareness service

sc delete NlaSvc
sc config NlaSvc start= auto
net start NlaSvc

# Step 4: Re-register the TCP/IP protocol

netsh int ip reset reset.log

# Step 5: Restart the computer

Restart-Computer
