<#
    En modul för att logga data
#>

# Skriver ett meddelande till loggfilen och terminalen.
function Write-Log {
    param (
        [string]$Message,
        [string]$Level = "INFO",
        [string]$LogPath
    )

    $rad = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [$Level] $Message"
    Add-Content -Path $LogPath -Value $rad
    Write-Host $rad
}
# Skriver data till en csv fil
function LoggDataTillCSV {
    param (
            [string]$csvFilNamn, # namnet på csv filen som det ska skrivas till
            $data # data som ska skrivas till csv filen
        )

    if ($null -eq $data -or @($data).Count -eq 0) {
        New-Item -ItemType File -Path $csvFilNamn -Force | Out-Null
        return
    }

    $data | export-csv -Path $csvFilNamn -NoTypeInformation

}

function Write-Log {
    param (
            [string]$Message,
            [string]$Level = "INFO",
            [string]$LogPath = ".\logs\NetworkInventory.log"
        )

    $logMapp = Split-Path -Parent $LogPath
    if ($logMapp -and -not (Test-Path $logMapp)) {
        New-Item -ItemType Directory -Path $logMapp -Force | Out-Null
    }

    $tid = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $rad = "[$tid] [$Level] $Message"

    Add-Content -Path $LogPath -Value $rad
    Write-Output $rad
}

# Gör funktionen tillgänglig när modulen importeras.
Export-ModuleMember -Function LoggDataTillCSV, Write-Log
