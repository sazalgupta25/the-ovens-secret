# The Ovens Secret - Docker Deployment Script (Windows PowerShell)
# This script helps you build and deploy the application using Docker

param(
    [Parameter(Position = 0)]
    [ValidateSet("build", "dev", "prod", "run", "stop", "logs", "push", "clean", "help")]
    [string]$Command = "help",
    
    [Parameter(Position = 1)]
    [string]$Registry
)

# Functions
function Print-Header {
    param([string]$Message)
    Write-Host "========================================" -ForegroundColor Green
    Write-Host $Message -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
}

function Print-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Print-Error {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Print-Info {
    param([string]$Message)
    Write-Host "ℹ $Message" -ForegroundColor Yellow
}

# Check if Docker is installed
function Check-Docker {
    try {
        $null = docker --version
        Print-Success "Docker is installed"
        return $true
    }
    catch {
        Print-Error "Docker is not installed. Please install Docker Desktop first."
        return $false
    }
}

# Check if Docker Compose is installed
function Check-DockerCompose {
    try {
        $null = docker-compose --version
        Print-Success "Docker Compose is installed"
        return $true
    }
    catch {
        Print-Error "Docker Compose is not installed."
        return $false
    }
}

# Build the Docker image
function Build-Image {
    Print-Header "Building Docker Image"
    docker build -t the-ovens-secret:latest .
    Print-Success "Docker image built successfully"
}

# Run with Docker Compose (development)
function Run-Dev {
    Print-Header "Starting Application (Development)"
    docker-compose up --build
}

# Run with Docker Compose (production)
function Run-Prod {
    Print-Header "Starting Application (Production with Nginx)"
    docker-compose -f docker-compose.prod.yml up --build -d
    Print-Success "Application started in production mode"
    Print-Info "Application will be available at http://localhost"
}

# Run with Docker CLI
function Run-DockerCli {
    Print-Header "Starting Application (Docker CLI)"
    docker run -d `
        --name the-ovens-secret `
        -p 3000:3000 `
        -e NODE_ENV=production `
        the-ovens-secret:latest
    Print-Success "Container started successfully"
    Print-Info "Application available at http://localhost:3000"
}

# Stop containers
function Stop-Container {
    Print-Header "Stopping Application"
    docker-compose down
    Print-Success "Application stopped"
}

# View logs
function View-Logs {
    Print-Header "Application Logs"
    docker logs -f the-ovens-secret
}

# Push to Docker Hub
function Push-Image {
    param([string]$Username)
    
    if ([string]::IsNullOrEmpty($Username)) {
        Print-Error "Please provide Docker Hub username"
        Write-Host "Usage: .\deploy.ps1 push -Registry <username>"
        exit 1
    }
    
    Print-Header "Pushing to Docker Hub"
    docker tag the-ovens-secret:latest "$Username/the-ovens-secret:latest"
    docker push "$Username/the-ovens-secret:latest"
    Print-Success "Image pushed to $Username/the-ovens-secret:latest"
}

# Clean up
function Cleanup {
    Print-Header "Cleaning Up"
    docker-compose down -v
    docker rmi the-ovens-secret:latest
    Print-Success "Cleanup completed"
}

# Show usage
function Show-Usage {
    Write-Host "The Ovens Secret - Docker Deployment Script" -ForegroundColor Green
    Write-Host ""
    Write-Host "Usage: .\deploy.ps1 [command] [-Registry username]"
    Write-Host ""
    Write-Host "Commands:"
    Write-Host "  build              Build the Docker image"
    Write-Host "  dev                Start with Docker Compose (development mode)"
    Write-Host "  prod               Start with Docker Compose (production mode with Nginx)"
    Write-Host "  run                Start with Docker CLI"
    Write-Host "  stop               Stop the application"
    Write-Host "  logs               View application logs"
    Write-Host "  push               Push image to Docker Hub (requires -Registry parameter)"
    Write-Host "  clean              Clean up Docker images and containers"
    Write-Host "  help               Show this help message"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\deploy.ps1 build"
    Write-Host "  .\deploy.ps1 dev"
    Write-Host "  .\deploy.ps1 prod"
    Write-Host "  .\deploy.ps1 push -Registry myusername"
}

# Main execution
switch ($Command) {
    "build" {
        if (Check-Docker) {
            Build-Image
        }
    }
    "dev" {
        if ((Check-Docker) -and (Check-DockerCompose)) {
            Build-Image
            Run-Dev
        }
    }
    "prod" {
        if ((Check-Docker) -and (Check-DockerCompose)) {
            Build-Image
            Run-Prod
        }
    }
    "run" {
        if (Check-Docker) {
            Build-Image
            Run-DockerCli
        }
    }
    "stop" {
        if (Check-Docker) {
            Stop-Container
        }
    }
    "logs" {
        if (Check-Docker) {
            View-Logs
        }
    }
    "push" {
        if (Check-Docker) {
            Push-Image -Username $Registry
        }
    }
    "clean" {
        if (Check-Docker) {
            Cleanup
        }
    }
    "help" {
        Show-Usage
    }
    default {
        Print-Error "Unknown command: $Command"
        Show-Usage
        exit 1
    }
}
