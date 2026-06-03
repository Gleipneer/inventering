<#
    En modul för att stänga av windows klienter.
#>

# Importera modul
using module ./loggning.psm1

function Invoke-ClientShutdown {
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $Computers,

        [ValidateSet('Simulate', 'Shutdown')]
        [string]$Mode = 'Simulate',

        [int]$DelayMinutes = 0,

        [string]$LogPath = 'C:\Logs\NetworkInventory.log'
    )

    begin {
        $shutdownComputers = $()
        $failedShutdownComputers = $()
    }

    process {
        foreach ($computer in $Computers) {

            $name = $computer.ComputerName
            $ip   = $computer.IPAddress

            if ($Mode -eq 'Simulate') {
                Write-Log "[SIMULATE] Skulle stangt av $name ($ip)" -Level INFO -LogPath $LogPath
                continue
            }

            Write-Log "Stangar av $name ($ip)..." -LogPath $LogPath

            $delaySec = $DelayMinutes * 60

            try {
                # Påbörja avstänging av dator
                Invoke-Command -ComputerName $name -ScriptBlock {
                    param($delay)
                    shutdown.exe /s /t $delay /f /c "Gron IT-policy"
                } -ArgumentList $delaySec -ErrorAction Stop
                
                Write-Log "  OK: Avstangning schemalagd pa $name" -Level OK -LogPath $LogPath

                # Lägg till i logg data
                $shutdownComputers += $computer
            } 
            catch {
                Write-Log "  FEL: Kunde inte stanga av $name - $_" -Level ERROR -LogPath $LogPath

                # Lägg till i logg data
                $failedShutdownComputers += $computer
            }
        }
    }


    end {
    # Skriv log data till CSV filer
    LoggDataTillCSV -csvFilNamn ".\logs\avstängdaKlienter.csv" -data $shutdownComputers
    LoggDataTillCSV -csvFilNamn ".\logs\ejAvstängdaKlienter.csv" -data $failedShutdownComputers
}
}
