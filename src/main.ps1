<#
    Huvudskriptet för att köra inventeringsprogrammet
#>

# Importera moduler
using module ./modules/loggning.psm1
using module ./modules/inventering.psm1

try {
    # Gör en nätverk inventering på nätet 192.168.115.0
    $inventeringData = Get-NetworkInventory -NetworkPrefix 192.168.115

    # Skriv data från nätverksinventeringen till csv fil 
    LoggDataTillCSV -csvFilNamn ".\logs\inventeringResultat.csv" -data $inventeringData
}
catch {
    Write-Output "Error"
}
