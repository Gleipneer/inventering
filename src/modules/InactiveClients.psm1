function Get-InactiveClient {
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