function Invoke-ClientShutdown {
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $Computers,

        [ValidateSet('Simulate', 'Shutdown')]
        [string]$Mode = 'Simulate',

        [int]$DelayMinutes = 0,

        [string]$LogPath = 'C:\Logs\NetworkInventory.log'
    )

    process {
        foreach ($computer in $Computers) {

            $name = $computer.ComputerName
            $ip   = $computer.IPAddress

            if ($Mode -eq 'Simulate') {
                Write-Log "[SIMULATE] Skulle stangt av $name ($ip)" -LogPath $LogPath
                continue
            }

            Write-Log "Stangar av $name ($ip)..." -LogPath $LogPath

            $delaySec = $DelayMinutes * 60

            & shutdown.exe /s /m "\\$name" /t $delaySec /f /c "Gron IT-policy" 2>$null

            if ($LASTEXITCODE -eq 0) {
                Write-Log "  OK: Avstangning schemalagd pa $name" -Level OK -LogPath $LogPath
            } else {
                Write-Log "  FEL: Kunde inte stanga av $name (exit $LASTEXITCODE)" -Level ERROR -LogPath $LogPath
            }
        }
    }
}
