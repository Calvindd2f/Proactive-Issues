# Cradle installation of PSEXEC
$zip = "$env:windir\PSTOOLS.zip"
$Download = 'https://download.sysinternals.com/files/PSTools.zip'
Add-Type -AssemblyName 'System.IO.Compression.Filesystem' -ErrorAction SilentlyContinue
Invoke-WebRequest -Uri $Download -OutFile $zip
[IO.Compression.ZipFile]::ExtractToDirectory(('{0}' -f $zip),"$env:windir")
Invoke-Expression -Command ("PSexec.exe")
