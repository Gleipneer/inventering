function Get-InactiveClient {
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $Computers
    )

    process {
        foreach ($computer in $Computers) {

            try {
                $cs = Get-CimInstance `
                    -ClassName Win32_ComputerSystem `
                    -ComputerName $computer.ComputerName `
                    -ErrorAction Stop

                # Returnera bara klienter där ingen är inloggad
                if ([string]::IsNullOrWhiteSpace($cs.UserName)) {
                    $computer
                }
            }
            catch {
                Write-Output "Error, kunde ej slå upp någon dator"
            }
        }
    }
}
