#!/bin/bash

# The Ovens Secret - Docker Deployment Script
# This script helps you build and deploy the application using Docker

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}$1${NC}"
    echo -e "${GREEN}========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Check if Docker is installed
check_docker() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    print_success "Docker is installed"
}

check_docker_compose() {
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    print_success "Docker Compose is installed"
}

# Build the Docker image
build_image() {
    print_header "Building Docker Image"
    docker build -t the-ovens-secret:latest .
    print_success "Docker image built successfully"
}

# Run with Docker Compose (development)
run_dev() {
    print_header "Starting Application (Development)"
    docker-compose up --build
}

# Run with Docker Compose (production)
run_prod() {
    print_header "Starting Application (Production with Nginx)"
    docker-compose -f docker-compose.prod.yml up --build -d
    print_success "Application started in production mode"
    print_info "Application will be available at http://localhost"
}

# Run with Docker CLI (production)
run_docker_cli() {
    print_header "Starting Application (Docker CLI)"
    docker run -d \
        --name the-ovens-secret \
        -p 3000:3000 \
        -e NODE_ENV=production \
        the-ovens-secret:latest
    print_success "Container started successfully"
    print_info "Application available at http://localhost:3000"
}

# Stop and remove containers
stop() {
    print_header "Stopping Application"
    docker-compose down
    print_success "Application stopped"
}

# View logs
view_logs() {
    print_header "Application Logs"
    docker logs -f the-ovens-secret
}

# Push to Docker Hub
push_image() {
    local registry=$1
    if [ -z "$registry" ]; then
        print_error "Please provide Docker Hub username"
        echo "Usage: ./deploy.sh push <username>"
        exit 1
    fi
    
    print_header "Pushing to Docker Hub"
    docker tag the-ovens-secret:latest $registry/the-ovens-secret:latest
    docker push $registry/the-ovens-secret:latest
    print_success "Image pushed to $registry/the-ovens-secret:latest"
}

# Clean up
cleanup() {
    print_header "Cleaning Up"
    docker-compose down -v
    docker rmi the-ovens-secret:latest
    print_success "Cleanup completed"
}

# Show usage
show_usage() {
    echo "The Ovens Secret - Docker Deployment Script"
    echo ""
    echo "Usage: ./deploy.sh [command]"
    echo ""
    echo "Commands:"
    echo "  build              Build the Docker image"
    echo "  dev                Start with Docker Compose (development mode)"
    echo "  prod               Start with Docker Compose (production mode with Nginx)"
    echo "  run                Start with Docker CLI"
    echo "  stop               Stop the application"
    echo "  logs               View application logs"
    echo "  push <username>    Push image to Docker Hub"
    echo "  clean              Clean up Docker images and containers"
    echo "  help               Show this help message"
    echo ""
}

# Main script
main() {
    local command=${1:-"help"}

    case $command in
        build)
            check_docker
            build_image
            ;;
        dev)
            check_docker
            check_docker_compose
            build_image
            run_dev
            ;;
        prod)
            check_docker
            check_docker_compose
            build_image
            run_prod
            ;;
        run)
            check_docker
            build_image
            run_docker_cli
            ;;
        stop)
            check_docker
            stop
            ;;
        logs)
            check_docker
            view_logs
            ;;
        push)
            check_docker
            push_image $2
            ;;
        clean)
            check_docker
            cleanup
            ;;
        help)
            show_usage
            ;;
        *)
            print_error "Unknown command: $command"
            show_usage
            exit 1
            ;;
    esac
}

main $@
