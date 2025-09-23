# Multi-stage build for optimized production image
FROM nginx:1.21-alpine AS base

# Install build tools for any customizations
RUN apk add --no-cache \
    curl \
    jq \
    && rm -rf /var/cache/apk/*

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the demo application
COPY index.html /usr/share/nginx/html/index.html

# Add build information (will be replaced by CI)
ARG BUILD_VERSION=dev
ARG BUILD_TIME=unknown
ARG GIT_SHA=unknown

# Replace placeholders in HTML
RUN sed -i "s/BUILD_VERSION/${BUILD_VERSION}/g" /usr/share/nginx/html/index.html && \
    sed -i "s/BUILD_TIME/${BUILD_TIME}/g" /usr/share/nginx/html/index.html

# Create a non-root user for security
RUN addgroup -g 1001 -S nginx && \
    adduser -S -D -H -u 1001 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx

# Set proper permissions
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

# Switch to non-root user
USER nginx

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

# Labels for metadata
LABEL org.opencontainers.image.title="GitOps Demo Application" \
      org.opencontainers.image.description="Demo application for GitOps presentations" \
      org.opencontainers.image.version="${BUILD_VERSION}" \
      org.opencontainers.image.created="${BUILD_TIME}" \
      org.opencontainers.image.revision="${GIT_SHA}"

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
