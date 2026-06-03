# Klient-avstängningsmodulen

En PowerShell-modul för automatisk avstängning av klienter i ett nätverk. Modulen är en del av projektet **Grön IT-policy** och är designad för att ta emot inventerad nätverksdata, filtrera klienter och stänga av dem på ett kontrollerat sätt.

---

## Vad modulen gör

Modulen tar emot en lista av klienter från ett nätverksinventeringsverktyg, filtrerar bort de som inte ska stängas av och skickar en fjärravstängning till resterande klienter via PowerShell Remoting (WinRM). Resultatet av varje avstängning returneras för vidare loggning.

---

## Filer

| Fil | Beskrivning |
|-----|-------------|
| `InactiveClient.ps1` | Tar emot klientobjekt och filtrerar. Placeholder för framtida inaktivitetskriterier. |
| `ClientShutdown.ps1` | Stänger av klienter via WinRM och returnerar resultat per klient. |
| `Initialize.ps1` | Kontrollerar och konfigurerar förutsättningar (WinRM, TrustedHosts) inför körning. |

---

## Förutsättningar

### På servern (där modulen körs)
- Windows Server med PowerShell 5.1 eller senare
- WinRM aktiverat
- TrustedHosts konfigurerat (hanteras automatiskt av `Initialize.ps1`)
- Nätverksåtkomst till klienterna

### På klienterna
- WinRM aktiverat
- Lokal administratörsbehörighet

> **Observera:** Modulen är designad för domänanslutna miljöer och använder datornamn för anslutning via WinRM.

---

## Returvärde

`Invoke-ClientShutdown` returnerar ett objekt per klient med följande egenskaper:

| Egenskap | Beskrivning |
|----------|-------------|
| `ComputerName` | Datornamn |
| `IPAddress` | IP-adress |
| `Mode` | Simulate eller Shutdown |
| `DelayMinutes` | Fördröjning i minuter |
| `Result` | Framgång eller Misslyckat |
| `Reason` | Detalj om vad som hände |
| `Timestamp` | Tidsstämpel för operationen |

---

## Framtida utveckling

- **InactiveClient.ps1** är förberedd för framtida logik som filtrerar bort klienter baserat på inaktivitetskriterier, exempelvis inloggad användare eller tid sedan senaste aktivitet.