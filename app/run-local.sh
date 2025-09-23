#!/bin/bash
# Local development runner

set -euo pipefail

echo "🚀 Starting GitOps Demo App locally"

# Build and run
docker-compose up --build --remove-orphans

echo "✅ Demo app running at http://localhost:8080"
echo "🔗 Health check: http://localhost:8080/health"
echo "📊 Metrics: http://localhost:8080/metrics"
echo "🔍 Hostname API: http://localhost:8080/api/hostname"
