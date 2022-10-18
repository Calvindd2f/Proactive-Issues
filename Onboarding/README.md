    #   This will be pure enumeration for sake of onboarding.
    #   This can make or break a customers first xyz $timeperoid of support.
    #   Any folders will share a name similar to it's heading with shit that is only useful for onboarding
    **I've came to terms with the fact I am pretty much a next-gen ink-pisser**
    
+ Groups
    1. Filter as required
    2. CMD:> 'net group'
        
            Group Accounts for \\WIN2022DC

            -------------------------------------------------------------------------------
            *big boy access
            *Cloneable Domain Controllers
            *DnsUpdateProxy
            *Domain Admins
            *Domain Computers
            *Domain Controllers
            *Domain Guests
            *Domain Users
            *Enterprise Admins
            *Enterprise Key Admins
            *Enterprise Read-only Domain Controllers
            *Financial Share
            *Group Policy Creator Owners
            *HR
            *infosys
            *Key Admins
            *Production
            *Project important
            *Protected Users
            *Quality
            *RDP Cunts
            *Read-only Domain Controllers
            *Recruitment
            *Schema Admins

    1. PS:> Get-ADGroup -Filter * | select -Property SAMaccountname,GroupScope
    2. filter as required

            SAMaccountname
            --------------
            ADSyncAdmins
            ADSyncOperators
            ADSyncBrowse
            ADSyncPasswordSet
            Administrators
            Users
            Guests
            Print Operators
            Backup Operators
            Replicator
            Remote Desktop Users
            Network Configuration Operators
            Performance Monitor Users
            Performance Log Users
            Distributed COM Users
            IIS_IUSRS
            Cryptographic Operators
            Event Log Readers
            Certificate Service DCOM Access
            RDS Remote Access Servers
            RDS Endpoint Servers
            RDS Management Servers
            Hyper-V Administrators
            Access Control Assistance Operators
            Remote Management Users
            Storage Replica Administrators
            Domain Computers
            Domain Controllers
            Schema Admins
            Enterprise Admins
            Cert Publishers
            Domain Admins
            Domain Users
            Domain Guests
            Group Policy Creator Owners
            RAS and IAS Servers
            Server Operators
            Account Operators
            Pre-Windows 2000 Compatible Access
            Incoming Forest Trust Builders
            Windows Authorization Access Group
            Terminal Server License Servers
            Allowed RODC Password Replication Group
            Denied RODC Password Replication Group
            Read-only Domain Controllers
            Enterprise Read-only Domain Controllers
            Cloneable Domain Controllers
            Protected Users
            Key Admins
            Enterprise Key Admins
            DnsAdmins
            DnsUpdateProxy
            RDP Cunts
            Financial Share
            infosys
            Production
            Quality
            HR
            Project important
            Recruitment
            big boy access

+ Shared Drives
    1. *Ideally your RMM can make this easier.
    2. *It could be a local disk on the DC so running below from there may return misleading results
    3. *Run CMD on multiple machines belonging to different users to map what shares are in use
    4. CMD:> 'net share'
    5. *Run this on several different endpoints
    6. _______________________________________
    7. PS:> Get-SmbShare -IncludeHidden -ShareState Online
    8. *Run this on several different endpoints


**Get-SmbMapping works when drive is mapped and saves tears of denial**
*below has all the drives mapped on the device I ran it on*

    1.Get-SmbMapping | select -Property LocalPath,RemotePath | ft -AutoSize
    
        LocalPath RemotePath
        --------- ----------
        F:        \\win2022dc\finance
        H:        \\win2022dc\hr
        A:        \\win2022dc\IT
        Q:        \\win2022dc\quality
        Y:        \\win2022dc\yes
        U:        \\win2022dc\Users


+ Printers
