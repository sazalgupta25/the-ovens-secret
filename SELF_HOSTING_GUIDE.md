# Self-Hosting Guide: Deploy The Ovens Secret on Your Local Machine

This comprehensive guide walks you through deploying your Next.js website using Docker Desktop on your local laptop and making it publicly accessible via a custom domain. **No hosting fees required!**

---

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Phase 1: Prepare Your Local Environment](#phase-1-prepare-your-local-environment)
3. [Phase 2: Router Configuration](#phase-2-router-configuration)
4. [Phase 3: Dynamic DNS Setup](#phase-3-dynamic-dns-setup)
5. [Phase 4: Domain Configuration](#phase-4-domain-configuration)
6. [Phase 5: Deploy with Docker](#phase-5-deploy-with-docker)
7. [Phase 6: HTTPS/SSL Setup](#phase-6-httpssl-setup)
8. [Phase 7: Maintenance & Monitoring](#phase-7-maintenance--monitoring)
9. [Troubleshooting](#troubleshooting)

---

## System Requirements

### Hardware (Your Laptop)
- **Processor**: Modern multi-core CPU (4+ cores recommended)
- **RAM**: Minimum 8GB (16GB+ recommended for comfortable operation)
- **Storage**: At least 50GB free space for Docker images and application data
- **Internet**: Stable connection with good upload/download speeds (minimum 10 Mbps)
- **Power**: Must remain on 24/7 (consider AC power to prevent sleeping)

### Software Prerequisites
- ✅ **Docker Desktop** installed (Windows 10/11 Pro/Enterprise)
- ✅ **Git** (for version control)
- ✅ Internet access
- ✅ Access to your router's admin panel
- ✅ Static or Dynamic IP management

### Windows Configuration
```powershell
# Verify Docker Desktop is installed and running
docker --version
docker run hello-world

# Enable required Windows features if needed
# (Usually pre-enabled with Docker Desktop installation)
wsl --list --verbose
```

---

## Phase 1: Prepare Your Local Environment

### Step 1.1: Verify Project Setup

```powershell
cd C:\sazal\the-ovens-secret

# Verify Docker files exist
Get-ChildItem -Name Dockerfile, docker-compose.prod.yml, nginx.conf
```

**Expected output:**
```
Dockerfile
docker-compose.prod.yml
nginx.conf
```

### Step 1.2: Test Docker Build Locally

Before exposing to the internet, verify everything works:

```powershell
# Build the Docker image
docker build -t the-ovens-secret:latest .

# Run locally to test (Ctrl+C to stop)
docker-compose -f docker-compose.prod.yml up

# In another terminal, test the application
curl http://localhost
```

Visit `http://localhost` in your browser. You should see your website.

### Step 1.3: Configure Environment Variables

Create a `.env.production` file for production settings:

```bash
# .env.production
NODE_ENV=production
NEXT_PUBLIC_APP_NAME=The Ovens Secret
NEXT_PUBLIC_APP_DESCRIPTION=Discover the hidden wonders of artisan baking
NEXT_PUBLIC_API_URL=https://yourdomain.com/api
```

**Note**: Update `yourdomain.com` after you've registered your domain (Phase 4).

### Step 1.4: Update docker-compose.prod.yml

Modify your production compose file to pull from `.env.production`:

```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: the-ovens-secret-app
    expose:
      - "3000"
    environment:
      - NODE_ENV=production
      - NEXT_PUBLIC_APP_NAME=${NEXT_PUBLIC_APP_NAME}
      - NEXT_PUBLIC_APP_DESCRIPTION=${NEXT_PUBLIC_APP_DESCRIPTION}
      - NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "node", "-e", "require('http').get('http://localhost:3000', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 10s
    networks:
      - app-network
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M

  nginx:
    image: nginx:alpine
    container_name: the-ovens-secret-nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./letsencrypt:/etc/letsencrypt:ro
    depends_on:
      app:
        condition: service_healthy
    restart: unless-stopped
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
```

### Step 1.5: Laptop Power Settings

Configure your laptop to never sleep:

**Windows Settings:**
```
Settings → System → Power & battery → Screen and sleep
  - Screen timeout: Never
  - Sleep timeout: Never

Settings → System → Power & battery → Power mode
  - Set to "Best performance"

Control Panel → Power Options
  - Set plan to "High Performance"
  - Click "Change plan settings" → "Change advanced power settings"
  - Hard disk: Turn off after: Never
  - Sleep: Sleep after: Never
```

**Alternative: Use a Batch Script**

Create `keep-awake.bat` to prevent sleep:

```batch
@echo off
REM Run every 2 minutes to prevent sleep
:loop
ping localhost -n 121 > NUL
goto loop
```

Schedule this with Task Scheduler to run at startup.

---

## Phase 2: Router Configuration

This step makes your website accessible from the internet by forwarding traffic to your laptop.

### Step 2.1: Find Your Router's IP Address

```powershell
# Find default gateway (router IP)
ipconfig

# Look for "Default Gateway" - usually 192.168.1.1 or 192.168.0.1
```

### Step 2.2: Save Your Laptop's Local IP

```powershell
# Find your laptop's local IP (not the default gateway)
ipconfig

# Look for "IPv4 Address" under your ethernet/WiFi adapter
# Example: 192.168.1.100
```

**Keep this IP address handy!** You'll need it for port forwarding.

### Step 2.3: Access Router Admin Panel

1. Open a browser and enter your router's IP: `http://192.168.1.1`
2. Log in with default credentials (usually admin/admin)
3. Look for "Port Forwarding" or "Virtual Server" settings

### Step 2.4: Configure Port Forwarding

**Goal**: Forward ports 80 and 443 from the internet to your laptop

| Port | Protocol | Internal IP | Internal Port | Description |
|------|----------|-------------|---------------|-------------|
| 80 | TCP | 192.168.1.100 | 80 | HTTP traffic |
| 443 | TCP | 192.168.1.100 | 443 | HTTPS traffic |

**Example (varies by router):**

```
Port Forwarding Rules:
├─ External Port: 80 → Internal IP: 192.168.1.100 → Internal Port: 80
└─ External Port: 443 → Internal IP: 192.168.1.100 → Internal Port: 443
```

### Step 2.5: Verify Port Forwarding

Use an online port checker:
- [CanYouSeeMe.org](https://canyouseeme.org)
- [PortChecker.co](https://www.portchecker.co)

From your laptop:

```powershell
# This might fail until Docker is running (Phase 5)
# But you should see something listening on port 80
netstat -ano | findstr :80
```

### Step 2.6: Set a Static Local IP (Important!)

Prevent your laptop's IP from changing:

1. Router admin panel → DHCP settings
2. Find "DHCP Reservation" or "Device List"
3. Select your laptop and click "Reserve IP"
4. Confirm it's set to the IP you saved in Step 2.2

---

## Phase 3: Dynamic DNS Setup

Since home internet IPs change periodically, you need dynamic DNS to keep your domain pointing to your laptop.

### Step 3.1: Why Dynamic DNS?

- ISPs change your public IP every 24-30 days (or on modem restart)
- Dynamic DNS automatically updates when your IP changes
- Your domain always points to the correct IP

### Step 3.2: Choose a Dynamic DNS Service

**Free Options:**
- **Duck DNS** (duckdns.org) - Very reliable, free
- **No-IP** (noip.com) - Free tier available
- **Cloudflare** - Free DNS (requires domain on Cloudflare)

**Recommended: Duck DNS**

### Step 3.3: Set Up Duck DNS

#### On Duck DNS Website:

1. Visit [duckdns.org](https://www.duckdns.org)
2. Click "Log in with..."
3. Create an account (GitHub/Google recommended)
4. Add a new domain:
   - Domain name: `theovensecret` (becomes `theovensecret.duckdns.org`)
5. Click "Add domain"
6. Copy your **token** (save this!)

#### On Your Windows Laptop:

**Option A: Use DuckDNS Windows Client (Easiest)**

1. Download [DuckDNS Windows Update Client](https://www.duckdns.org/install.jsp?tab=windows)
2. Run the installer
3. Configure with your domain and token
4. It will automatically update when your IP changes ✅

**Option B: Create a PowerShell Script**

Create `update-duckdns.ps1`:

```powershell
# DuckDNS Update Script
$domain = "theovensecret"  # Replace with your domain
$token = "YOUR_TOKEN_HERE"  # Replace with your token from Duck DNS
$logFile = "C:\logs\duckdns.log"

# Ensure log directory exists
New-Item -ItemType Directory -Path "C:\logs" -Force | Out-Null

# Get current public IP
$publicIP = (Invoke-WebRequest -Uri "https://api.ipify.org?format=json" -ErrorAction Stop | ConvertFrom-Json).ip

# Update Duck DNS
$updateUrl = "https://www.duckdns.org/update?domains=$domain&token=$token&ip=$publicIP"
$response = Invoke-WebRequest -Uri $updateUrl -ErrorAction Stop

# Log the update
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path $logFile -Value "$timestamp - Updated $domain to $publicIP - Status: $($response.Content)"

Write-Host "Duck DNS updated: $domain = $publicIP"
```

**Schedule the script to run every 5 minutes:**

1. Open Task Scheduler
2. Create Basic Task → Name: "Update DuckDNS"
3. Trigger: At startup + Repeat every 5 minutes
4. Action: Start a program → `powershell.exe`
5. Arguments: `-ExecutionPolicy Bypass -File "C:\path\to\update-duckdns.ps1"`

### Step 3.4: Verify Dynamic DNS

```powershell
# Test your domain resolves to your public IP
nslookup theovensecret.duckdns.org

# Should show your current public IP
```

---

## Phase 4: Domain Configuration

### Step 4.1: Options for Your Domain

**Option A: Free Subdomain (Easy)**
- Use Duck DNS: `theovensecret.duckdns.org`
- **No cost**, automatic updates, fully functional
- Perfect for testing and low-traffic sites

**Option B: Custom Domain (Professional)**
- Register a domain (Namecheap, GoDaddy, etc.) - $10-15/year
- Point to Duck DNS or Cloudflare
- More professional appearance

### Step 4.2: Using Free Duck DNS Subdomain

Your domain is ready: `theovensecret.duckdns.org`

No additional configuration needed! Skip to Phase 5.

### Step 4.3: Using a Custom Domain (Optional)

If you prefer to use a domain you own:

1. **Register Domain**
   - Register at Namecheap, GoDaddy, or Google Domains (~$10-15/year)
   - Example: `theovensecret.com`

2. **Point Domain to Duck DNS**
   - In your domain registrar's DNS settings:
   ```
   CNAME: www → theovensecret.duckdns.org
   A: @ → [Your Duck DNS IP]
   ```
   - Or use Cloudflare as nameserver (slightly more complex but more reliable)

3. **Wait for DNS Propagation** (5-24 hours)

4. **Update Your Environment**

In `.env.production`:
```
NEXT_PUBLIC_API_URL=https://theovensecret.com/api
```

---

## Phase 5: Deploy with Docker

### Step 5.1: Create Production Startup Script

Create `start-production.ps1`:

```powershell
# Production startup script for The Ovens Secret

Set-Location C:\sazal\the-ovens-secret

Write-Host "🚀 Starting The Ovens Secret Production Server..."
Write-Host ""

# Load environment variables
Get-Content .env.production | ForEach-Object {
    if ($_ -notmatch "^#" -and $_ -notmatch "^$") {
        $name, $value = $_.Split('=')
        [Environment]::SetEnvironmentVariable($name, $value)
    }
}

# Clean up any stopped containers
Write-Host "📦 Cleaning up old containers..."
docker-compose -f docker-compose.prod.yml down

# Build and start the application
Write-Host "🔨 Building Docker image..."
docker-compose -f docker-compose.prod.yml build --no-cache

Write-Host "✅ Starting application..."
docker-compose -f docker-compose.prod.yml up -d

# Wait for services to be ready
Start-Sleep -Seconds 10

# Verify status
Write-Host ""
Write-Host "📊 Container Status:"
docker-compose -f docker-compose.prod.yml ps

Write-Host ""
Write-Host "✅ Server is running!"
Write-Host ""
Write-Host "🌐 Access your website at:"
Write-Host "   - http://localhost (local)"
Write-Host "   - https://theovensecret.duckdns.org (public - after Phase 6)"
```

### Step 5.2: Create Maintenance Scripts

**`view-logs.ps1`** - Check what's happening:

```powershell
Set-Location C:\sazal\the-ovens-secret

Write-Host "📋 Recent Logs (last 50 lines):"
docker-compose -f docker-compose.prod.yml logs --tail=50

Write-Host ""
Write-Host "⏰ Following logs (Ctrl+C to stop):"
docker-compose -f docker-compose.prod.yml logs -f
```

**`stop-server.ps1`** - Safely shut down:

```powershell
Set-Location C:\sazal\the-ovens-secret

Write-Host "🛑 Stopping The Ovens Secret..."
docker-compose -f docker-compose.prod.yml down

Write-Host ""
Write-Host "✅ Server stopped"
docker ps
```

**`restart-server.ps1`** - Restart after updates:

```powershell
Set-Location C:\sazal\the-ovens-secret

Write-Host "🔄 Restarting server..."
docker-compose -f docker-compose.prod.yml restart

Write-Host ""
Write-Host "✅ Server restarted"
docker ps
```

### Step 5.3: Initial Deployment

```powershell
# Run from C:\sazal\the-ovens-secret
.\start-production.ps1

# Wait for Docker to start (watch the logs)
.\view-logs.ps1

# Test locally
curl http://localhost
```

**Expected output:**
```
<!DOCTYPE html>
<html>
  <head>...
```

### Step 5.4: Make Scripts Autostart

**Windows Task Scheduler Setup:**

1. Press `Win + R` → type `taskschd.msc`
2. Click "Create Basic Task"
3. **Name**: "Start The Ovens Secret"
4. **Trigger**: "At startup"
5. **Action**: "Start a program"
   - Program: `powershell.exe`
   - Arguments: `-ExecutionPolicy Bypass -File "C:\sazal\the-ovens-secret\start-production.ps1"`
6. **Advanced**: Check "Run with highest privileges"

Now your website will automatically start when your laptop boots!

### Step 5.5: Verify Deployment

```powershell
# Check that containers are running
docker ps

# Should show:
# - the-ovens-secret-app
# - the-ovens-secret-nginx

# Check logs for any errors
docker-compose -f docker-compose.prod.yml logs

# Test HTTP access
curl http://localhost
curl http://192.168.1.100  # Your laptop's local IP
```

---

## Phase 6: HTTPS/SSL Setup

Secure your website with free HTTPS certificates using Let's Encrypt.

### Step 6.1: Install Certbot on Your Laptop

```powershell
# Install via Chocolatey (if installed)
choco install certbot

# Or download from: https://certbot.eff.org/
```

### Step 6.2: Generate SSL Certificate

```powershell
# Stop your Docker containers first
docker-compose -f docker-compose.prod.yml down

# Generate certificate
certbot certonly --standalone `
  -d theovensecret.duckdns.org `
  -d www.theovensecret.duckdns.org `
  --non-interactive `
  --agree-tos `
  -m your-email@example.com

# If using custom domain, add that too:
# certbot certonly --standalone -d theovensecret.com -d www.theovensecret.com
```

**Certificates will be saved to:**
```
C:\Certbot\live\theovensecret.duckdns.org\
├── privkey.pem
├── cert.pem
├── chain.pem
└── fullchain.pem
```

### Step 6.3: Update Docker Compose for HTTPS

Modify `docker-compose.prod.yml` volumes:

```yaml
nginx:
  image: nginx:alpine
  container_name: the-ovens-secret-nginx
  ports:
    - "80:80"
    - "443:443"
  volumes:
    - ./nginx.conf:/etc/nginx/nginx.conf:ro
    - C:\Certbot\live\theovensecret.duckdns.org:/etc/letsencrypt/live:ro
```

### Step 6.4: Update nginx.conf for HTTPS

Add to your `nginx.conf`:

```nginx
server {
    listen 443 ssl http2;
    server_name theovensecret.duckdns.org www.theovensecret.duckdns.org;

    # SSL Configuration
    ssl_certificate /etc/letsencrypt/live/theovensecret.duckdns.org/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/theovensecret.duckdns.org/privkey.pem;
    
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;

    location / {
        proxy_pass http://app;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}

# Redirect HTTP to HTTPS
server {
    listen 80;
    server_name _;
    return 301 https://$host$request_uri;
}
```

### Step 6.5: Certbot Renewal Script

Let's Encrypt certificates expire every 90 days. Create `renew-ssl.ps1`:

```powershell
# Certbot Renewal Script

Write-Host "🔄 Renewing SSL certificates..."

# Stop Docker containers
Set-Location C:\sazal\the-ovens-secret
docker-compose -f docker-compose.prod.yml down

# Renew certificates
certbot renew --standalone

# Restart Docker
docker-compose -f docker-compose.prod.yml up -d

Write-Host "✅ SSL Certificates renewed and services restarted"
```

**Schedule weekly renewal:**

1. Task Scheduler → Create Basic Task
2. **Name**: "Renew SSL Certificates"
3. **Trigger**: "Weekly" (every Sunday at 2 AM)
4. **Action**: Run `certbot renew --standalone`

### Step 6.6: Test HTTPS

```powershell
# Restart Docker
docker-compose -f docker-compose.prod.yml up -d

# Wait 10 seconds
Start-Sleep -Seconds 10

# Test HTTPS
curl https://theovensecret.duckdns.org -SkipCertificateCheck

# Test HTTP to HTTPS redirect
curl http://theovensecret.duckdns.org -SkipCertificateCheck
```

---

## Phase 7: Maintenance & Monitoring

### Step 7.1: Regular Health Checks

**Weekly:**
```powershell
# 1. Check if Docker containers are running
docker ps

# 2. Review logs for errors
docker-compose -f docker-compose.prod.yml logs --tail 100

# 3. Check disk space
Get-Volume
```

**Monthly:**
```powershell
# 1. Update Docker images
docker pull nginx:alpine
docker-compose -f docker-compose.prod.yml build --pull

# 2. Check SSL certificate expiration
certbot certificates

# 3. Clean up unused Docker images
docker image prune -a
```

### Step 7.2: Monitoring Script

Create `health-check.ps1`:

```powershell
$domain = "theovensecret.duckdns.org"
$statusFile = "C:\logs\health-status.txt"

# Ensure log directory exists
New-Item -ItemType Directory -Path "C:\logs" -Force | Out-Null

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Test website
try {
    $response = Invoke-WebRequest -Uri "https://$domain" -SkipCertificateCheck -ErrorAction Stop
    $status = "✅ OK - HTTP $($response.StatusCode)"
} catch {
    $status = "❌ FAILED - $($_.Exception.Message)"
}

# Check Docker containers
$containers = (docker ps --filter "name=the-ovens-secret" --format "{{.Names}}") -split "`n"
$containerStatus = if ($containers.Count -eq 2) { "✅ Both containers running" } else { "⚠️  Missing containers" }

# Log results
$result = "$timestamp | Site: $status | Docker: $containerStatus"
Write-Host $result
Add-Content -Path $statusFile -Value $result

# Email alert on failure
if ($status -like "❌*") {
    Write-Host "⚠️  Website is down! Check logs in C:\logs\health-status.txt"
}
```

**Schedule health checks every 30 minutes:**

Task Scheduler → Create Basic Task → Trigger: "Every 30 minutes"

### Step 7.3: Log Management

Create `cleanup-logs.ps1`:

```powershell
# Clean up old logs (keep 30 days)
$logPath = "C:\logs"
$daysToKeep = 30

Get-ChildItem -Path $logPath -Filter "*.txt" -File | 
  Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$daysToKeep) } | 
  Remove-Item -Force

Write-Host "✅ Cleaned up logs older than $daysToKeep days"
```

### Step 7.4: Website Updates

To deploy website updates:

```powershell
cd C:\sazal\the-ovens-secret

# 1. Pull latest code
git pull origin main

# 2. Rebuild and restart
docker-compose -f docker-compose.prod.yml down
docker-compose -f docker-compose.prod.yml build --no-cache
docker-compose -f docker-compose.prod.yml up -d

# 3. Verify
docker-compose -f docker-compose.prod.yml logs --tail 20
```

### Step 7.5: Backup Strategy

**Daily Backups:**

Create `backup-site.ps1`:

```powershell
$backupPath = "C:\backups\the-ovens-secret"
$sourcePath = "C:\sazal\the-ovens-secret"

# Create backup directory
New-Item -ItemType Directory -Path $backupPath -Force | Out-Null

# Backup important files
$date = Get-Date -Format "yyyy-MM-dd"
$zipFile = "$backupPath\backup-$date.zip"

Compress-Archive -Path `
    @("$sourcePath\app", "$sourcePath\.env.production", "$sourcePath\nginx.conf") `
    -DestinationPath $zipFile -Force

Write-Host "✅ Backup created: $zipFile"

# Keep only last 30 days of backups
Get-ChildItem -Path $backupPath -Filter "*.zip" | 
  Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) } | 
  Remove-Item -Force
```

---

## Troubleshooting

### Issue: Website Not Accessible from Internet

**Diagnosis:**
```powershell
# Check if ports are open
netstat -ano | findstr ":80"
netstat -ano | findstr ":443"

# Check Docker is running
docker ps

# Test port externally: https://canyouseeme.org (port 80)
```

**Solutions:**
1. ✅ Verify port forwarding in router (Phase 2)
2. ✅ Check Windows Firewall:
   ```powershell
   New-NetFirewallRule -DisplayName "Allow HTTP" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
   New-NetFirewallRule -DisplayName "Allow HTTPS" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow
   ```
3. ✅ Restart Docker: `docker-compose -f docker-compose.prod.yml restart`

### Issue: Domain Not Resolving

**Diagnosis:**
```powershell
nslookup theovensecret.duckdns.org

# Should show your public IP
```

**Solutions:**
1. ✅ Verify Duck DNS is updated: Visit duck DNS dashboard
2. ✅ Check DuckDNS script is running: `Get-ScheduledTask | Where-Object {$_.TaskName -like "*Duck*"}`
3. ✅ Wait 5-10 minutes for DNS propagation
4. ✅ Clear DNS cache: `ipconfig /flushdns`

### Issue: SSL Certificate Errors

**Diagnosis:**
```powershell
certbot certificates

# Should show your domain with "Valid" status
```

**Solutions:**
1. ✅ Regenerate certificate: `certbot certonly --force-renewal --standalone`
2. ✅ Ensure port 443 is accessible: `Test-NetConnection -ComputerName theovensecret.duckdns.org -Port 443`
3. ✅ Restart nginx after certificate renewal

### Issue: High Laptop CPU/Memory Usage

**Solutions:**
1. ✅ Limit Docker resources in `docker-compose.prod.yml` (already configured)
2. ✅ Increase available RAM
3. ✅ Disable unnecessary programs on laptop
4. ✅ Monitor with: `docker stats`

### Issue: Website Slow or Frequently Down

**Causes & Solutions:**
1. **Poor internet connection**
   - Upgrade ISP plan if possible
   - Use Ethernet instead of WiFi
   
2. **Laptop overheating**
   - Ensure good ventilation
   - Monitor temps: `wmic os get TotalVisibleMemorySize,FreePhysicalMemory`
   - Consider external cooling
   
3. **Power settings**
   - Verify "Never sleep" settings (Phase 1.5)
   - Check power plugged in
   
4. **Modem/Router issues**
   - Restart modem weekly
   - Restart router monthly

### Issue: Duck DNS Updates Not Working

**Diagnosis:**
```powershell
# Check script logs
Get-Content C:\logs\duckdns.log

# Test public IP detection
Invoke-WebRequest -Uri "https://api.ipify.org?format=json"
```

**Solutions:**
1. ✅ Verify token is correct in script
2. ✅ Check Task Scheduler task is enabled
3. ✅ Manually run script: `.\update-duckdns.ps1`
4. ✅ Firewall may be blocking: Add exception for powershell.exe

---

## Quick Reference Commands

```powershell
# START
.\start-production.ps1

# STOP
.\stop-server.ps1

# VIEW LOGS
.\view-logs.ps1

# RESTART
.\restart-server.ps1

# CHECK STATUS
docker ps
docker-compose -f docker-compose.prod.yml ps

# VIEW FULL LOGS
docker-compose -f docker-compose.prod.yml logs -f

# UPDATE WEBSITE CODE
git pull origin main
docker-compose -f docker-compose.prod.yml build --no-cache
docker-compose -f docker-compose.prod.yml up -d

# CHECK CERTIFICATE
certbot certificates

# RENEW CERTIFICATE
certbot renew --standalone
```

---

## Success Checklist ✅

After completing all phases, verify:

- [ ] Docker containers running: `docker ps` (shows 2 running containers)
- [ ] Local access works: `http://localhost` ✅
- [ ] Router port forwarding configured (ports 80 & 443)
- [ ] Local IP set to static in router
- [ ] Duck DNS configured and auto-updating
- [ ] Domain resolves to your IP: `nslookup theovensecret.duckdns.org`
- [ ] Public access works: `https://theovensecret.duckdns.org` ✅
- [ ] SSL certificate installed and valid
- [ ] Start script scheduled in Task Scheduler
- [ ] Health check script running
- [ ] Laptop set to never sleep
- [ ] Backup script scheduled

Once all items are checked, **your website is live!** 🎉

---

## Getting More Help

- **Docker Issues**: Check logs with `docker-compose logs -f`
- **Network Issues**: Use `tracert theovensecret.duckdns.org`
- **Certificate Issues**: Visit [Let's Encrypt Status](https://letsencrypt.org/docs/)
- **Port Forwarding Help**: Google "[Your Router Model] port forwarding guide"

---

## Performance Tips

1. **Optimize Content** - Use Next.js image optimization
2. **CDN Alternative** - Consider Cloudflare (free) for caching/DDoS protection
3. **Monitor Bandwidth** - Set data limits in router to prevent overage
4. **Upgrade Internet** - 100+ Mbps recommended for stable self-hosting
5. **Use UPS** - Consider an uninterruptible power supply for your laptop

---

## Legal Considerations

- Verify internet plan allows hosting (some ISPs prohibit it)
- Check home zoning laws (if you're running a business)
- Optionally register business liability insurance
- Implement privacy policy and terms of service
- Comply with GDPR if you have EU visitors

Your self-hosted website is now live! 🚀
