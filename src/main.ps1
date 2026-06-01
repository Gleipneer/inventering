<#
    Huvudskriptet för att köra inventeringsprogrammet
#>
try {
    Write-Output "Hej, denna filen är fortfarande ganska tom, borde anropa lite funktioner här"

    # Spara data till en CSV fil
    $csvFilNamn = ".\logs\result.csv"

    # TODO: lägg in faktisk data som ska loggas här
    $data = @(
        [PSCustomObject]@{
            ip = "test"
            hostname = "test"
        }
    )

    $data | export-csv -Path $csvFilNamn -NoTypeInformation
}
catch {
    Write-Output "Error"
}
