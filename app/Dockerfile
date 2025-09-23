# Simple, reliable Dockerfile for demo application
FROM nginx:1.21-alpine

# Install curl for health checks
RUN apk add --no-cache curl && \
    rm -rf /var/cache/apk/*

# Copy custom nginx configuration
COPY app/nginx.conf /etc/nginx/nginx.conf

# Copy the demo application
COPY app/index.html /usr/share/nginx/html/index.html

# Add build information (replaced by CI build args)
ARG BUILD_VERSION=dev
ARG BUILD_TIME=unknown
ARG GIT_SHA=unknown

# Replace placeholders in HTML with build information
RUN sed -i "s/BUILD_VERSION/${BUILD_VERSION}/g" /usr/share/nginx/html/index.html && \
    sed -i "s/BUILD_TIME/${BUILD_TIME}/g" /usr/share/nginx/html/index.html && \
    sed -i "s/GIT_SHA_PLACEHOLDER/${GIT_SHA}/g" /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

# Metadata labels
LABEL org.opencontainers.image.title="GitOps Demo Application" \
      org.opencontainers.image.description="Demo application for GitOps presentations" \
      org.opencontainers.image.version="${BUILD_VERSION}" \
      org.opencontainers.image.created="${BUILD_TIME}" \
      org.opencontainers.image.revision="${GIT_SHA}"

# Start nginx (runs as root by default, which is fine for demo purposes)
CMD ["nginx", "-g", "daemon off;"]