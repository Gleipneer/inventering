function Get-InactiveClient {
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $Computers
    )

    process {
        foreach ($computer in $Computers) {

            try {
                $loggedOnUser = gwmi win32_loggedonuser -computername $computer.ComputerName

                # Returnera bara klienter där ingen är inloggad
                if (!($loggedOnUser)) {
                    $computer
                }
            }
            catch {
                Write-Output "Error, kunde ej slå upp någon dator"
            }
        }
    }
}