# Docker Deployment Guide - The Ovens Secret

This guide explains how to deploy The Ovens Secret application using Docker for public usage.

## Prerequisites

- Docker installed on your machine ([Download Docker](https://www.docker.com/get-started))
- Docker Compose (included with Docker Desktop)

## Quick Start

### Option 1: Using Docker Compose (Recommended)

1. **Clone or navigate to the project directory:**
   ```bash
   cd the-ovens-secret
   ```

2. **Build and run the application:**
   ```bash
   docker-compose up --build
   ```

3. **Access the application:**
   - Open your browser and navigate to `http://localhost:3000`
   - The application will be available at port 3000

4. **Stop the application:**
   ```bash
   docker-compose down
   ```

### Option 2: Using Docker CLI

1. **Build the Docker image:**
   ```bash
   docker build -t the-ovens-secret:latest .
   ```

2. **Run the container:**
   ```bash
   docker run -d \
     --name the-ovens-secret \
     -p 3000:3000 \
     -e NODE_ENV=production \
     the-ovens-secret:latest
   ```

3. **Check if the container is running:**
   ```bash
   docker ps
   ```

4. **View logs:**
   ```bash
   docker logs the-ovens-secret
   ```

5. **Stop the container:**
   ```bash
   docker stop the-ovens-secret
   docker rm the-ovens-secret
   ```

## Configuration

### Environment Variables

You can customize the application by setting environment variables:

- `NODE_ENV`: Set to `production` for optimal performance
- `NEXT_PUBLIC_APP_NAME`: Application name (default: "The Ovens Secret")
- `NEXT_PUBLIC_APP_DESCRIPTION`: Application description
- `NEXT_PUBLIC_API_URL`: API endpoint URL

### Custom Port

To run on a different port (e.g., 8000):

**Docker CLI:**
```bash
docker run -d -p 8000:3000 the-ovens-secret:latest
```

**Docker Compose:**
Modify the `ports` section in `docker-compose.yml`:
```yaml
ports:
  - "8000:3000"
```

## Deployment to Cloud Platforms

### AWS EC2

1. SSH into your EC2 instance
2. Install Docker:
   ```bash
   sudo yum update -y
   sudo yum install docker -y
   sudo systemctl start docker
   ```
3. Clone the repository and run Docker Compose
4. Configure security groups to allow port 3000 (or your custom port)

### DigitalOcean App Platform

1. Push your code to GitHub
2. Create a new App in DigitalOcean App Platform
3. Connect your GitHub repository
4. Set the Dockerfile as the build configuration
5. Deploy

### Google Cloud Run

1. Authenticate with Google Cloud:
   ```bash
   gcloud auth login
   ```

2. Build and push the image:
   ```bash
   docker build -t gcr.io/YOUR_PROJECT_ID/the-ovens-secret .
   docker push gcr.io/YOUR_PROJECT_ID/the-ovens-secret
   ```

3. Deploy to Cloud Run:
   ```bash
   gcloud run deploy the-ovens-secret \
     --image gcr.io/YOUR_PROJECT_ID/the-ovens-secret \
     --platform managed \
     --region us-central1 \
     --port 3000
   ```

### Heroku

1. Create a `heroku.yml` file (optional, uses Dockerfile by default)
2. Create a Heroku app:
   ```bash
   heroku create your-app-name
   ```

3. Deploy:
   ```bash
   git push heroku main
   ```

## Monitoring & Health Checks

The Docker image includes a built-in health check that runs every 30 seconds. You can view the status:

```bash
docker ps
```

Look for the `(healthy)` status next to the running container.

## Production Best Practices

1. **Use a reverse proxy**: Deploy with Nginx or Let's Encrypt for HTTPS
2. **Enable logging**: Configure Docker logging drivers
3. **Resource limits**: Set memory and CPU limits:
   ```yaml
   mem_limit: 512m
   cpus: 0.5
   ```

4. **Backup volumes**: If using persistent storage

## Troubleshooting

### Container won't start
```bash
docker logs the-ovens-secret
```

### Port already in use
```bash
# Find process using port 3000
sudo lsof -i :3000
# Kill the process
sudo kill -9 <PID>
```

### High memory usage
Check if Node processes are running correctly:
```bash
docker top the-ovens-secret
```

## Performance Tips

1. Use Alpine Linux-based images (✓ already implemented)
2. Multi-stage builds for smaller image size (✓ already implemented)
3. Run as non-root user (✓ already implemented)
4. Use health checks (✓ already implemented)

## Support

For issues or questions, please check the application logs or contact the development team.
