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


PsExec1 is part of the Sysinternals2 suite and we can use it to establish remote Windows shells in a variety of ways. 
To keep this section simple, we'll use PsExec to connect with a remote shell on a system that has open File and Printer Sharing


*The PsTools packages are extracted into the System32 directory*

        PS C:\Users\Administrator\Downloads> Expand-Archive -Path .\PSTools.zip -DestinationPath C:\Windows\System32\


*The command execution fails due to a logon failure*

        PS C:\Users\offsec> psexec \\192.168.50.80 -u offensive -p security ipconfig

        PsExec v2.34 - Execute processes remotely
        Copyright (C) 2001-2021 Mark Russinovich
        Sysinternals - www.sysinternals.com


        PsExec could not start ipconfig on 192.168.50.80:
        Logon failure: the user has not been granted the requested logon type at this computer.




*The remote command executed successfully*

        PS C:\Users\offsec> psexec \\192.168.50.80 -u offensive -p security -i ipconfig

        PsExec v2.34 - Execute processes remotely
        Copyright (C) 2001-2021 Mark Russinovich
        Sysinternals - www.sysinternals.com

        Windows IP Configuration

        Ethernet adapter Ethernet0:

       Connection-specific DNS Suffix  . :
       IPv4 Address. . . . . . . . . . . : 192.168.50.80
       Subnet Mask . . . . . . . . . . . : 255.255.255.0
       Default Gateway . . . . . . . . . : 192.168.50.254
        ipconfig exited on 192.168.50.80 with error code 0.

*A command prompt shell is opened on the remote host*

        PS C:\Users\offsec> psexec \\192.168.50.80 -u offensive -p security -i cmd

        PsExec v2.34 - Execute processes remotely
        Copyright (C) 2001-2021 Mark Russinovich
        Sysinternals - www.sysinternals.com

        Microsoft Windows [Version 10.0.19044.1415]
        (c) Microsoft Corporation. All rights reserved.

        C:\WINDOWS\system32>




+ EvilWinRM

Evil-WinRM1 is a feature-rich tool used to establish remote shells using Microsoft's implementation of the WS-Management2 protocol, WinRM.3 Just like our PowerShell shell, the remote host must be configured for PSRemoting and WinRM that runs on port 5985 by default.


*The usage for evil-winrm is displayed*

        offensive@linuxshells:~/evil-winrm$ ./evil-winrm.rb

        Evil-WinRM shell v3.3

        Error: missing argument: ip, user

        Usage: evil-winrm -i IP -u USER [-s SCRIPTS_PATH] [-e EXES_PATH] [-P PORT] [-p PASS] [-H HASH] [-U URL] [-S] [-c PUBLIC_KEY_PATH ] [-k PRIVATE_KEY_PATH ] [-r REALM] [--spn SPN_PREFIX] [-l]
    -S, --ssl                        Enable ssl
    -c, --pub-key PUBLIC_KEY_PATH    Local path to public key certificate
    -k, --priv-key PRIVATE_KEY_PATH  Local path to private key certificate
    -r, --realm DOMAIN               Kerberos auth, it has to be set also in /etc/krb5.conf file using this format -> CONTOSO.COM = { kdc = fooserver.contoso.com }
    -s, --scripts PS_SCRIPTS_PATH    Powershell scripts local path
        --spn SPN_PREFIX             SPN prefix for Kerberos auth (default HTTP)
    -e, --executables EXES_PATH      C# executables local path
    -i, --ip IP                      Remote host IP or hostname. FQDN for Kerberos auth (required)
    -U, --url URL                    Remote url endpoint (default /wsman)
    -u, --user USER                  Username (required if not using kerberos)
    -p, --password PASS              Password
    -H, --hash HASH                  NTHash
    -P, --port PORT                  Remote host port (default 5985)
    -V, --version                    Show version
    -n, --no-colors                  Disable colors
    -N, --no-rpath-completion        Disable remote path completion
    -l, --log                        Log the WinRM session
    -h, --help                       Display this help message

*Listing 55 - The remote shell with evil-winrm is established*


        offensive@linuxshells:~/evil-winrm$ ./evil-winrm.rb -i 192.168.50.80 -u offensive -p security

        Evil-WinRM shell v3.3

        Info: Establishing connection to remote endpoint

        *Evil-WinRM* PS C:\Users\offensive\Documents>
