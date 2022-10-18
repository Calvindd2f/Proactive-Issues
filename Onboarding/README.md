    #   This will be pure enumeration for sake of onboarding.
    #   This can make or break a customers first xyz $timeperoid of support.
    #   Any folders will share a name similar to it's heading with shit that is only useful for onboarding
    **I've came to terms with the fact I am pretty much a next-gen ink-pisser**
    
+ Groups
    1. CMD:> 'net group'
    2. filter as required

    1. PS:> Get-ADGroup -Filter * | select -Property SAMaccountname,GroupScope
    2. filter as required

+ Shared Drives
    1. Ideally your RMM can make this easier.
    2. It could be a local disk on the DC so running below from there may return misleading results
    3. Run CMD on multiple machines belonging to different users to map what shares are in use
    4. CMD:> 'net share'
    5. Run this on several different endpoints
    6. _______________________________________
    7. PS:> Get-SmbShare -IncludeHidden -ShareState Online
    8. Run this on several different endpoints


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
