# Self-Hosting Setup Checklist

Use this checklist to track your progress through setting up your website on your local laptop.

## Phase 1: Prepare Your Local Environment ✓
- [ ] Docker Desktop installed and running
  - Open PowerShell: `docker --version`
  - Should show: Docker version 25.x or higher
- [ ] Test Docker build locally
  - Run: `docker build -t the-ovens-secret:latest .`
  - Run: `docker-compose -f docker-compose.prod.yml up`
  - Test: Visit `http://localhost` in browser
  - Stop: Press Ctrl+C
- [ ] Laptop power settings configured
  - Settings → Power: Screen timeout = Never, Sleep = Never
  - Check "Keep awake" is working

## Phase 2: Router Configuration (⏱️ ~15 minutes)
- [ ] Find your router's IP address
  - PowerShell: `ipconfig` → Look for "Default Gateway"
  - Usually: `192.168.1.1` or `192.168.0.1`
- [ ] Save your laptop's local IP
  - PowerShell: `ipconfig` → Look for "IPv4 Address" (not gateway)
  - Example: `192.168.1.100`
- [ ] Access router admin panel
  - Browser: `http://192.168.1.1` (use your gateway IP)
  - Log in (default: admin/admin or check router documentation)
- [ ] Set up port forwarding
  - Port 80 → Your laptop IP:80
  - Port 443 → Your laptop IP:443
- [ ] Verify port forwarding (using online tool)
  - Visit: https://canyouseeme.org
  - Enter port: 80
  - Should show "open" (or at least after Phase 5)
- [ ] Set static DHCP reservation
  - Router → DHCP settings → Reservation
  - Reserve your laptop's IP address

## Phase 3: Dynamic DNS Setup (⏱️ ~10 minutes)
- [ ] Create Duck DNS account
  - Visit: https://www.duckdns.org
  - Log in (GitHub/Google)
  - Add domain: `theovensecret`
  - Copy your token
- [ ] Option A: Install DuckDNS Windows Update Client
  - Download: https://www.duckdns.org/install.jsp?tab=windows
  - Install and configure with domain + token
  - Verify it's running
- [ ] Option B: Schedule PowerShell update script
  - Edit: `update-duckdns.ps1`
  - Set token and domain in the script
  - Schedule in Task Scheduler to run every 5 minutes
- [ ] Test DNS resolution
  - PowerShell: `nslookup theovensecret.duckdns.org`
  - Should show your public IP
  - Wait 5-10 minutes if it shows old IP

## Phase 4: Domain Configuration
- [ ] Choose domain option
  - [ ] Free: Use `theovensecret.duckdns.org` (recommended to start)
  - [ ] Paid: Register custom domain at Namecheap/GoDaddy/etc
- [ ] If using free Duck DNS domain
  - Your domain is ready to use: `theovensecret.duckdns.org`
  - Skip to Phase 5
- [ ] If using custom domain
  - [ ] Update DNS settings to point to Duck DNS
  - [ ] Wait for DNS propagation (up to 24 hours)
  - [ ] Test: `nslookup yourdomain.com`

## Phase 5: Deploy with Docker (⏱️ ~20 minutes)
- [ ] Test local deployment
  - PowerShell: `.\start-production.ps1`
  - Check logs: `.\view-logs.ps1`
  - Test: `curl http://localhost`
  - Stop: `.\stop-server.ps1`
- [ ] Configure autostart (so website runs on laptop boot)
  - Task Scheduler → New Basic Task
  - Name: "Start The Ovens Secret"
  - Trigger: "At startup"
  - Action: PowerShell → Scan: `-ExecutionPolicy Bypass -File "C:\sazal\the-ovens-secret\start-production.ps1"`
  - Check "Run with highest privileges"
- [ ] Start production deployment
  - PowerShell: `.\start-production.ps1`
  - Wait for containers to be healthy
- [ ] Test local access
  - Browser: `http://localhost` (should work)
  - PowerShell: `curl http://192.168.1.100` (use your laptop IP)
- [ ] Verify containers are running
  - PowerShell: `docker ps`
  - Should show: `the-ovens-secret-app` and `the-ovens-secret-nginx`

## Phase 5B: Test Public Access (Before HTTPS)
- [ ] Test public HTTP access
  - Browser: `http://theovensecret.duckdns.org`
  - (Ignore certificate warning for now, we'll fix it in Phase 6)
- [ ] If fails, check:
  - [ ] Port forwarding in router
  - [ ] `docker ps` shows containers running
  - [ ] `nslookup theovensecret.duckdns.org` returns your IP
  - [ ] Windows Firewall not blocking ports 80/443

## Phase 6: HTTPS/SSL Setup (⏱️ ~30 minutes)
- [ ] Install Certbot
  - Choco: `choco install certbot`
  - Or download: https://certbot.eff.org/
- [ ] Stop Docker containers
  - PowerShell: `.\stop-server.ps1`
  - Wait a few seconds
- [ ] Generate SSL certificate
  - PowerShell:
  ```
  certbot certonly --standalone `
    -d theovensecret.duckdns.org `
    -d www.theovensecret.duckdns.org `
    --non-interactive `
    --agree-tos `
    -m your-email@example.com
  ```
  - Check output: Should show "Successfully received certificate"
- [ ] Certificates installed at: `C:\Certbot\live\theovensecret.duckdns.org\`
- [ ] Update `docker-compose.prod.yml` volume path for certificates
- [ ] Update `nginx.conf` with SSL configuration
  - Use the `nginx.conf` configuration from the guide
- [ ] Schedule SSL renewal (weekly)
  - Task Scheduler → New Basic Task
  - Name: "Renew SSL Certificates"
  - Trigger: Weekly (Sunday 2 AM)
  - Action: PowerShell → `.\renew-ssl.ps1`
- [ ] Test HTTPS
  - PowerShell: `.\start-production.ps1`
  - Wait 10 seconds
  - Browser: `https://theovensecret.duckdns.org`
  - Should have valid certificate (green lock icon)

## Phase 7: Maintenance & Monitoring (Ongoing)
- [ ] Set up health check monitoring
  - Schedule PowerShell: `.\health-check.ps1`
  - Frequency: Every 30 minutes (Task Scheduler)
- [ ] Set up backups
  - Schedule PowerShell: `.\backup-site.ps1`
  - Frequency: Daily at 2 AM (Task Scheduler)
- [ ] Set up log rotation
  - Automatic with health check script
- [ ] Update website code
  - `git pull origin main`
  - `docker-compose -f docker-compose.prod.yml build --no-cache`
  - `docker-compose -f docker-compose.prod.yml up -d`
- [ ] Schedule weekly certificate renewal check
  - Task Scheduler: Run `certbot certificates` command
  - Should show days remaining (90 days from generation)
- [ ] Laptop maintenance
  - Restart modem weekly
  - Check disk space monthly
  - Verify laptop is not sleeping

## Final Verification ✅

Your website is ready when all of these work:

- [ ] `docker ps` shows both containers running
- [ ] `http://localhost` loads the website
- [ ] Browser can access `https://theovensecret.duckdns.org`
- [ ] HTTPS shows green lock (valid certificate)
- [ ] `certbot certificates` shows valid certificate
- [ ] `nslookup theovensecret.duckdns.org` returns your IP
- [ ] Port check shows ports 80 and 443 open (https://canyouseeme.org)
- [ ] Laptop set to never sleep (Windows settings)
- [ ] Start script scheduled in Task Scheduler

## Quick Command Reference

```powershell
# START Server
.\start-production.ps1

# STOP Server
.\stop-server.ps1

# RESTART Server
.\restart-server.ps1

# VIEW LOGS
.\view-logs.ps1
.\view-logs.ps1 -Follow        # Live logs

# CHECK STATUS
docker ps
docker-compose -f docker-compose.prod.yml ps

# UPDATE DUCKDNS MANUALLY
.\update-duckdns.ps1

# HEALTH CHECK
.\health-check.ps1

# BACKUP
.\backup-site.ps1

# RENEW CERTIFICATE
.\renew-ssl.ps1

# UPDATE WEBSITE
git pull origin main
docker-compose -f docker-compose.prod.yml build --no-cache
docker-compose -f docker-compose.prod.yml up -d

# CHECK CERTIFICATE STATUS
certbot certificates
```

## Important Notes

⚠️ **Keep Your Laptop On**
- Your website requires your laptop to be powered on 24/7
- Set it to high performance mode
- Ensure stable internet connection
- Consider UPS for power backup

⚠️ **Monitor Resources**
- Check CPU/Memory usage: `docker stats`
- 1-2GB memory typical for website
- 0.5-1 CPU typical for light traffic

⚠️ **ISP Considerations**
- Some ISPs don't allow hosting from residential connections
- Check your internet plan's terms
- Upload speed matters (minimum 10 Mbps recommended)

⚠️ **Power Settings**
- Every restart: Network may take 30 seconds to activate
- Browser cached DNS may need clearing: `ipconfig /flushdns`

## Troubleshooting Tips

**Website not accessible from internet?**
1. Check port forwarding in router
2. Verify containers running: `docker ps`
3. Check Windows Firewall allows ports 80 & 443
4. Verify DNS resolves: `nslookup theovensecret.duckdns.org`

**Domain not resolving?**
1. Wait 5-10 minutes for DNS update
2. Clear DNS cache: `ipconfig /flushdns`
3. Check Duck DNS dashboard shows your IP
4. Verify update script is running or Duck DNS client is active

**Certificate errors?**
1. Verify certificate exists: `certbot certificates`
2. Check nginx.conf has correct paths
3. Ensure ports 80 and 443 forwarded in router
4. Regenerate: `certbot certonly --force-renewal --standalone`

**Laptop performance issues?**
1. Monitor resources: `docker stats`
2. Check disk space: `Get-Volume`
3. Restart Docker: `.\restart-server.ps1`
4. Check for malware/excessive background processes

---

**You're all set! Your website is now live on the internet without any hosting fees!** 🎉

For detailed information, see: [SELF_HOSTING_GUIDE.md](SELF_HOSTING_GUIDE.md)
