#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 ECS Microservices Deployment Script${NC}"
echo -e "${BLUE}👨‍💻 Developer: Jotheesh${NC}"
echo -e "${BLUE}📅 $(date)${NC}"
echo ""

# Check if AWS CLI is configured
if ! aws sts get-caller-identity >/dev/null 2>&1; then
    echo -e "${RED}❌ Error: AWS CLI is not configured. Please run 'aws configure' first.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ AWS CLI configured successfully${NC}"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
echo -e "${BLUE}🏢 AWS Account: $ACCOUNT_ID${NC}"

# Build and push images
echo -e "${YELLOW}📋 Step 1: Building and pushing Docker images...${NC}"
./scripts/build-and-push.sh

# Deploy infrastructure
echo -e "${YELLOW}📋 Step 2: Deploying infrastructure with Terraform...${NC}"
cd terraform

# Initialize Terraform
echo -e "${BLUE}🔧 Initializing Terraform...${NC}"
terraform init

# Plan deployment
echo -e "${BLUE}📋 Planning Terraform deployment...${NC}"
terraform plan

# Apply deployment
echo -e "${BLUE}🚀 Applying Terraform configuration...${NC}"
terraform apply -auto-approve

# Get outputs
ALB_DNS=$(terraform output -raw alb_dns_name)

cd ..

echo ""
echo -e "${GREEN}🎉 Deployment completed successfully!${NC}"
echo -e "${GREEN}🌐 Access your services at:${NC}"
echo -e "${GREEN}   📍 Service A: http://$ALB_DNS/api/v1/a${NC}"
echo -e "${GREEN}   📍 Service B: http://$ALB_DNS/api/v1/b${NC}"
echo -e "${YELLOW}⏰ Note: It may take a few minutes for the services to be fully available.${NC}"
echo ""
echo -e "${BLUE}🔍 Test commands:${NC}"
echo -e "${BLUE}   curl http://$ALB_DNS/api/v1/a${NC}"
echo -e "${BLUE}   curl http://$ALB_DNS/api/v1/b${NC}"
