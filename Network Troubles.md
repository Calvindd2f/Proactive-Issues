# Windows unfuck
Type ipconfig /release and press Enter.
Type ipconfig /flushdns and press Enter.
Type ipconfig /renew and press Enter. (This will stall for a moment.)
Type netsh int ip reset and press Enter. (Don't restart yet.)
Type netsh winsock reset and press Enter.

# Try thse
netsh
nslookup 
pathping
netstat -anop



dig or if you wanna stay in cmd/ps > PS:> wsl dig
if you don't have wsl fuck off 


# Windows wsl2 unfuck
net stiop lxssmanager
net stop hns
 ipconfig /release | ipconfig /flushdns | ipconfig /renew | netsh int ip reset | netsh winsock reset
   Restart-Service -Force -Name hns
   Restart-Service LxssManager
   wsl ping google.com
