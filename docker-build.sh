#!/bin/bash

# ============================================================================
# Docker Build Script for Db4Fresh
# Builds and pushes Docker images to AWS ECR
# ============================================================================

set -e

# Configuration
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="233542590"
ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
FRONTEND_REPO="frontend-ecr-repo"
BACKEND_REPO="backend-ecr-repo"
BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
GIT_COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")

echo "========================================"
echo "Db4Fresh Docker Build Script"
echo "========================================"
echo "AWS Region: $AWS_REGION"
echo "AWS Account: $AWS_ACCOUNT_ID"
echo "Build Date: $BUILD_DATE"
echo "Git Commit: $GIT_COMMIT"
echo "Git Branch: $GIT_BRANCH"
echo ""

# Function to build and push image
build_and_push() {
    local dockerfile=$1
    local repo=$2
    local tag=$3
    
    echo "Building: $repo:$tag"
    docker build \
        -f "$dockerfile" \
        -t "${ECR_REGISTRY}/${repo}:${tag}" \
        -t "${ECR_REGISTRY}/${repo}:latest" \
        --build-arg BUILD_DATE="$BUILD_DATE" \
        --build-arg GIT_COMMIT="$GIT_COMMIT" \
        --build-arg GIT_BRANCH="$GIT_BRANCH" \
        .
    
    echo "Pushing: $repo:$tag"
    docker push "${ECR_REGISTRY}/${repo}:${tag}"
    docker push "${ECR_REGISTRY}/${repo}:latest"
    
    echo "✓ Successfully pushed $repo:$tag"
}

# Login to ECR
echo "Logging in to AWS ECR..."
aws ecr get-login-password --region "$AWS_REGION" | \
    docker login --username AWS --password-stdin "$ECR_REGISTRY"

echo ""

# Build frontend
echo "========================================"
echo "Building Frontend Image"
echo "========================================"
build_and_push "Dockerfile.frontend" "$FRONTEND_REPO" "$GIT_COMMIT"

echo ""

# Build backend
echo "========================================"
echo "Building Backend Image"
echo "========================================"
build_and_push "Dockerfile.backend" "$BACKEND_REPO" "$GIT_COMMIT"

echo ""
echo "========================================"
echo "✓ All images built and pushed successfully!"
echo "========================================"
echo ""
echo "Frontend: ${ECR_REGISTRY}/${FRONTEND_REPO}:${GIT_COMMIT}"
echo "Backend:  ${ECR_REGISTRY}/${BACKEND_REPO}:${GIT_COMMIT}"
echo ""
