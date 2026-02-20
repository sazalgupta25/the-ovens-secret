# The Ovens Secret

A modern Next.js web application for artisan baking enthusiasts. Discover recipes, techniques, and tips for perfect bread-making.

## Features

- 🍞 **Artisan Recipes** - Collection of authentic baking recipes
- 📚 **Knowledge Base** - Learn baking science and techniques
- 👨‍🍳 **Expert Tips** - Professional insights and troubleshooting
- 🔥 **Oven Mastery** - Temperature and timing guides
- 📱 **Responsive Design** - Works on all devices
- 🚀 **Docker Ready** - Easy deployment anywhere

## Tech Stack

- **Framework**: [Next.js 16](https://nextjs.org) with App Router
- **Styling**: [Tailwind CSS](https://tailwindcss.com)
- **Language**: [TypeScript](https://www.typescriptlang.org)
- **Runtime**: Node.js 22+
- **Containerization**: Docker & Docker Compose

## Quick Start

### Local Development

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd the-ovens-secret
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Run the development server:**
   ```bash
   npm run dev
   ```

4. **Open your browser:**
   Navigate to [http://localhost:3000](http://localhost:3000)

### Docker Deployment

#### Option 1: Docker Compose (Recommended)

```bash
docker-compose up --build
```

Access at http://localhost:3000

#### Option 2: PowerShell Script (Windows)

```powershell
.\deploy.ps1 dev
```

#### Option 3: Bash Script (Linux/Mac)

```bash
chmod +x deploy.sh
./deploy.sh dev
```

#### Option 4: Docker CLI

```bash
docker build -t the-ovens-secret:latest .
docker run -p 3000:3000 the-ovens-secret:latest
```

## Available Scripts

### Development
```bash
npm run dev        # Start development server
npm run build      # Build for production
npm run start      # Start production server
npm run lint       # Run ESLint
```

### Docker Commands
```bash
docker-compose up --build      # Start with Docker Compose
docker-compose down            # Stop containers
docker logs -f <container-id>  # View logs
```

## Project Structure

```
.
├── app/                    # Next.js app directory
│   ├── components/        # React components
│   ├── recipes/           # Recipes page
│   ├── about/            # About page
│   ├── contact/          # Contact page
│   ├── layout.tsx        # Root layout
│   └── page.tsx          # Home page
├── public/               # Static assets
├── Dockerfile            # Docker build configuration
├── docker-compose.yml    # Docker Compose for development
├── docker-compose.prod.yml # Production Compose with Nginx
├── nginx.conf           # Nginx configuration
├── deploy.sh            # Bash deployment script
├── deploy.ps1           # PowerShell deployment script
└── DEPLOYMENT.md        # Detailed deployment guide
```

## Environment Variables

Create a `.env.local` file:

```env
NEXT_PUBLIC_APP_NAME=The Ovens Secret
NEXT_PUBLIC_APP_DESCRIPTION=Discover the hidden wonders of artisan baking
NEXT_PUBLIC_API_URL=http://localhost:3000/api
```

## Deployment

### Cloud Platforms

- **AWS EC2** - See [DEPLOYMENT.md](DEPLOYMENT.md#aws-ec2)
- **DigitalOcean** - See [DEPLOYMENT.md](DEPLOYMENT.md#digitalocean-app-platform)
- **Google Cloud Run** - See [DEPLOYMENT.md](DEPLOYMENT.md#google-cloud-run)
- **Heroku** - See [DEPLOYMENT.md](DEPLOYMENT.md#heroku)

### Production Setup

For production deployment with Nginx:

```bash
docker-compose -f docker-compose.prod.yml up -d
```

This includes:
- Nginx reverse proxy
- SSL/TLS support (configurable)
- Static asset caching
- Gzip compression
- Rate limiting

See [DEPLOYMENT.md](DEPLOYMENT.md) for comprehensive deployment instructions.

## Docker Images

### Building Custom Image

```bash
docker build -t your-registry/the-ovens-secret:latest .
```

### Pushing to Docker Hub

```bash
docker tag the-ovens-secret:latest username/the-ovens-secret:latest
docker push username/the-ovens-secret:latest
```

Or use the deployment script:

**PowerShell:**
```powershell
.\deploy.ps1 push -Registry username
```

**Bash:**
```bash
./deploy.sh push username
```

## Performance Features

- ✅ **Alpine Linux** - Minimal base image (72MB)
- ✅ **Multi-stage Build** - Optimized final image size
- ✅ **Non-root User** - Enhanced security
- ✅ **Health Checks** - Automatic container monitoring
- ✅ **Standalone Output** - Optimized Next.js bundling
- ✅ **Compression** - Gzip enabled for assets
- ✅ **Caching** - Browser and server-side caching

## Configuration

### Docker Resources

Modify `docker-compose.prod.yml`:

```yaml
deploy:
  resources:
    limits:
      cpus: '1'
      memory: 512M
```

### Nginx Settings

Edit `nginx.conf` for:
- SSL/TLS certificates
- Custom domains
- Rate limiting
- Cache policies

## Learning Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Tailwind CSS](https://tailwindcss.com/docs)
- [Artisan Baking Guide](https://breadtopia.com)

## Troubleshooting

### Port Already in Use

```bash
# Find process on port 3000
lsof -i :3000
# Kill it
kill -9 <PID>
```

### Docker Build Fails

```bash
# Clear Docker cache
docker system prune -a
# Rebuild
docker build -t the-ovens-secret:latest .
```

### Container Won't Start

```bash
# Check logs
docker logs the-ovens-secret
# Inspect image
docker inspect the-ovens-secret:latest
```

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is open source and available under the MIT License.

## Support

For issues, questions, or suggestions:
- Check [DEPLOYMENT.md](DEPLOYMENT.md) for deployment help
- Review Docker logs: `docker logs -f the-ovens-secret`
- Open an issue on GitHub

## Security

- Non-root container execution
- Security headers configured
- Minimal base image (Alpine Linux)
- Regular dependency updates
- Health checks enabled

---

Made with ❤️ for artisan baking enthusiasts.
