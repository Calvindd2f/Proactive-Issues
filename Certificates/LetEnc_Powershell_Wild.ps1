Write-Verbose @"
Windows PowerShell 5.1 
.NET Framework 4.7.2 (link to check) 
Possibility to add CNAME in DNS
"@


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

CheckCisPriv
Set-ExecutionPolicy Bypass -Scope Process
Install-Module -Name Posh-ACME
Import-Module -Name Posh-ACME
Write-Verbose @" Displaying Sample
New-PACertificate *.dread.ie -AcceptTOS -Contact <your-email> -DnsPlugin AcmeDns -PluginArgs @{ACMEServer='auth.acme-dns.io'} -Install
@"
