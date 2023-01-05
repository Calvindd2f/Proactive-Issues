#1. Extract contents of nmap install to default folder
Add-Type -AssemblyName 'System.IO.Compression.Filesystem' -ErrorAction SilentlyContinue
$nmap_zip = "nmap_zip"

$out_nmap = 'C:\Program Files (x86)\Nmap'
mkdir $out_nmap

[IO.Compression.ZipFile]::ExtractToDirectory(('{0}' -f $zip),"$out-nmap")|cd $_


#2. Download and Execute NPAP Driver 1.71
Add-Type -AssemblyName 'System.IO.Compression.Filesystem' -ErrorAction SilentlyContinue
$pcap_zip = "pcap_zip"


$out_pcap = 'C:\Program Files\Npcap'
mkdir $out_pcap
[IO.Compression.ZipFile]::ExtractToDirectory(('{0}' -f $zip),"$out_pcap")|cd $_


#3. Clear driver cache before registering drivers and certificate
cd $out_pcap
.\NPFInstall.exe -c


#4. Install drivers and certitifacate 
cd $out_pcap
.\NPFInstall.exe -iw ; .\NPFInstall.exe -i ; .\NPFInstall.exe -r
CERTUTIL.EXE IMPORT .\npcap.cer root


#5. Registry

& "$env:windir\system32\reg.exe" add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap" /v 'Start' /t REG_DWORD /d '0x00000001"' /f
& "$env:windir\system32\reg.exe" add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters" /v "LoopbackSupport" /t REG_DWORD /d"0x00000001" 
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'DltNull' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'Edition' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'AdminOnly' /t REG_DWORD /d '4' /f


& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'Dot11Support' /t REG_DWORD /d '4' /f  
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'VlanSupport' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'AdminOnly' /t REG_DWORD /d '4' /f
            
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap' /v 'Start' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap_wifi' /v 'Start' /t REG_DWORD /d '4' /f


& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'DisplayName' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'DisplayVersion' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'Publisher' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'URLInfoAbout' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'URLUpdateInfo' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'InstallLocation' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'VersionMajor' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'VersionMinor' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'NoModify' /t REG_DWORD /d '4' /f
& "$env:windir\system32\reg.exe" add 'HKLM\SYSTEM\ControlSet001\Services\rdyboost' /v 'NoRepair' /t REG_DWORD /d '4' /f

<# remove
WriteRegDWORD: "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters" "DltNull"="0x00000001"
WriteRegStr: "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters" "Edition"="Npcap"
WriteRegDWORD: "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters" "AdminOnly"="0x00000001"
Jump: 1580
WriteRegDWORD: "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters" "Dot11Support"="0x00000000"
WriteRegDWORD: "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters" "VlanSupport"="0x00000000"
WriteRegDWORD: "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap\Parameters" "WinPcapCompatible"="0x00000001"

WriteRegDWORD: "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap" "Start"="0x00000001"
WriteRegDWORD: "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap_wifi" "Start"="0x00000004"

WriteRegStr: "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst" "DisplayName"="Npcap"
WriteRegStr: "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst" "DisplayVersion"="1.72"
WriteRegStr: "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst" "Publisher"="Nmap Project"
WriteRegStr: "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst" "URLInfoAbout"="https://npcap.com/"
WriteRegStr: "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst" "URLUpdateInfo"="https://npcap.com/#download"
WriteRegStr: "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst" "InstallLocation"="C:\Program Files\Npcap"
WriteRegDWORD: "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst" "VersionMajor"="0x00000001"
WriteRegDWORD: "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst" "VersionMinor"="0x00000048"
WriteRegDWORD: "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst" "NoModify"="0x00000001"
WriteRegDWORD: "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst" "NoRepair"="0x00000001"
#>

# 6. RegEdit for performance optimization + Finsihed
regedt32 /S "$out_nmap\nmap_performance.reg"
exit
