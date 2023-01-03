# WAN
irm ipinfo.io/ip

# DC
echo $env:LOGONSERVER

# LOCALHOST ninfo
ipconfig | findstr.exe /i 'Suffix DHCP Gateway IPv4'

# Wifi
netsh wlan show profiles
