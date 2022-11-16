# Windows fix

Oneliner CMD

   *ipconfig /release && ipconfig /renew && ipconfig /flushdns && netsh int ip rese && netsh winsock reset*

Oneliner PS

   *ipconfig /release | ipconfig /renew | ipconfig /flushdns | netsh int ip reset | netsh winsock reset*

Type ipconfig /release and press Enter.
Type ipconfig /flushdns and press Enter.
Type ipconfig /renew and press Enter. (This will stall for a moment.)
Type netsh int ip reset and press Enter. (Don't restart yet.)
Type netsh winsock reset and press Enter.

# Also Great Fun
netsh
nslookup 
pathping
netstat -anop



 # Execute Linux Commands (WSL) without entering linux shell
 
 *By this I mean : Open Powershell , Run a command that can be only ran in linux , when output / finished it stays in Powershell and not linux shell*

PS C:\> wsl dig
*output*
PS C:\>

or 

PS C:\> wsl nmap -sN -sV -vvvv 0.0.0.0 
*shit loads of outpput*
PS C:\>


# Windows wsl2 fix
net stop lxssmanager
net stop hns
 ipconfig /release | ipconfig /flushdns | ipconfig /renew | netsh int ip reset | netsh winsock reset
   Restart-Service -Force -Name hns
   Restart-Service LxssManager
   wsl ping google.com
