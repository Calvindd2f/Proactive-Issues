Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

iwr https://github.com/Calvindd2f/Proactive-Issues/raw/main/Enumeration/Nmap.zip -OutFile C:\Nmap.zip
irm https://github.com/Calvindd2f/Proactive-Issues/raw/main/Enumeration/Npcap.zip -OutFile C:\Npcap.zip

#1. Extract contents of nmap install to default folder
Add-Type -AssemblyName 'System.IO.Compression.Filesystem' -ErrorAction SilentlyContinue
$nmap_zip = "C:\Nmap.zip"

$out_nmap = 'C:\Program Files (x86)\Nmap'
mkdir $out_nmap
[IO.Compression.ZipFile]::ExtractToDirectory(('{0}' -f $nmap_zip),"$out-nmap")

#2. Download and Execute NPAP Driver 1.71
Add-Type -AssemblyName 'System.IO.Compression.Filesystem' -ErrorAction SilentlyContinue
$pcap_zip = "C:\Npcap.zip"


$out_pcap = 'C:\Program Files\Npcap'
mkdir $out_pcap
[IO.Compression.ZipFile]::ExtractToDirectory(('{0}' -f $pcap_zip),"$out_pcap")


#3. Clear driver cache before registering drivers and certificate
cd $out_pcap
.\NPFInstall.exe -c

#4. Install drivers and certitifacate 
cd $out_pcap
.\NPFInstall.exe -iw ; .\NPFInstall.exe -i ; .\NPFInstall.exe -r
CERTUTIL.EXE IMPORT .\npcap.cer root

#5. Registry

& "$env:windir\system32\reg.exe" add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap" /v 'Start' /t REG_DWORD /d '0x00000001"' /f
& "$env:windir\system32\reg.exe" add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters" /v "LoopbackSupport" /t REG_DWORD /d"0x00000001" /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters' /v 'DltNull' /t REG_DWORD /d '0x00000001' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters' /v 'Edition' /d 'Str' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters' /v 'AdminOnly' /t REG_DWORD /d '0x00000001' /f


& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters' /v 'Dot11Support' /t REG_DWORD /d '0x00000000' /f  
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters' /v 'VlanSupport' /t REG_DWORD /d '0x00000000' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters' /v 'AdminOnly' /t REG_DWORD /d '0x00000001' /f
            
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap' /v 'Start' /t REG_DWORD /d '0x00000001' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap_wifi' /v 'Start' /t REG_DWORD /d '0x00000004' /f


& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst' /v 'DisplayName'  /d 'Npcap' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst' /v 'DisplayVersion'  /d '1.72' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst' /v 'Publisher'  /d 'Nmap Project' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst' /v 'URLInfoAbout'  /d 'https://npcap.com/' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst' /v 'URLUpdateInfo'  /d 'https://npcap.com/#download' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst' /v 'InstallLocation'  /d 'C:\Program Files\Npcap' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst' /v 'VersionMajor' /t REG_DWORD /d '0x00000001' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst' /v 'VersionMinor' /t REG_DWORD /d '0x00000048' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst' /v 'NoModify' /t REG_DWORD /d '0x00000001' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst' /v 'NoRepair' /t REG_DWORD /d '0x00000001' /f


# 6. RegEdit for performance optimization + Finsihed
regedt32 /S "$out_nmap\nmap_performance.reg"
exit
