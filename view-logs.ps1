# View logs for The Ovens Secret containers
# Use Ctrl+C to exit log streaming

param(
    [int]$Lines = 50,
    [switch]$Follow = $false
)

Set-Location $PSScriptRoot

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "📋 The Ovens Secret - Server Logs" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

if ($Follow) {
    Write-Host "⏰ Following logs in real-time (Ctrl+C to exit)..." -ForegroundColor Yellow
    Write-Host ""
    docker-compose -f docker-compose.prod.yml logs -f
} else {
    Write-Host "📊 Last $Lines lines of logs:" -ForegroundColor Yellow
    Write-Host ""
    docker-compose -f docker-compose.prod.yml logs --tail=$Lines
    
    Write-Host ""
    Write-Host "💡 Tip: To follow logs in real-time, use: .\view-logs.ps1 -Follow" -ForegroundColor Gray
}

Write-Host ""
