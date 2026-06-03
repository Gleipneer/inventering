<#
    Huvudskriptet för att köra inventeringsprogrammet
#>

# Importera moduler
using module ./modules/loggning.psm1
using module ./modules/inventering.psm1
using module ./modules/InactiveClients.psm1
using module ./modules/ClientShutdown.psm1

try {
    # Tillgängliga params för Get-NetworkInventory: -NetworkPrefix -StartHost -EndHost -HamtaOS
    # Gör en nätverk inventering på nätet 192.168.115.0, försök hämta OS för varje enhet
    $inventeringData = Get-NetworkInventory -NetworkPrefix 192.168.115 -HamtaOS

    # Skriv data från nätverksinventeringen till csv fil 
    LoggDataTillCSV -csvFilNamn ".\logs\inventeringResultat.csv" -data $inventeringData
}
catch {
    Write-Output "Error"
}
