# Renew SSL certificates for The Ovens Secret
# This script should be scheduled to run weekly (Sunday 2 AM)

param(
    [string]$Domain = "theovensecret.duckdns.org"
)

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "🔄 SSL Certificate Renewal" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Check if certbot is installed
try {
    certbot --version | Out-Null
} catch {
    Write-Host "❌ Certbot is not installed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Install from: https://certbot.eff.org/" -ForegroundColor Yellow
    exit 1
}

# Stop Docker containers
Write-Host "🛑 Stopping Docker containers..." -ForegroundColor Yellow
Set-Location $PSScriptRoot
docker-compose -f docker-compose.prod.yml down

Start-Sleep -Seconds 2

# Renew certificates
Write-Host ""
Write-Host "🔐 Renewing SSL certificates..." -ForegroundColor Yellow
certbot renew --standalone --non-interactive --agree-tos

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ Certificate renewal completed successfully" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "⚠️  Certificate renewal had issues (this may be normal if not due for renewal)" -ForegroundColor Yellow
}

# Restart Docker
Write-Host ""
Write-Host "🚀 Restarting Docker containers..." -ForegroundColor Yellow
docker-compose -f docker-compose.prod.yml up -d

Start-Sleep -Seconds 5

# Verify
Write-Host ""
Write-Host "📋 Certificate Status:" -ForegroundColor Cyan
certbot certificates

Write-Host ""
Write-Host "📊 Container Status:" -ForegroundColor Cyan
docker-compose -f docker-compose.prod.yml ps

Write-Host ""
Write-Host "✅ Renewal process completed" -ForegroundColor Green
Write-Host ""
