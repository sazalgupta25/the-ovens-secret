# Restart The Ovens Secret server

Set-Location $PSScriptRoot

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "🔄 Restarting The Ovens Secret" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "⏳ Restarting containers..." -ForegroundColor Yellow
docker-compose -f docker-compose.prod.yml restart

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ Server restarted successfully" -ForegroundColor Green
    
    Start-Sleep -Seconds 3
    
    Write-Host ""
    Write-Host "📊 Container Status:" -ForegroundColor Cyan
    docker-compose -f docker-compose.prod.yml ps
} else {
    Write-Host ""
    Write-Host "❌ Failed to restart server" -ForegroundColor Red
}

Write-Host ""
Write-Host "🌐 Access your website at: http://localhost" -ForegroundColor Cyan
Write-Host ""
