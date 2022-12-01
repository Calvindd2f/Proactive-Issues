function Install-O365_Modules {
    begin {
        $Modules = @(
            'AzureAD',
            'MicrosoftTeams',
            'ExchangeOnlineManagement',
            'MSOnline'
        )
        $InstalledModules = @()
        Clear-Host
    }

    process {
        foreach ($Module in $Modules){
            if (Get-Module -ListAvailable -Name $Module) {
                Write-Verbose -Message ('Making sure Module: {0} is up-to-date' -f $Module)
                Update-Module -Name $Module -Confirm
            } else {
                Write-Verbose -Message ('Installing: {0}' -f $Module)
                Install-Module -Name $Module -Force
            }
            $InstalledModules += (Get-InstalledModule -Name $Module)
            Write-Verbose -Message '==========================================================='
        }
    }

    end {
        $InstalledModules | Select-Object -Property Name,Version,Description
        Write-Verbose -Message 'All O365 modules are installed and up-to-date.'
    }
    }
