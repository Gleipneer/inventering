<#
    Stanger av en godkand testklient eller simulerar avstangningen.
#>

function Invoke-ClientShutdown {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        $Computers,

        [ValidateSet("Simulate", "Shutdown")]
        [string]$Mode = "Simulate",

        [int]$DelayMinutes = 0,

        [string]$LogPath = "C:\Logs\NetworkInventory.log",

        [string]$ApprovedComputerName = "PC01.bluestar5.local"
    )

    process {
        foreach ($computer in @($Computers)) {
            $name = $computer.ComputerName
            $ip = $computer.IPAddress

            if ($Mode -eq "Simulate") {
                Write-Log `
                    -Message "[SIMULATE] Skulle stangt av $name ($ip)" `
                    -Level "INFO" `
                    -LogPath $LogPath

                continue
            }

            if ($name -ne $ApprovedComputerName) {
                Write-Log `
                    -Message "BLOCKERAD: $name ar inte godkand testklient." `
                    -Level "ERROR" `
                    -LogPath $LogPath

                continue
            }

            $delaySekunder = $DelayMinutes * 60

            if ($PSCmdlet.ShouldProcess($name, "Stang av testklient")) {
                Invoke-Command -ComputerName $name -ScriptBlock {
                    param ($delay)
                    shutdown.exe /s /t $delay /f /c "Gron IT-policy"
                } -ArgumentList $delaySekunder -ErrorAction Stop

                Write-Log `
                    -Message "OK: Avstangning schemalagd pa $name." `
                    -Level "OK" `
                    -LogPath $LogPath
            }
        }
    }
}

Export-ModuleMember -Function Invoke-ClientShutdown
