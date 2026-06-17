# MEtiss Infrastructure Knowledge Transfer (KT) Document

## Table of Contents
1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Infrastructure Components](#infrastructure-components)
4. [Environment Setup](#environment-setup)
5. [Terraform Structure](#terraform-structure)
6. [Deployment Environments](#deployment-environments)
7. [Services Overview](#services-overview)
8. [Database Configuration](#database-configuration)
9. [Deployment Process](#deployment-process)
10. [Configuration Management](#configuration-management)
11. [Key Technologies](#key-technologies)
12. [Troubleshooting Guide](#troubleshooting-guide)

---

## Overview

MEtiss is a comprehensive GCP-based (Google Cloud Platform) infrastructure designed to manage solar energy data, analytics, and AI-powered insights. The infrastructure is built using **Terraform** for Infrastructure as Code (IaC) and deployed across multiple environments: Development (Dev), Staging (Stage), and Production (Prod).

### Key Characteristics:
- **Multi-environment setup** with consistent infrastructure across Dev, Stage, and Prod
- **Microservices architecture** with containerized services running on Google Cloud Run
- **PostgreSQL databases** for data persistence
- **Google AI/ML services** integration (Gemini, Firebase)
- **Cloud Storage** for data and media management
- **API Gateway** for service orchestration
- **CI/CD automation** through deployment scripts

---

## Architecture

### High-Level System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                      MEtiss Infrastructure                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                   Frontend Layer                         │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌─────────────────┐ │  │
│  │  │  Vista       │  │  Portal      │  │  Roof View      │ │  │
│  │  │  (Web UI)    │  │  (Dashboard) │  │  Widget         │ │  │
│  │  └──────────────┘  └──────────────┘  └─────────────────┘ │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                  ▼                               │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │             Google API Gateway                          │  │
│  │     (Service routing & authentication)                  │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                  ▼                               │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              Cloud Run Services                         │  │
│  │  ┌─────────────┐  ┌────────────────┐  ┌──────────────┐ │  │
│  │  │  Backend    │  │  Auth Service  │  │  AI/ML       │ │  │
│  │  │  Services   │  │                │  │  Services    │ │  │
│  │  └─────────────┘  └────────────────┘  └──────────────┘ │  │
│  │  ┌─────────────┐  ┌────────────────┐  ┌──────────────┐ │  │
│  │  │  MCP        │  │  Email Agent   │  │  PDF Gen     │ │  │
│  │  │  Services   │  │  Service       │  │  Service     │ │  │
│  │  └─────────────┘  └────────────────┘  └──────────────┘ │  │
│  │  ┌─────────────┐  ┌────────────────┐                    │  │
│  │  │  Solence    │  │  Orion (AI)    │                    │  │
│  │  │  Service    │  │  Backend       │                    │  │
│  │  └─────────────┘  └────────────────┘                    │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                  ▼                               │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │          Data & Storage Layer                           │  │
│  │  ┌────────────────┐  ┌──────────────┐  ┌─────────────┐ │  │
│  │  │  PostgreSQL    │  │  Cloud       │  │  Artifact   │ │  │
│  │  │  Databases     │  │  Storage     │  │  Registry   │ │  │
│  │  └────────────────┘  └──────────────┘  └─────────────┘ │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                  ▼                               │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │          External Services Integration                  │  │
│  │  ┌────────────┐  ┌──────────┐  ┌────────────────────┐  │  │
│  │  │  Firebase  │  │  Google  │  │  Salesforce        │  │  │
│  │  │            │  │  Maps    │  │                    │  │  │
│  │  └────────────┘  └──────────┘  └────────────────────┘  │  │
│  │  ┌────────────┐  ┌──────────┐  ┌────────────────────┐  │  │
│  │  │  Gmail     │  │  Gemini  │  │  Solar API         │  │  │
│  │  │  (SMTP)    │  │  (AI)    │  │  (Google)          │  │  │
│  │  └────────────┘  └──────────┘  └────────────────────┘  │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

---

## Infrastructure Components

### 1. **Compute Services (Google Cloud Run)**
- **Containerized Services**: All backend services are containerized and deployed on Google Cloud Run
- **Auto-scaling**: Services automatically scale from 0 to configured max instances
- **Pay-per-use**: Cost-effective for variable workloads

### 2. **Storage & Database**
- **PostgreSQL Databases**:
  - Main database (`metiss`): Core application data
  - AMS database (`metiss-ams-shared`): Additional management services
  - Read-only replicas for analytics
- **Cloud Storage**: For media files, documents, and data exports
- **Artifact Registry**: Docker image repository

### 3. **API Management**
- **API Gateway**: Central entry point for all service calls
- **Service Configuration**: OpenAPI specs for service definitions

### 4. **External Integrations**
- **Firebase**: Authentication & real-time capabilities
- **Google Maps API**: Location services
- **Gemini AI**: Generative AI capabilities
- **Solar API**: Solar energy data (Google)
- **Gmail/SMTP**: Email services
- **Salesforce**: CRM integration

### 5. **Security & Access Control**
- **IAM Service Accounts**: Fine-grained access control
- **API Keys**: Service authentication
- **Private Keys**: Secure credential management

---

## Environment Setup

### Prerequisites:
1. **GCP Account** with appropriate permissions
2. **Terraform** (v1.0+)
3. **gcloud CLI** installed and authenticated
4. **Docker** for building container images
5. **Git** for version control

### GCP Project Setup:
```bash
# Set up gcloud authentication
gcloud auth login
gcloud config set project [PROJECT_ID]

# Enable required APIs
gcloud services enable \
  cloudrun.googleapis.com \
  sqladmin.googleapis.com \
  artifactregistry.googleapis.com \
  apigateway.googleapis.com \
  servicemanagement.googleapis.com \
  servicecontrol.googleapis.com \
  cloudscheduler.googleapis.com \
  solar.googleapis.com
```

---

## Terraform Structure

### Directory Layout:
```
terraform/
├── Dev/
│   ├── main.tf                 # Main infrastructure definitions
│   ├── provider.tf             # GCP provider configuration
│   ├── backend.tf              # Terraform state backend
│   ├── variable.tf             # Variable definitions
│   ├── terraform.tfvars        # Environment-specific values
│   ├── metiss-helio/           # Metiss Helio service module
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── orion-ai/               # Orion AI service module
│   │   ├── main.tf
│   │   └── variable.tf
│   ├── orion-backend/          # Orion Backend service module
│   │   ├── main.tf
│   │   └── variable.tf
│   ├── orion-web/              # Orion Web service module
│   │   ├── main.tf
│   │   └── variable.tf
│   └── modules/
│       └── app/                # Main application module
│           ├── main.tf         # Core resources (Cloud Run, DB, etc.)
│           ├── variable.tf
│           └── openapi.yaml    # API specification
├── Stage/                      # Staging environment (similar structure)
└── Prod/                       # Production environment (similar structure)
```

### Key Files:

#### **main.tf**
- Defines Core Run services
- Database instances
- Storage buckets
- API gateway configuration
- Service accounts and IAM policies

#### **variable.tf**
- Declares all configurable variables
- Includes descriptions and defaults

#### **terraform.tfvars**
- Environment-specific values
- API keys, service names, database credentials
- **⚠️ IMPORTANT**: Contains sensitive data - must be secure

#### **provider.tf**
- GCP project configuration
- Region settings
- Provider version constraints

#### **backend.tf**
- Terraform state configuration
- Remote state storage location

---

## Deployment Environments

### 1. **Development (Dev)**
- **Project ID**: `metiss-dev`
- **Region**: `us-west1`
- **Database Tier**: `db-custom-8-32768` (8 vCPU, 32GB RAM)
- **Database Version**: PostgreSQL 17
- **Scaling**: Min 0, Max varies per service
- **Purpose**: Feature development and testing

**Key URLs:**
- API Gateway: `https://metiss-ai-gateway-6m7odqj.wl.gateway.dev`
- Vista (Frontend): `https://dev-vista.metiss.ai`
- Dashboard: Dev Portal instance

### 2. **Staging (Stage)**
- **Purpose**: Pre-production testing
- **Structure**: Mirrors production setup
- **Usage**: QA, UAT, and performance testing

### 3. **Production (Prod)**
- **Purpose**: Live environment
- **Structure**: Enhanced for reliability and performance
- **Scaling**: Higher min/max instance counts
- **Monitoring**: Enhanced logging and alerts

---

## Services Overview

### Backend Services (Cloud Run)

#### 1. **Utility Bill Service**
- **Purpose**: Process and manage utility bill data
- **Port**: 8080
- **Image**: `api/utility-bill-service`
- **Service Name**: `utility-bill-service`
- **Scaling**: Configurable (default: 0-5 instances)

#### 2. **Authentication Service**
- **Purpose**: Handle user authentication and authorization
- **Port**: 8080
- **Image**: `api/authenticator-service`
- **Integration**: Firebase for OAuth/SSO

#### 3. **Vista (Web Frontend)**
- **Purpose**: Main web application and dashboard
- **Port**: 8080
- **Image**: `vista`
- **Type**: Next.js application
- **Bucket**: `metiss-vista-web-dev`

#### 4. **Orion Suite** (AI-Powered Services)
- **Orion Backend**: Core API services
- **Orion AI**: Machine learning and AI operations
- **Orion Web**: Frontend for Orion features

#### 5. **Metiss Helio Service**
- **Purpose**: Solar energy data processing and analytics
- **Port**: 1337
- **Image**: `api/helio` (references from Artifact Registry)
- **Scaling**: 0-5 instances
- **CPU**: 2 cores, Memory: 2GB
- **Timeout**: 300 seconds
- **Public Access**: Yes (public invoker role)

#### 6. **MCP (Model Context Protocol) Services**
- **MCP Server**: Main MCP service
- **MCP Client**: Client-side MCP implementation
- **MCP AMS Server**: Asset Management System MCP
- **MCP Main Server**: Primary MCP instance

#### 7. **Supporting Services**
- **Email Agent Service**: Email processing and automation
- **PDF Generator Service**: Document generation
- **Savings Insight Report Service**: Report generation
- **Solence Service**: Data analytics and visualization
- **AMS Bulk Upload**: Batch data import

#### 8. **Portal Service**
- **Purpose**: Multi-tenant portal application
- **Min Instances**: Configurable (default: 0)
- **Type**: Multi-page application portal

---

## Database Configuration

### PostgreSQL Instances

#### **Main Database**
- **Instance**: `metiss-dev:us-west1:metiss`
- **Database Name**: `metiss`
- **Region**: `us-west1`
- **Tier**: `db-custom-8-32768`
- **Version**: PostgreSQL 17
- **Connection String**: 
  ```
  postgresql://metiss:Metiss@2025@43.225.21.76:5432/metiss
  ```
- **Cloud SQL Connection**: 
  ```
  metiss-dev:us-west1:metiss
  ```

#### **AMS Database** (Asset Management System)
- **Instance**: `metiss-dev:us-west1:metiss-ams-shared`
- **Database Name**: `metiss` (separate instance)
- **Shared Access**: Used by AMS-related services

#### **Read-Only Replicas**
- **Dev Main Replica**: `postgresql://metiss_ai_reader:...@43.225.21.76:5432/metiss`
- **Dev AMS Replica**: `postgresql://metiss_ai_reader:...@43.225.21.76:5432/metiss`
- **Purpose**: Analytics and reporting without impacting main database

### Database Connection Methods

#### **Direct Connection** (from outside Cloud)
```
postgresql://[USER]:[PASSWORD]@[IP_ADDRESS]:5432/[DB_NAME]
```

#### **Cloud SQL Proxy** (from Cloud Run)
```
postgresql://[USER]:[PASSWORD]@localhost/[DB_NAME]?host=/cloudsql/[INSTANCE_CONNECTION_NAME]
```

---

## Deployment Process

### Overview
The deployment process is automated through shell scripts located in `cloudshell-deployment-scripts/deploy-scripts/`.

### 1. **Docker Build & Push**
```bash
./deploy-scripts/deploy-docker.sh -s [SERVICE_NAME] -e [ENVIRONMENT] -b [BRANCH]
```
- Clones repository from GitHub
- Builds Docker image
- Pushes to Artifact Registry
- Tags with timestamp

### 2. **Terraform Deployment**
```bash
cd terraform/[ENVIRONMENT]
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```
- Validates infrastructure changes
- Creates/updates Cloud Run services
- Configures databases, IAM, storage
- Establishes service connections

### 3. **Service Update Flow**
```
┌─────────────────────────┐
│  1. Code Commit/Push    │
└────────────┬────────────┘
             ▼
┌─────────────────────────┐
│  2. GitHub Repository   │
└────────────┬────────────┘
             ▼
┌─────────────────────────┐
│  3. Deploy Script       │
│  - Clone repo           │
│  - Build Docker image   │
│  - Push to registry     │
└────────────┬────────────┘
             ▼
┌─────────────────────────┐
│  4. Artifact Registry   │
│  Docker image stored    │
└────────────┬────────────┘
             ▼
┌─────────────────────────┐
│  5. Terraform Apply     │
│  - Pull image           │
│  - Update Cloud Run     │
│  - Manage config        │
└────────────┬────────────┘
             ▼
┌─────────────────────────┐
│  6. Service Running     │
│  - New version active   │
└─────────────────────────┘
```

### Deployment Scripts

#### **Main Deployment Script** (`deploy.sh`)
```bash
./deploy.sh -s <SERVICE_NAME> -e <ENVIRONMENT> -b <BRANCH>

Example:
./deploy.sh -s metiss-orion-backend -e dev -b develop
```

#### **Encore Deployment** (`deploy-encore.sh`)
- Specialized script for Encore framework services
- Requires GitHub credentials
- Handles Encore-specific build steps

#### **MCP Deployment** (`deploy-mcp.sh`)
- Deploys MCP-based services
- Handles protocol-specific configuration

#### **Docker Deployment** (`deploy-docker.sh`)
- Standard Docker build and push
- Uses configuration files for build parameters

#### **Monorepo Deployment** (`deploy-monorepo.sh`)
- Handles services in monorepo structure
- Manages multiple service deployments

---

## Configuration Management

### Environment-Specific Configuration

#### **Development (`dev.conf`)**
```
PROJECT_ID="metiss-dev"
ARTIFACT_REGISTRY="gcr.io/metiss-dev"
REGION="us-west1"
DEFAULT_BRANCH="develop"
```

#### **Staging (`stage.conf`)**
```
PROJECT_ID="metiss-stage"
ARTIFACT_REGISTRY="gcr.io/metiss-stage"
REGION="us-west1"
DEFAULT_BRANCH="staging"
```

#### **Production (`prod.conf`)**
```
PROJECT_ID="metiss-prod"
ARTIFACT_REGISTRY="gcr.io/metiss-prod"
REGION="us-west1"
DEFAULT_BRANCH="main"
```

### Service Configuration

#### **Build Types** (`build-types.conf`)
Maps service names to build system types:
- Docker
- Encore
- MCP
- Standard

#### **Repository Mapping** (`repositories.conf`)
Maps service names to GitHub repository URLs

#### **Service Mapping** (`monorepo-services.conf`)
Defines services in monorepo structure

### Critical Configuration Variables

#### **Authentication & API Keys**
```
GOOGLE_API_KEY          # For Maps, Solar API
GENAI_API_KEY           # For Gemini/Claude
GCP_API_KEY             # General GCP services
```

#### **Firebase Configuration**
```
FIREBASE_PROJECT_ID
FIREBASE_PRIVATE_KEY_ID
FIREBASE_PRIVATE_KEY
FIREBASE_CLIENT_EMAIL
... (other Firebase credentials)
```

#### **Database Credentials**
```
DB_USER                 # PostgreSQL username
DB_PSWD                 # PostgreSQL password
DB_NAME                 # Database name
INSTANCE_CONNECTION_NAME # Cloud SQL connection
```

#### **Email Configuration**
```
SMTP_USER               # SMTP login
SMTP_PASS               # SMTP password
SENDER_EMAIL            # From address
SENDER_FROM             # Display name
SENDER_CC, SENDER_BCC   # Additional recipients
```

#### **External Service URLs**
```
USER_SERVICE_URL        # User microservice endpoint
ORG_SERVICE_URL         # Organization service endpoint
SOLAR_BASE_URL          # Google Solar API endpoint
```

---

## Key Technologies

### Infrastructure
- **Google Cloud Platform (GCP)**
- **Terraform** - Infrastructure as Code
- **Docker** - Container technology
- **Cloud Run** - Serverless compute

### Databases
- **PostgreSQL** - Relational database
- **Cloud SQL** - Managed PostgreSQL

### APIs & Services
- **Google API Gateway** - API management
- **Firebase** - Authentication & real-time
- **Cloud Storage** - Object storage

### External Services
- **Google Maps API** - Location services
- **Google Gemini** - Generative AI
- **Gmail/SMTP** - Email delivery
- **Google Solar API** - Solar energy data
- **Salesforce** - CRM integration

### Development
- **GitHub** - Version control
- **Cloud Build** - CI/CD
- **Artifact Registry** - Image repository

---

## Troubleshooting Guide

### Common Issues & Solutions

#### **1. Cloud Run Service Not Deploying**
**Problem**: Terraform fails to create/update Cloud Run service

**Solutions**:
```bash
# Check service quota
gcloud compute project-info describe --project=[PROJECT_ID]

# Check container image exists
gcloud artifacts docker images list us-west1-docker.pkg.dev/[PROJECT]/[REPO]

# View Terraform logs
TF_LOG=DEBUG terraform apply

# Check IAM permissions
gcloud projects get-iam-policy [PROJECT_ID]
```

#### **2. Database Connection Failed**
**Problem**: Services cannot connect to PostgreSQL

**Solutions**:
```bash
# Check Cloud SQL instance is running
gcloud sql instances list

# Verify connection string
psql postgresql://[USER]:[PASSWORD]@[IP]:5432/[DB]

# Check Cloud SQL Proxy (if using from Cloud Run)
gcloud sql connect [INSTANCE_NAME]

# Verify firewall rules
gcloud sql instances describe [INSTANCE_NAME] --format="get(ipAddresses)"
```

#### **3. Terraform State Conflicts**
**Problem**: State lock or conflicts

**Solutions**:
```bash
# Refresh state
terraform refresh

# Import external resources
terraform import [RESOURCE_TYPE].[RESOURCE_NAME] [RESOURCE_ID]

# Force unlock (use with caution)
terraform force-unlock [LOCK_ID]
```

#### **4. Image Pull Errors**
**Problem**: Cloud Run cannot pull Docker image from Artifact Registry

**Solutions**:
```bash
# Check image permissions
gcloud artifacts images describe [IMAGE_URI]

# Verify Cloud Run service account has access
gcloud projects get-iam-policy [PROJECT_ID] \
  --flatten="bindings[].members" \
  --format='table(bindings.role)' \
  --filter="bindings.members:[email@iam.gserviceaccount.com]"

# Grant artifact registry access
gcloud projects add-iam-policy-binding [PROJECT_ID] \
  --member=serviceAccount:[EMAIL] \
  --role=roles/artifactregistry.reader
```

#### **5. Environment Variable Not Available**
**Problem**: Services cannot access configured environment variables

**Solutions**:
```bash
# Check service configuration
gcloud run services describe [SERVICE_NAME] --region=[REGION]

# Update service with new env vars
gcloud run services update [SERVICE_NAME] \
  --set-env-vars=[KEY]=[VALUE] \
  --region=[REGION]

# Through Terraform, ensure all vars are in terraform.tfvars
```

#### **6. Insufficient Resources/Quota**
**Problem**: Cannot scale or deploy due to quota limits

**Solutions**:
```bash
# Check current quota
gcloud compute project-info describe --project=[PROJECT_ID]

# Request quota increase via Google Cloud Console
# Quotas > Select metric > Edit quota > Request

# Alternatively, reduce service scaling limits in terraform.tfvars
```

### Debugging Commands

```bash
# View Cloud Run service logs
gcloud run services describe [SERVICE_NAME] --region=[REGION]
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=[SERVICE_NAME]" \
  --limit=100 \
  --format=json

# Check Cloud Run service metrics
gcloud monitoring metrics-descriptors list --filter="metric.type:run.googleapis.com"

# Verify API permissions
gcloud services list --enabled

# Test service connectivity
curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" \
  https://[SERVICE_URL]/[ENDPOINT]
```

### Performance Optimization

#### **Database Performance**
```sql
-- Check slow queries
SELECT query, calls, mean_time FROM pg_stat_statements 
ORDER BY mean_time DESC LIMIT 10;

-- Create indexes for frequently queried columns
CREATE INDEX idx_column_name ON table_name(column_name);

-- Analyze query plans
EXPLAIN ANALYZE SELECT ...
```

#### **Cloud Run Performance**
- Increase CPU allocation in Terraform: `cpu = "4"`
- Increase memory allocation: `memory = "4Gi"`
- Increase max instances for concurrent load
- Use Cloud CDN for static assets

---

## Deployment Checklist

### Pre-Deployment
- [ ] Code reviewed and merged to target branch
- [ ] All tests passing
- [ ] Environment-specific config verified
- [ ] API keys and secrets in place
- [ ] Database migrations ready
- [ ] Backup of current state taken

### Deployment
- [ ] Run terraform plan and verify changes
- [ ] Build and push Docker image
- [ ] Run terraform apply
- [ ] Verify service is healthy
- [ ] Check logs for errors
- [ ] Run smoke tests

### Post-Deployment
- [ ] Monitor service performance
- [ ] Check error rates and logs
- [ ] Verify all integrations working
- [ ] Update documentation
- [ ] Notify team of deployment

---

## Contact & Support

### Key Contacts
- **Infrastructure Team**: [Team Email]
- **DevOps Lead**: [Lead Name]
- **GCP Account Manager**: [Manager Info]

### Resources
- [Terraform Documentation](https://www.terraform.io/docs)
- [Google Cloud Platform Docs](https://cloud.google.com/docs)
- [Cloud Run Guide](https://cloud.google.com/run/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs)

### Documentation
- Terraform Configuration: This repository
- API Specifications: `terraform/[ENV]/modules/app/openapi.yaml`
- Deployment Scripts: `cloudshell-deployment-scripts/`

---

**Document Version**: 1.0  
**Last Updated**: 2026-06-17  
**Maintained By**: DevOps Team
