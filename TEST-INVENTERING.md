# Inventeringsmodulen – test och integration

Min modul ligger i:

```text
src/inventering.psm1
```

Den exporterar en funktion:

```powershell
Get-NetworkInventory
```

Funktionen söker igenom ett valt IP-intervall och returnerar de maskiner som svarar på ping. Om `-HamtaOS` används försöker den även hämta operativsystem och OS-version via CIM.

## Vad modulen returnerar

För varje maskin som hittas returneras följande fält:

```text
IPAddress
ComputerName
OS
OSVersion
Status
```

Dessa namn är samordnade med nästa del i programmet, så att resultatet senare kan skickas vidare till avstängningslogiken utan att `main.ps1` behöver översätta fälten.

## Viktig avgränsning

Min modul avgör inte om en dator är inaktiv eller ska stängas av.

Den gör detta:

```text
Söker efter nåbara maskiner
→ försöker hämta datornamn och OS-information
→ lämnar resultatet vidare till nästa del
```

Följande gäller för resultatet:

```text
IPAddress    = finns för varje maskin som hittas
ComputerName = blir "Okänt" om DNS-uppslagning misslyckas
OS           = blir "Ej hämtat" utan -HamtaOS, eller "Okänt" om CIM misslyckas
OSVersion    = blir "Ej hämtat" utan -HamtaOS, eller "Okänt" om CIM misslyckas
Status       = visar vad som lyckades hämtas
```

Avstängningslogiken bör därför inte kräva att `ComputerName`, `OS` eller `OSVersion` alltid finns.

## Krav

```text
PowerShell 7 på Windows
```

## Verifierat test

Modulen har testats lokalt i branchen `features/inventering`.

Verifierat:

```text
- Modulen kan importeras utan fel.
- Get-NetworkInventory kan anropas.
- En aktiv klient hittades via ping.
- ComputerName hämtades.
- Lokal OS-information hämtades via CIM.
- Returvärdet följer det överenskomna kontraktet:
  IPAddress, ComputerName, OS, OSVersion, Status.
```

## Testa modulen separat

Kör från projektmappen. Byt nätprefix och hostnummer till en dator som är igång i testnätet.

```powershell
Import-Module .\src\inventering.psm1 -Force -ErrorAction Stop

$resultat = Get-NetworkInventory `
    -NetworkPrefix "192.168.88" `
    -StartHost 252 `
    -EndHost 252 `
    -HamtaOS

$resultat | Format-List *
```

Exempel på resultat:

```text
IPAddress    : 192.168.88.252
ComputerName : CLIENT-01
OS           : Microsoft Windows 11 Pro
OSVersion    : 10.0.26200
Status       : OS-information hämtad lokalt
```

## Hur modulen senare ska användas i `main.ps1`

`main.ps1` ska senare hålla ihop programmets delar:

```text
1. Importera modulerna
2. Ange nätprefix och scope
3. Köra min inventeringsfunktion
4. Skicka resultatet vidare till loggning och avstängningslogik
5. Exportera resultat till CSV
```

Minimal integration för min modul:

```powershell
try {
    # Importera inventeringsmodulen.
    Import-Module "$PSScriptRoot\inventering.psm1" -Force -ErrorAction Stop

    # Ange nät och scope som ska inventeras.
    $networkPrefix = "192.168.88"
    $startHost = 1
    $endHost = 254

    # Kör inventeringen och försök hämta OS-information via CIM.
    $data = Get-NetworkInventory `
        -NetworkPrefix $networkPrefix `
        -StartHost $startHost `
        -EndHost $endHost `
        -HamtaOS

    # Här kan $data senare skickas vidare till avstängningsmodulen.

    # Spara resultatet till CSV.
    $csvFilNamn = "$PSScriptRoot\..\logs\result.csv"

    $data | Export-Csv `
        -Path $csvFilNamn `
        -NoTypeInformation `
        -Encoding UTF8 `
        -ErrorAction Stop
}
catch {
    Write-Error "Inventeringen misslyckades: $($_.Exception.Message)"
}
```

Byt nätprefix och scope till det nät som ska användas vid test eller demonstration.

## Leverans i denna branch

I denna leverans ändrar jag inte `main.ps1`.

Min leverans består av:

```text
src/inventering.psm1
TEST-INVENTERING.md
```

Integrationen i `main.ps1` görs senare tillsammans med gruppens övriga funktioner.
