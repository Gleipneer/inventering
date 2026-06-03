<#
    Initialize-skriptet för inventeringsprojektet
    
    Kör detta en gång före Main.ps1 för att säkra att alla förutsättningar uppfylls:
    - WinRM aktiverat och körs
    - TrustedHosts konfigurerat
#>

function Initialize-NetworkInventory {
    Write-Host "Kontrollerar förutsättningar..." -ForegroundColor Yellow
    
    # 1. Kontrollera WinRM på servern
    $winRM = Get-Service WinRM -ErrorAction SilentlyContinue
    if ($winRM.Status -ne 'Running') {
        Write-Host "  Aktiverar WinRM..." -ForegroundColor Yellow
        try {
            Enable-PSRemoting -Force -SkipNetworkProfileCheck -ErrorAction Stop
            Write-Host "  WinRM aktiverad" -ForegroundColor Green
        }
        catch {
            Write-Host "  FEL: Kunde inte aktivera WinRM - $_" -ForegroundColor Red
            throw
        }
    } else {
        Write-Host "  WinRM redan igång" -ForegroundColor Green
    }
    
    # 2. Kontrollera TrustedHosts
    $trustedHosts = (Get-Item WSMan:\localhost\Client\TrustedHosts -ErrorAction SilentlyContinue).Value
    if ($trustedHosts -ne '*') {
        Write-Host "  Konfigurerar TrustedHosts..." -ForegroundColor Yellow
        try {
            Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*' -Force -ErrorAction Stop
            Write-Host "  TrustedHosts konfigurerad" -ForegroundColor Green
        }
        catch {
            Write-Host "  FEL: Kunde inte konfigurera TrustedHosts - $_" -ForegroundColor Red
            throw
        }
    } else {
        Write-Host "  TrustedHosts redan konfigurerad" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "Förutsättningar OK!" -ForegroundColor Green
    Write-Host ""
}

# Kör Initialize om scriptet körs direkt
if ($MyInvocation.InvocationName -eq '.') {
    # Scriptet laddades med dot-sourcing, gör ingenting
} else {
    # Scriptet körs direkt
    Initialize-NetworkInventory
}
