# Stage 1: Build Flutter Web
FROM ghcr.io/cirruslabs/flutter:3.41.5 AS builder

WORKDIR /app

# Copy project files
COPY pubspec.yaml pubspec.lock* ./
RUN flutter pub get

COPY . .

# Build Flutter web (release, with CanvasKit for rich rendering)
RUN flutter build web --release

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Create non-root user
RUN addgroup -g 1001 -S appuser && adduser -S appuser -u 1001

# Copy built web files
COPY --from=builder /app/build/web /usr/share/nginx/html

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Change ownership
RUN chown -R appuser:appuser /usr/share/nginx/html && \
    chown -R appuser:appuser /var/cache/nginx && \
    chown -R appuser:appuser /var/log/nginx && \
    chown -R appuser:appuser /etc/nginx/conf.d && \
    touch /var/run/nginx.pid && \
    chown -R appuser:appuser /var/run/nginx.pid

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8080 || exit 1

# Run as non-root user
USER appuser

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
