# Safely stop The Ovens Secret server

Set-Location C:\sazal\the-ovens-secret

Write-Host ""
Write-Host "======================================" -ForegroundColor Yellow
Write-Host "🛑 Stopping The Ovens Secret" -ForegroundColor Yellow
Write-Host "======================================" -ForegroundColor Yellow
Write-Host ""

Write-Host "⏳ Stopping containers gracefully..." -ForegroundColor Yellow
docker-compose -f docker-compose.prod.yml down

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ Server stopped successfully" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "⚠️  There were issues stopping the server" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "📊 Running containers:" -ForegroundColor Cyan
docker ps

Write-Host ""
Write-Host "💡 To start again, use: .\start-production.ps1" -ForegroundColor Gray
Write-Host ""
