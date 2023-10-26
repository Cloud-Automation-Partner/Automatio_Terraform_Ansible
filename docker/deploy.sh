#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

trap errorHandler ERR

errorHandler() {
  echo "Error occurred in the deployment process! Check the above logs for details."
  exit 1
}

# Step 1: Build images for production
echo "Building images for production..."
docker-compose -f docker-compose.production.yml up --build -d

# Step 2: Tag and Push to Docker Hub
echo "Tagging and pushing timebot_sidekiq..."
docker tag timebot_sidekiq:latest zahidmahmood1995/timebot-be:sidekiq
docker push zahidmahmood1995/timebot-be:sidekiq

echo "Tagging and pushing timebot_web..."
docker tag timebot_web:latest zahidmahmood1995/timebot-be:web
docker push zahidmahmood1995/timebot-be:web

echo "Tagging and pushing timebot_frontend-prod..."
docker tag timebot_frontend-prod:latest zahidmahmood1995/timebot-be:frontend
docker push zahidmahmood1995/timebot-be:frontend

echo "Deployment script finished."
