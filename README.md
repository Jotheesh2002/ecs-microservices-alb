# 🚀 ECS Microservices with ALB

[![Deploy ECS Microservices](https://github.com/Jotheesh2002/ecs-microservices-alb/actions/workflows/deploy.yml/badge.svg)](https://github.com/Jotheesh2002/ecs-microservices-alb/actions/workflows/deploy.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![AWS](https://img.shields.io/badge/AWS-Cloud-orange)](https://aws.amazon.com/)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-purple)](https://terraform.io/)

> **Production-ready ECS Fargate microservices with Application Load Balancer routing, auto-scaling, and comprehensive monitoring - Built by [Jotheesh](https://github.com/Jotheesh2002)**

This project demonstrates deploying two containerized microservices (`service-a` and `service-b`) on AWS ECS Fargate behind an Application Load Balancer (ALB). The load balancer intelligently routes traffic based on path patterns `/api/v1/a` and `/api/v1/b`.

## 🏗️ Architecture
┌─────────────────┐
                                │   Internet      │
                                │   Gateway       │
                                └─────────┬───────┘
                                          │
                                ┌─────────▼───────┐
                                │ Application     │
                                │ Load Balancer   │
                                └─────────┬───────┘
                                          │
                ┌─────────────────────────┼─────────────────────────┐
                │                         │                         │
      ┌─────────▼──────────┐                        ┌──────────▼─────────┐
      │  Target Group A    │                        │  Target Group B    │
      │  /api/v1/a/*       │                        │  /api/v1/b/*       │
      └─────────┬──────────┘                        └──────────┬─────────┘
                │                                              │
      ┌─────────▼──────────┐                        ┌──────────▼─────────┐
      │   ECS Service A    │                        │   ECS Service B    │
      │   Auto Scaling     │                        │   Auto Scaling     │
      └─────────┬──────────┘                        └──────────┬─────────┘
                │                                              │
      ┌─────────▼──────────┐                        ┌──────────▼─────────┐
      │  Fargate Tasks     │                        │  Fargate Tasks     │
      │  (Service A)       │                        │  (Service B)       │
      └────────────────────┘                        └────────────────────┘
## 🎯 Key Features

### ✅ **Production-Ready Infrastructure**
- **Containerized Microservices**: Each service runs in isolated containers
- **Serverless Deployment**: ECS Fargate eliminates server management
- **Intelligent Load Balancing**: Path-based routing with health checks
- **Auto Scaling**: CPU-based scaling (70% threshold) with 1-10 task range
- **Multi-AZ Deployment**: High availability across availability zones

### ✅ **DevOps Best Practices**
- **Infrastructure as Code**: Complete Terraform configuration
- **CI/CD Pipeline**: GitHub Actions with automated testing
- **Container Registry**: Private ECR repositories with image scanning
- **Security**: VPC isolation, security groups, and IAM least privilege
- **Monitoring**: CloudWatch logs, metrics, and custom dashboards

### ✅ **Developer Experience**
- **Local Development**: Docker Compose setup for local testing
- **Health Checks**: Comprehensive health monitoring at all levels
- **Easy Deployment**: One-command deployment scripts
- **Comprehensive Logging**: Centralized logging with CloudWatch

## 🚀 Quick Start

### Prerequisites
- AWS CLI configured with appropriate permissions
- Docker installed and running
- Terraform v1.6+ installed
- Git for version control

### 1️⃣ Clone and Setup
```bash
git clone https://github.com/Jotheesh2002/ecs-microservices-alb.git
cd ecs-microservices-alb

2️⃣ Configure AWS
bashaws configure
# Enter your AWS credentials and set region to us-east-1
3️⃣ Deploy Everything
bash# Make scripts executable
chmod +x scripts/*.sh

# Deploy complete infrastructure
./scripts/deploy.sh
4️⃣ Test Your Services
bash# The script will output URLs, or get them manually:
cd terraform
ALB_DNS=$(terraform output -raw alb_dns_name)

# Test Service A
curl http://$ALB_DNS/api/v1/a

# Test Service B  
curl http://$ALB_DNS/api/v1/b
📋 API Endpoints
Service A Endpoints
MethodEndpointDescriptionGET/Service information and healthGET/healthHealth check endpointGET/api/v1/aMain API endpoint with features
Service B Endpoints
MethodEndpointDescriptionGET/Service information and healthGET/healthHealth check endpointGET/api/v1/bMain API endpoint with features
Example Response
json{
  "service": "Service A",
  "endpoint": "/api/v1/a",
  "message": "API endpoint for Service A", 
  "hostname": "ip-10-0-1-123.ec2.internal",
  "features": ["Auto-scaling", "Health checks", "Load balancing"],
  "developer": "Jotheesh"
}
🏗️ Project Structure
ecs-microservices-alb/
├── 🐳 service-a/                 # Service A microservice
│   ├── app.py                   # Flask application
│   └── Dockerfile               # Container definition
├── 🐳 service-b/                 # Service B microservice  
│   ├── app.py                   # Flask application
│   └── Dockerfile               # Container definition
├── 🏗️ terraform/                 # Infrastructure as Code
│   ├── main.tf                  # Main configuration & VPC
│   ├── variables.tf             # Variable definitions
│   ├── ecs.tf                   # ECS cluster and services
│   ├── alb.tf                   # Application Load Balancer
│   ├── outputs.tf               # Output values
│   ├── cloudwatch.tf            # Logging and monitoring
│   └── terraform.tfvars.example # Example variables
├── 🚀 scripts/                   # Deployment automation
│   ├── build-and-push.sh        # Docker build and ECR push
│   └── deploy.sh                # Complete deployment script
├── 🔄 .github/workflows/         # CI/CD Pipeline
│   └── deploy.yml               # GitHub Actions workflow
├── 📊 screenshots/               # Architecture diagrams
├── 📄 .gitignore                 # Git ignore rules
└── 📖 README.md                  # This documentation
🔧 Advanced Configuration
Custom Resource Sizing
bash# Edit terraform/terraform.tfvars
cp terraform/terraform.tfvars.example terraform/terraform.tfvars

# Customize resources:
cpu = 512           # Default: 256
memory = 1024       # Default: 512
desired_count = 3   # Default: 2
Environment-Specific Deployments
bash# Production deployment
terraform workspace new production
terraform apply -var="desired_count=5" -var="cpu=512"

# Staging deployment  
terraform workspace new staging
terraform apply -var="desired_count=1" -var="cpu=256"
📊 Monitoring & Observability
CloudWatch Dashboard

ECS Metrics: CPU utilization, memory usage, task count
ALB Metrics: Request count, response time, error rates
Custom Metrics: Application-specific monitoring

Log Groups

Service A: /ecs/ecs-microservices-service-a
Service B: /ecs/ecs-microservices-service-b

Auto Scaling Configuration

Scale Out: CPU > 70% for 2 consecutive periods
Scale In: CPU < 70% for 15 consecutive periods
Task Range: 1 minimum, 10 maximum per service

🧪 Testing
Local Development
bash# Build and test locally
docker build -t service-a ./service-a
docker build -t service-b ./service-b

# Run services locally
docker run -p 8080:80 service-a
docker run -p 8081:80 service-b

# Test endpoints
curl http://localhost:8080/health
curl http://localhost:8081/health
Load Testing
bash# Install Apache Bench
sudo apt-get install apache2-utils

# Load test Service A
ab -n 1000 -c 10 http://<ALB_DNS>/api/v1/a

# Monitor auto-scaling in CloudWatch
🔄 CI/CD Pipeline
The GitHub Actions workflow automatically:

🏗️ Build Phase

Builds Docker images for both services
Pushes to ECR with commit SHA and latest tags
Scans images for vulnerabilities


🚀 Deploy Phase

Runs Terraform plan and apply
Updates ECS services with new images
Handles blue-green deployments


🧪 Test Phase

Waits for services to become healthy
Tests all endpoints for functionality
Reports deployment status



Required GitHub Secrets
Add these in your repository Settings → Secrets:

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY

💰 Cost Optimization
Estimated Monthly Costs (us-east-1)

ECS Fargate: ~$25-40/month (2 tasks, 256 CPU, 512 MB)
Application Load Balancer: ~$18/month
ECR Storage: <$1/month
CloudWatch Logs: <$5/month
Total: ~$50-65/month

Cost Reduction Tips
bash# Use Fargate Spot for development
# In terraform/ecs.tf, add:
capacity_provider_strategy {
  capacity_provider = "FARGATE_SPOT"
  weight           = 100
}
🛠️ Troubleshooting
Common Issues & Solutions
❌ Service Not Starting
bash# Check ECS service events
aws ecs describe-services --cluster ecs-microservices --services ecs-microservices-service-a

# Check CloudWatch logs
aws logs tail /ecs/ecs-microservices-service-a --follow
❌ ALB Returns 503 Error

Check target group health in AWS Console
Verify security group allows ALB → ECS communication (port 80)
Ensure /health endpoint responds with 200 status

❌ Docker Push Fails
bash# Re-authenticate with ECR
aws ecr get-login-password --region us-east-1 | \
docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com
❌ Terraform State Issues
bash# Refresh Terraform state
cd terraform
terraform refresh

# Import existing resources if needed
terraform import aws_ecs_cluster.main ecs-microservices
🧹 Cleanup
Complete Resource Cleanup
bash# Destroy all AWS resources
cd terraform
terraform destroy -auto-approve

# Clean up ECR images (optional)
aws ecr batch-delete-image \
  --repository-name ecs-microservices-service-a \
  --image-ids imageTag=latest

aws ecr batch-delete-image \
  --repository-name ecs-microservices-service-b \
  --image-ids imageTag=latest
🎯 Skills Demonstrated
This project showcases expertise in:
☁️ AWS Services

ECS/Fargate container orchestration
Application Load Balancer configuration
VPC networking and security groups
ECR container registry management
CloudWatch monitoring and logging
IAM roles and security policies

🏗️ Infrastructure as Code

Terraform best practices and modules
Resource dependencies and lifecycle management
Output values and variable management
State management and workspace usage

🔄 DevOps Practices

GitHub Actions CI/CD pipelines
Docker containerization and multi-stage builds
Automated testing and health checks
Blue-green deployment strategies

📊 Monitoring & Observability

CloudWatch dashboards and alarms
Application and infrastructure logging
Performance monitoring and alerting
Cost optimization strategies

🤝 Contributing

Fork the repository
Create a feature branch (git checkout -b feature/amazing-feature)
Commit your changes (git commit -m 'Add amazing feature')
Push to the branch (git push origin feature/amazing-feature)
Open a Pull Request

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.
👨‍💻 Author
Jotheesh

GitHub: @Jotheesh2002
Project: ecs-microservices-alb


