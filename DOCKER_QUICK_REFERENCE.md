# Docker & Deployment Quick Reference

## Overview

Your Next.js application is now fully Dockerized and ready for deployment on any machine. This file contains a quick reference for all Docker-related files and configurations.

## 📦 New Files Created

### Docker Configuration
- **`Dockerfile`** - Multi-stage Docker build configuration
  - Optimized production image (~200MB)
  - Alpine Linux base image
  - Non-root user execution
  - Health checks included

- **`.dockerignore`** - Excludes unnecessary files from build context
  - Reduces build time and image size
  - Similar to .gitignore

### Docker Compose Files
- **`docker-compose.yml`** - Development environment
  - Single container setup
  - Port 3000 exposed
  - Volume mounting for live reload
  - Use with: `docker-compose up`

- **`docker-compose.prod.yml`** - Production environment
  - Includes Nginx reverse proxy
  - Container resource limits
  - Health checks configured
  - Use with: `docker-compose -f docker-compose.prod.yml up -d`

### Nginx Configuration
- **`nginx.conf`** - Reverse proxy configuration
  - Gzip compression enabled
  - Security headers configured
  - Rate limiting
  - Static asset caching
  - SSL/TLS ready (commented out)

### Deployment Scripts
- **`deploy.sh`** - Bash script for Unix-like systems (Linux, macOS)
  - Build, run, stop, view logs, push to Docker Hub
  - Usage: `./deploy.sh [build|dev|prod|run|stop|logs|push|clean|help]`

- **`deploy.ps1`** - PowerShell script for Windows
  - Same functionality as bash script
  - Usage: `.\deploy.ps1 [build|dev|prod|run|stop|logs|push|clean|help]`

### Documentation
- **`DEPLOYMENT.md`** - Comprehensive deployment guide
  - Cloud platform instructions
  - Configuration options
  - Troubleshooting guide
  - Production best practices

- **`README.md`** - Updated with Docker information
  - Quick start guide
  - Docker commands
  - Project structure
  - Security features

### CI/CD
- **`.github/workflows/docker-build.yml`** - GitHub Actions workflow
  - Automatic Docker image building
  - Push to GitHub Container Registry
  - Runs on push to main/develop
  - Pull request testing

## 🚀 Quick Start Commands

### Windows (PowerShell)
```powershell
# Development
.\deploy.ps1 dev

# Production with Nginx
.\deploy.ps1 prod

# View logs
.\deploy.ps1 logs

# Clean up
.\deploy.ps1 clean
```

### Linux/macOS (Bash)
```bash
# Make script executable
chmod +x deploy.sh

# Development
./deploy.sh dev

# Production with Nginx
./deploy.sh prod

# View logs
./deploy.sh logs

# Clean up
./deploy.sh clean
```

### Docker Compose (All Platforms)
```bash
# Development
docker-compose up --build

# Production
docker-compose -f docker-compose.prod.yml up --build -d

# Stop
docker-compose down

# Logs
docker-compose logs -f
```

### Docker CLI (All Platforms)
```bash
# Build image
docker build -t the-ovens-secret:latest .

# Run container
docker run -p 3000:3000 the-ovens-secret:latest

# Run with environment variables
docker run -p 3000:3000 \
  -e NODE_ENV=production \
  -e NEXT_PUBLIC_APP_NAME="My Bakery" \
  the-ovens-secret:latest
```

## 📊 File Structure

```
the-ovens-secret/
├── Dockerfile                    ← Docker build config
├── .dockerignore                ← Exclude files from Docker
├── docker-compose.yml           ← Dev environment
├── docker-compose.prod.yml      ← Prod with Nginx
├── nginx.conf                   ← Nginx configuration
├── deploy.sh                    ← Bash deployment script
├── deploy.ps1                   ← PowerShell deployment script
├── DEPLOYMENT.md                ← Detailed guide
├── .github/
│   └── workflows/
│       └── docker-build.yml     ← GitHub Actions CI/CD
├── app/
│   ├── page.tsx
│   ├── layout.tsx
│   ├── components/
│   ├── recipes/
│   ├── about/
│   └── contact/
├── public/
├── next.config.ts               ← Updated with output: "standalone"
├── package.json
├── tsconfig.json
└── README.md                    ← Updated with Docker info
```

## 🔧 Configuration Details

### Environment Variables

Production environment variables (set in docker-compose files):
```yaml
NODE_ENV: production
NEXT_PUBLIC_APP_NAME: The Ovens Secret
NEXT_PUBLIC_APP_DESCRIPTION: Discover the hidden wonders of artisan baking
NEXT_PUBLIC_API_URL: http://localhost:3000/api
```

### Image Size Optimization

- **Base Image**: Alpine Linux (5MB)
- **Multi-stage Build**: Removes dev dependencies
- **Standalone Output**: Minimal Next.js bundle
- **Final Size**: ~200MB (very efficient)

### Security Features

✅ Non-root user execution
✅ Security headers in Nginx
✅ Health checks enabled
✅ Resource limits configured
✅ Alpine Linux (minimal attack surface)

### Performance Features

✅ Gzip compression
✅ Static asset caching
✅ Rate limiting on API endpoints
✅ Connection keep-alive
✅ Browser caching headers

## 🌐 Deployment Targets

All these platforms support Docker:
- AWS EC2, ECS, App Runner
- DigitalOcean App Platform
- Google Cloud Run, GKE
- Azure Container Instances, App Service
- Heroku (with container registry)
- Self-hosted servers
- Kubernetes clusters
- Docker Swarm

See `DEPLOYMENT.md` for platform-specific instructions.

## 📝 Before Deploying

1. ✅ Test locally with `docker-compose up`
2. ✅ Update environment variables if needed in docker-compose files
3. ✅ Configure SSL/TLS in nginx.conf for HTTPS
4. ✅ Set Docker Hub credentials if pushing to registry
5. ✅ Configure firewall rules for your chosen platform

## 🐳 Docker Hub Deployment

Push your image to Docker Hub for easy deployment:

**With Script:**
```powershell
# Windows
.\deploy.ps1 push -Registry yourusername

# Linux/macOS
./deploy.sh push yourusername
```

**Manual:**
```bash
docker tag the-ovens-secret:latest yourusername/the-ovens-secret:latest
docker push yourusername/the-ovens-secret:latest
```

**Use anywhere:**
```bash
docker run -p 3000:3000 yourusername/the-ovens-secret:latest
```

## 🆘 Troubleshooting

### Docker not installed
Download Docker Desktop: https://www.docker.com/products/docker-desktop

### Port 3000 in use
```bash
# Change port in docker-compose.yml
ports:
  - "8000:3000"  # External port 8000 → Container port 3000
```

### Out of disk space
```bash
# Clean up unused Docker resources
docker system prune -a --volumes
```

### Container exits immediately
```bash
# Check logs
docker logs container-name

# Run with interactive terminal
docker run -it the-ovens-secret:latest
```

## 📚 Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Next.js Deployment](https://nextjs.org/docs/deployment)
- [Nginx Documentation](https://nginx.org/en/docs/)

---

**Status**: ✅ Ready for deployment
**Last Updated**: February 21, 2026
