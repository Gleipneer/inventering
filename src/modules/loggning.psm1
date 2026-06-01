<#
    En modul för att logga data
#>

# Skriver data till en csv fil
function LoggDataTillCSV {
    param (
            [string]$csvFilNamn, # namnet på csv filen som det ska skrivas till
            $data # data som ska skrivas till csv filen
        )

    $data | export-csv -Path $csvFilNamn -NoTypeInformation

}

Export-ModuleMember -Function LoggDataTillCSV