# Requirements
Write-Verbose @"
Windows PowerShell 5.1 
.NET Framework 4.7.2 (link to check) 
Possibility to add CNAME in DNS
"@

# Check for Admin
function CheckCisPriv
{
<#
.SYNOPSIS
.EXAMPLE
Is Administrator check
.EXAMPLE
CheckYourPrivilageCisScum
#>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'High')]
    Param (
        [Switch]
        $Force,

        [Switch]
        $ExitImmediately
    )

    if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    {
        throw 'Requires elevated PowerShell prompt.'
    }

    $Response = $True

    if (!$Force)
    {
        $Response = $psCmdlet.ShouldContinue('xyz')
    }

    if (!$Response)
    {
        return
    }}

# Priv check ; ExecPolicy & Install+Import module
CheckCisPriv
Set-ExecutionPolicy Bypass -Scope Process
Install-Module -Name 'Posh-ACME'
Import-Module -Name Posh-ACME

# Verbose info for installed module
Write-Verbose @"
Displaying Sample:
New-PACertificate $env:Wildcard-or-Domain -AcceptTOS -Contact $env:ContactEmail -DnsPlugin AcmeDns -PluginArgs $env:PluginArgs -Install
"@

# Variables: Can be used with DRMM
$env:Wildcard-or-Domain = *.dread.ie
$env:ContactEmail = calvindd2f@git.hub
$env:PluginArgs = @{ACMEServer='auth.acme-dns.io'}

# New Certificate
New-PACertificate $env:Wildcard-or-Domain -AcceptTOS -Contact $env:ContactEmail -DnsPlugin AcmeDns -PluginArgs $env:PluginArgs  -Install


# Autorenewal Automation
$Trigger =New-ScheduledTaskTrigger -At 10:00am -Daily
$Action= New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "C:\Cert\AutoRenewal.ps1"
Register-ScheduledTask -TaskName "Certificate AutoRenewal" -Trigger $Trigger -User "$env:USERDOMAIN\$env:USERNAME" -Password '<password>' -Action $Action -RunLevel Highest –Force
