# Get current time
$CurrentTime = Get-Date

# Get time from NTP server
$NTPTime = (Get-Date (Get-NTPTime -ComputerName time.nist.gov)).ToUniversalTime()

# Calculate the time difference
$TimeDifference = New-TimeSpan -Start $CurrentTime -End $NTPTime

# Set the new server time
$NewTime = (Get-Date).Add($TimeDifference)

# Set the server time
Set-Date -Date $NewTime
