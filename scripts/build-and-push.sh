#!/bin/bash

set -e

# Variables
PROJECT_NAME="ecs-microservices"
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Building and pushing Docker images for ECS Microservices...${NC}"
echo -e "${YELLOW}👨‍💻 Developer: Jotheesh${NC}"

# Get ECR login token
echo -e "${YELLOW}🔐 Logging into ECR...${NC}"
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Build and push Service A
echo -e "${YELLOW}🏗️ Building Service A...${NC}"
cd service-a
docker build -t $PROJECT_NAME-service-a .
docker tag $PROJECT_NAME-service-a:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME-service-a:latest

echo -e "${YELLOW}📦 Pushing Service A to ECR...${NC}"
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME-service-a:latest

cd ..

# Build and push Service B
echo -e "${YELLOW}🏗️ Building Service B...${NC}"
cd service-b
docker build -t $PROJECT_NAME-service-b .
docker tag $PROJECT_NAME-service-b:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME-service-b:latest

echo -e "${YELLOW}📦 Pushing Service B to ECR...${NC}"
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME-service-b:latest

cd ..

echo -e "${GREEN}✅ Docker images built and pushed successfully!${NC}"
echo -e "${GREEN}🔗 Service A: $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME-service-a:latest${NC}"
echo -e "${GREEN}🔗 Service B: $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME-service-b:latest${NC}"
