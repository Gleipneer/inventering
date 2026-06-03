<#
    Huvudskriptet för att köra inventeringsprogrammet
#>

# Importera moduler
using module ./modules/loggning.psm1
using module ./modules/inventering.psm1
using module ./modules/InactiveClients.psm1
using module ./modules/ClientShutdown.psm1
using module ./modules/Initialize.psm1

try {
    Initialize-NetworkInventory

    # Tillgängliga params för Get-NetworkInventory: -NetworkPrefix -StartHost -EndHost -HamtaOS
    # Gör en nätverk inventering på nätet 192.168.115.0, försök hämta OS för varje enhet
    $inventeringData = Get-NetworkInventory -NetworkPrefix 192.168.56 -StartHost 10 -EndHost 10 -HamtaOS

    # Skicka inventeringsresultatet vidare till nästa steg i flödet.
    $inactiveClients = $inventeringData | Get-InactiveClient

    # Kör avstängningsmodulen i simuleringsläge via main-skriptet.
    $inactiveClients | Invoke-ClientShutdown -Mode Shutdown

    # Skriv data från nätverksinventeringen till csv fil 
    LoggDataTillCSV -csvFilNamn ".\logs\inventeringResultat.csv" -data $inventeringData
}
catch {
    Write-Output "Error: $($_.Exception.Message)"
}
