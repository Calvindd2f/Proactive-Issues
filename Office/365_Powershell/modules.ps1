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
                Write-Host "Making sure Module: $Module is up-to-date"
                Update-Module -Name $Module -Confirm
            } else {
                Write-Host "Installing: $Module"
                Install-Module -Name $Module -Force
            }
            $InstalledModules += (Get-InstalledModule -Name $Module)
            Write-Host "==========================================================="
            Write-Host
        }
    }

    end {
        $InstalledModules | Select-Object Name,Version,Description
        Write-Host
        Write-Host "All O365 modules are installed and up-to-date." -ForegroundColor Green
        Write-Host
        Write-Host
    }
