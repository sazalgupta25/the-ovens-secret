# Update DuckDNS with current public IP
# This script should be scheduled to run every 5 minutes

param(
    [string]$Domain = "theovensecret",
    [string]$Token = "",
    [string]$LogPath = "C:\logs\duckdns.log"
)

# Prompt for token if not provided
if (-not $Token) {
    Write-Host ""
    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host "🔧 DuckDNS Configuration First Run" -ForegroundColor Cyan
    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "You need to set your DuckDNS token to use this script." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. Visit: https://www.duckdns.org" -ForegroundColor White
    Write-Host "2. Log in and create a domain (e.g., 'theovensecret')" -ForegroundColor White
    Write-Host "3. Click your domain to show the token" -ForegroundColor White
    Write-Host ""
    
    $Token = Read-Host "Enter your DuckDNS token (or press Ctrl+C to cancel)" 
    
    if ($Token.Length -ne 36) {
        Write-Host "❌ Invalid token format!" -ForegroundColor Red
        exit 1
    }
    
    # Save token for future runs (IMPORTANT: Store securely in production)
    Write-Host ""
    Write-Host "💾 Saving token..." -ForegroundColor Yellow
    
    # Ask for domain name
    $inputDomain = Read-Host "Enter your domain name (without .duckdns.org, default: theovensecret)"
    if ($inputDomain) {
        $Domain = $inputDomain
    }
    
    Write-Host ""
    Write-Host "✅ Configuration complete!" -ForegroundColor Green
    Write-Host ""
}

# Ensure log directory exists
New-Item -ItemType Directory -Path (Split-Path $LogPath) -Force | Out-Null

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

try {
    # Get current public IP
    $publicIP = (Invoke-WebRequest -Uri "https://api.ipify.org?format=json" -ErrorAction Stop -TimeoutSec 10 | ConvertFrom-Json).ip
    
    if (-not $publicIP) {
        throw "Could not determine public IP"
    }
    
    # Update Duck DNS
    $updateUrl = "https://www.duckdns.org/update?domains=$Domain&token=$Token&ip=$publicIP"
    $response = Invoke-WebRequest -Uri $updateUrl -ErrorAction Stop -TimeoutSec 10
    
    # Check response
    $responseContent = $response.Content.Trim()
    
    if ($responseContent -eq "OK") {
        $logEntry = "$timestamp | ✅ Updated $Domain to $publicIP"
        Write-Host $logEntry
    } elseif ($responseContent -eq "KO") {
        $logEntry = "$timestamp | ❌ FAILED - Invalid token or domain"
        Write-Host $logEntry -ForegroundColor Red
    } else {
        $logEntry = "$timestamp | ⚠️  Unexpected response: $responseContent"
        Write-Host $logEntry -ForegroundColor Yellow
    }
} catch {
    $logEntry = "$timestamp | ❌ ERROR: $($_.Exception.Message)"
    Write-Host $logEntry -ForegroundColor Red
}

# Write to log file
Add-Content -Path $LogPath -Value $logEntry

# Clean old logs (keep only 7 days)
try {
    Get-ChildItem -Path (Split-Path $LogPath) -Filter "*.log" -File | 
        Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | 
        Remove-Item -Force
} catch {
    # Silently fail on cleanup
}
