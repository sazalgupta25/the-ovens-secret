# Backup script for The Ovens Secret
# Creates compressed backup of website files

param(
    [string]$BackupPath = "C:\backups\the-ovens-secret",
    [string]$SourcePath = $PSScriptRoot,
    [int]$DaysToKeep = 30
)

# Create backup directory if it doesn't exist
New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null

$date = Get-Date -Format "yyyy-MM-dd_HHmmss"
$zipFile = "$BackupPath\backup-$date.zip"

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "💾 Creating Backup" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📦 Backup file: $zipFile" -ForegroundColor Yellow

try {
    # Include important files and directories
    $itemsToBackup = @(
        "$SourcePath\lib",
        "$SourcePath\web",
        "$SourcePath\assets",
        "$SourcePath\.env.production",
        "$SourcePath\nginx.conf",
        "$SourcePath\Dockerfile",
        "$SourcePath\docker-compose.prod.yml",
        "$SourcePath\pubspec.yaml"
    )
    
    # Filter to existing items only
    $existingItems = $itemsToBackup | Where-Object { Test-Path $_ }
    
    if ($existingItems.Count -eq 0) {
        Write-Host "❌ No files found to backup" -ForegroundColor Red
        exit 1
    }
    
    # Create backup
    Write-Host "⏳ Compressing files..." -ForegroundColor Yellow
    Compress-Archive -Path $existingItems -DestinationPath $zipFile -Force
    
    $backupSize = [math]::Round((Get-Item $zipFile).Length / 1MB, 2)
    Write-Host "✅ Backup created successfully ($backupSize MB)" -ForegroundColor Green
    
    # Clean up old backups
    Write-Host ""
    Write-Host "🧹 Cleaning up backups older than $DaysToKeep days..." -ForegroundColor Yellow
    
    $removed = 0
    Get-ChildItem -Path $BackupPath -Filter "backup-*.zip" -File | 
        Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$DaysToKeep) } | 
        ForEach-Object {
            Remove-Item -Path $_.FullName -Force
            $removed++
        }
    
    Write-Host "✅ Removed $removed old backup(s)" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "📊 Backup Summary:" -ForegroundColor Cyan
    Write-Host "   Latest: $zipFile" -ForegroundColor White
    Write-Host "   Size: $backupSize MB" -ForegroundColor White
    Write-Host "   Total backups: $((Get-ChildItem -Path $BackupPath -Filter "*.zip").Count)" -ForegroundColor White

} catch {
    Write-Host "❌ Backup failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
