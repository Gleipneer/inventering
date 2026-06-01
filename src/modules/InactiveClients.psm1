function Get-InactiveClients {
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $Computers
    )

    process {
        foreach ($computer in $Computers) {
            $computer
        }
    }
}
