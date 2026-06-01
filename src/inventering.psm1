<#
    Inventering.psm1

    Söker efter maskiner som svarar på ping i ett valt IPv4-intervall.
    Med -HamtaOS försöker funktionen även hämta OS-information via CIM.

    Krav: PowerShell 7 på Windows.

    Begränsning:
    En maskin som blockerar ping kommer inte med i resultatet.
#>

function Get-NetworkInventory {
    param (
        # Nätets första tre delar, till exempel "192.168.88".
        [Parameter(Mandatory)]
        [string]$NetworkPrefix,

        # Första och sista adressen som ska testas.
        [int]$StartHost = 1,
        [int]$EndHost = 254,

        # Lägg till denna parameter om OS-information ska hämtas via CIM.
        [switch]$HamtaOS
    )

    # Kontrollera att angivet scope är giltigt.
    if ($StartHost -lt 1 -or $EndHost -gt 254 -or $StartHost -gt $EndHost) {
        throw "StartHost och EndHost måste vara mellan 1 och 254, och StartHost får inte vara större än EndHost."
    }

    # 1. Skapa listan med IP-adresser som ska testas.
    $allaAdresser = foreach ($nummer in $StartHost..$EndHost) {
        "$NetworkPrefix.$nummer"
    }

    # 2. Pinga adresserna parallellt.
    # Endast adresser som svarar sparas vidare.
    $svarandeAdresser = @(
        $allaAdresser | ForEach-Object -Parallel {
            if (Test-Connection -TargetName $_ -IPv4 -Count 1 -Quiet -TimeoutSeconds 1) {
                $_
            }
        } -ThrottleLimit 32
    )

    # 3. Skapa resultat för varje maskin som svarade.
    $resultat = foreach ($ipAdress in $svarandeAdresser) {
        $datornamn = "Okänt"
        $operativsystem = "Ej hämtat"
        $osVersion = "Ej hämtat"
        $status = "Maskin hittad"

        # Försök hitta datornamn via DNS.
        try {
            $dnsSvar = Resolve-DnsName -Name $ipAdress -ErrorAction Stop |
                Where-Object { $_.NameHost } |
                Select-Object -First 1

            if ($dnsSvar.NameHost) {
                $datornamn = $dnsSvar.NameHost.TrimEnd(".")
            }
        }
        catch {
            # Behåll värdet "Okänt" om DNS-uppslagningen misslyckas.
        }

        # Försök hämta OS-information endast om -HamtaOS används.
        if ($HamtaOS) {

            # Utan datornamn görs ingen CIM-fråga.
            if ($datornamn -eq "Okänt") {
                $operativsystem = "Okänt"
                $osVersion = "Okänt"
                $status = "Maskin hittad, inget datornamn för OS-fråga"
            }

            # Om det är den lokala datorn hämtas informationen lokalt.
            elseif (($datornamn -split '\.')[0] -ieq $env:COMPUTERNAME) {
                try {
                    $osInfo = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop

                    $operativsystem = $osInfo.Caption
                    $osVersion = $osInfo.Version
                    $status = "OS-information hämtad lokalt"
                }
                catch {
                    $operativsystem = "Okänt"
                    $osVersion = "Okänt"
                    $status = "Maskin hittad, lokal OS-information kunde inte läsas"
                }
            }

            # Om det är en annan dator försöker modulen läsa OS via fjärr-CIM.
            else {
                try {
                    $osInfo = Get-CimInstance `
                        -ClassName Win32_OperatingSystem `
                        -ComputerName $datornamn `
                        -OperationTimeoutSec 3 `
                        -ErrorAction Stop

                    $operativsystem = $osInfo.Caption
                    $osVersion = $osInfo.Version
                    $status = "OS-information hämtad från fjärrdator"
                }
                catch {
                    $operativsystem = "Okänt"
                    $osVersion = "Okänt"
                    $status = "Maskin hittad, OS kunde inte läsas"
                }
            }
        }

        # Returnera ett resultatobjekt för maskinen.
        [PSCustomObject]@{
    IPAddress    = $ipAdress
    ComputerName = $datornamn
    OS           = $operativsystem
    OSVersion    = $osVersion
    Status       = $status
}
    }

    return @($resultat)
}

# Gör funktionen tillgänglig när modulen importeras.
Export-ModuleMember -Function Get-NetworkInventory