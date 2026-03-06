# Production startup script for The Ovens Secret
# This script builds and starts your website using Docker

param(
    [switch]$NoBuild = $false
)

Set-Location C:\sazal\the-ovens-secret

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "🚀 The Ovens Secret - Production Server" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is running
try {
    docker ps > $null 2>&1
} catch {
    Write-Host "❌ Docker Desktop is not running!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please start Docker Desktop and try again."
    exit 1
}

Write-Host "✅ Docker is running" -ForegroundColor Green

# Load environment variables from .env.production
if (Test-Path ".env.production") {
    Write-Host "✅ Found .env.production" -ForegroundColor Green
    $envVars = @{}
    Get-Content .env.production | ForEach-Object {
        if ($_ -notmatch "^#" -and $_ -notmatch "^$") {
            $name, $value = $_.Split('=', 2)
            $envVars[$name.Trim()] = $value.Trim()
        }
    }
} else {
    Write-Host "⚠️  .env.production not found - using defaults" -ForegroundColor Yellow
}

# Clean up any stopped containers
Write-Host ""
Write-Host "🧹 Cleaning up old containers..." -ForegroundColor Yellow
docker-compose -f docker-compose.prod.yml down 2>$null | Out-Null

# Build image if needed
if (-not $NoBuild) {
    Write-Host "🔨 Building Docker image..." -ForegroundColor Yellow
    docker-compose -f docker-compose.prod.yml build --no-cache
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Docker build failed!" -ForegroundColor Red
        exit 1
    }
}

# Start the application
Write-Host ""
Write-Host "🚀 Starting application..." -ForegroundColor Yellow
docker-compose -f docker-compose.prod.yml up -d

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to start application!" -ForegroundColor Red
    exit 1
}

# Wait for services to be ready
Write-Host "⏳ Waiting for services to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Verify status
Write-Host ""
Write-Host "📊 Container Status:" -ForegroundColor Cyan
docker-compose -f docker-compose.prod.yml ps

Write-Host ""
Write-Host "✅ Server is running!" -ForegroundColor Green
Write-Host ""
Write-Host "🌐 Access your website at:" -ForegroundColor Cyan
Write-Host "   • Local:  http://localhost" -ForegroundColor White
Write-Host "   • Public: https://theovensecret.duckdns.org" -ForegroundColor White
Write-Host ""
Write-Host "📋 View logs: .\view-logs.ps1" -ForegroundColor Gray
Write-Host "🛑 Stop server: .\stop-server.ps1" -ForegroundColor Gray
Write-Host ""
