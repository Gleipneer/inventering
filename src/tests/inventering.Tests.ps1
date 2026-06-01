<#
    Testar inventering av enheter i ett IP nät, genom att mocka ett IP nät
#>

Describe 'ScannaNätverk' {
    ## TODO: mocka ett nätverk med 3 klienter, vet inte om detta fungerar ännu
    Mock Test-Connection { return $() } -ParameterFilter { $ip -eq 192.168.1.101 }
    Mock Test-Connection { return $() } -ParameterFilter { $ip -eq 192.168.1.105 }
    Mock Test-Connection { return $() } -ParameterFilter { $ip -eq 192.168.1.110 }
    It 'Bör hitta 3 klienter i nätverket' {
        $klienter = ScannaNätverk -ipNät 192.168.1.0 # TODO: uppdatera med exakta funktionsnamn när dessa finns tillgängliga senare
        $klienter.Count | Should -be 3
    }
}