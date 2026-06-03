#requires -Version 7.0

<#
    Huvudskriptet for att kora inventeringsprogrammet.
    PC01 ar godkand testklient i VM-labben.
#>

param (
    [ValidateSet("Simulate", "Shutdown")]
    [string]$Mode = "Simulate"
)

Import-Module "$PSScriptRoot\modules\loggning.psm1" -Force
Import-Module "$PSScriptRoot\modules\inventering.psm1" -Force
Import-Module "$PSScriptRoot\modules\InactiveClients.psm1" -Force
Import-Module "$PSScriptRoot\modules\ClientShutdown.psm1" -Force

try {
    New-Item -ItemType Directory -Path ".\logs" -Force | Out-Null
    $logPath = ".\logs\NetworkInventory.log"

    # Inventera endast den godkanda testklienten PC01.
    $inventeringData = Get-NetworkInventory `
        -NetworkPrefix "192.168.14" `
        -StartHost 100 `
        -EndHost 100 `
        -HamtaOS

    LoggDataTillCSV -csvFilNamn ".\logs\inventeringResultat.csv" -data $inventeringData

    Write-Host "Inventeringsresultat:"
    $inventeringData | Format-Table IPAddress, ComputerName, OS, Status -AutoSize

    # Get-InactiveClient behaller endast klienter dar ingen anvandare ar inloggad.
    $inaktivaKlienter = $inventeringData | Get-InactiveClient

    Write-Host "Inaktiva klientkandidater:"
    $inaktivaKlienter | Format-Table IPAddress, ComputerName, OS -AutoSize

    $inaktivaKlienter |
        Invoke-ClientShutdown `
            -Mode $Mode `
            -LogPath $logPath `
            -ApprovedComputerName "PC01.bluestar5.local"
}
catch {
    Write-Host "Fel: $($_.Exception.Message)"
}
