1.  Remote shells with PowerShell
2.  Use psexec
3.  Use evil-winrm





+ Remote shells with PowerShell



Let's cover some PowerShell Cmdlets we can use to remotely execute commands and also gain a remote shell. These cmdlets are Invoke-Command3 and Enter-PSSession.4 Before we can use these, however, some conditions need to be met on both Windows hosts.


The first of these conditions is that the remote host must have PSRemoting5 enabled. The Web Services for Management (WSMan) provider also needs a TrustedHosts entry. The client host used to set up the connection must also meet these conditions. We've already set up the Windows host whose number ends in.80, but we still need to set up these conditions on the client whose number ends in.79.

Before we correctly set up our host at .79, let's try to run Invoke-Command and get the IP address of the remote host at .80 .


We can tell the command which host to run on by using the -ComputerName option. This could be the IP address or the hostname of the remote machine. The -ScriptBlock option is used to run the command or commands on that host. For now, even though it's unnecessary, we're using ipconfig as the command to show how a command can be run remotely. The -Credential option is used to give the username and bring up a dialog box to enter the password.



*The Invoke-Command cmdlet to run ipconfig on host 192.168.50.80*
*The Invoke-Command cmdlet fails due to an authentication or trustedhosts issue*

    Invoke-Command -ComputerName 192.168.50.80 -Scriptblock { ipconfig } -Credential offensive
    
    ================================OUTPUT====================================================
    [192.168.50.80] Connecting to remote server 192.168.50.80 failed with the following error message : 
    The WinRM client cannot process the request. If the authentication scheme is different from Kerberos, or if the client computer is not
    joined to a domain, then HTTPS transport must be used or the destination machine must be added to the TrustedHosts
    configuration setting. Use winrm.cmd to configure TrustedHosts. Note that computers in the TrustedHosts list might not
    be authenticated. You can get more information about that by running the following command: winrm help config. For
    more information, see the about_Remote_Troubleshooting Help topic.
      + CategoryInfo          : OpenError: (192.168.50.80:String) [], PSRemotingTransportException
      + FullyQualifiedErrorId : ServerNotTrusted,PSSessionStateBroken
      

The PowerShell terminal error indicates an authentication issue or that the destination machine is not in the TrustedHosts configuration setting.
Next, let's turn on PSRemoting and add the host ending in.80 to our TrustedHosts configuration setting.


*Run PowerShell with Elevated Privileges*

    PS C:\Users\offsec> Enable-PSRemoting
    Enable-PSRemoting : Access is denied. To run this cmdlet, start Windows PowerShell with the "Run as administrator"

*PSRemoting is now enabled*

    PS C:\WINDOWS\system32> Enable-PSRemoting
    WinRM has been updated to receive requests.
    WinRM service type changed successfully.
    WinRM service started.

    WinRM has been updated for remote management.
    WinRM firewall exception enabled.
    Configured LocalAccountTokenFilterPolicy to grant administrative rights remotely to local users.

*The remote host is added to the TrustedHosts configuration setting*

    PS C:\WINDOWS\system32> Set-Item wsman:\localhost\client\trustedhosts 192.168.50.80

    WinRM Security Configuration.
    This command modifies the TrustedHosts list for the WinRM client. The computers in the TrustedHosts list might not be
    authenticated. The client might send credential information to these computers. Are you sure that you want to modify this
     list?
    [Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): Y
    
*The command successfully ran on the remote host*
   
    PS C:\WINDOWS\system32> Invoke-Command -ComputerName 192.168.50.80 -ScriptBlock { ipconfig } -Credential offensive

    Windows IP Configuration

    Ethernet adapter Ethernet0:

     Connection-specific DNS Suffix  . :
     IPv4 Address. . . . . . . . . . . : 192.168.50.80
     Subnet Mask . . . . . . . . . . . : 255.255.255.0
     Default Gateway . . . . . . . . . : 192.168.50.254
     
   
*Entering a Remote Shell Session*

    PS C:\WINDOWS\system32> Enter-PSSession -ComputerName 192.168.50.80 -Credential offensive

    [192.168.50.80]: PS C:\Users\offensive\Documents> ipconfig


+ PSEXEC


PsExec1 is part of the Sysinternals2 suite and we can use it to establish remote Windows shells in a variety of ways. To keep this section simple, we'll use PsExec to connect with a remote shell on a system that has open File and Printer Sharing.3











