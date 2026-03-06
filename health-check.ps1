# Health check for The Ovens Secret website
# Tests website availability and Docker container status

param(
    [string]$Domain = "theovensecret.duckdns.org",
    [string]$LogPath = "C:\logs\health-status.txt"
)

# Ensure log directory exists
New-Item -ItemType Directory -Path (Split-Path $LogPath) -Force | Out-Null

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Test website
$siteStatus = "unknown"
$siteHttpCode = "unknown"

try {
    $response = Invoke-WebRequest -Uri "https://$Domain" `
        -SkipCertificateCheck `
        -ErrorAction Stop `
        -TimeoutSec 10 `
        -UseBasicParsing
    
    $siteStatus = "✅ UP"
    $siteHttpCode = $response.StatusCode
} catch {
    $siteStatus = "❌ DOWN"
    $siteHttpCode = $_.Exception.Response.StatusCode
    
    if ($null -eq $siteHttpCode) {
        $siteHttpCode = "No response"
    }
}

# Check Docker containers
$appContainer = docker ps --filter "name=the-ovens-secret-app" --format "{{.State}}"
$nginxContainer = docker ps --filter "name=the-ovens-secret-nginx" --format "{{.State}}"

$dockerStatus = if ($appContainer -eq "running" -and $nginxContainer -eq "running") {
    "✅ Both healthy"
} elseif ($appContainer -eq "running") {
    "⚠️  App running, nginx down"
} elseif ($nginxContainer -eq "running") {
    "⚠️  Nginx running, app down"
} else {
    "❌ Containers not running"
}

# Get system resources
$cpuUsage = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average).Average
$memoryUsage = [math]::Round((Get-WmiObject win32_operatingsystem | ForEach-Object {$_.TotalVisibleMemorySize - $_.FreePhysicalMemory} / $_.TotalVisibleMemorySize * 100))

$logEntry = "[{0}] Site: {1} ({2}) | Docker: {3} | CPU: {4}% | Memory: {5}%" -f `
    $timestamp, $siteStatus, $siteHttpCode, $dockerStatus, $cpuUsage, $memoryUsage

Write-Host $logEntry

# Log with alert if down
if ($siteStatus -like "❌*") {
    $logEntry += " ⚠️  ALERT"
}

Add-Content -Path $LogPath -Value $logEntry

# Clean old logs (keep 30 days)
try {
    Get-ChildItem -Path (Split-Path $LogPath) -Filter "*.txt" -File | 
        Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) } | 
        Remove-Item -Force
} catch {
    # Silently fail on cleanup
}
