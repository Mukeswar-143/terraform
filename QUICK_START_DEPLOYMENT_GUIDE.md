# MEtiss Infrastructure - Quick Start & Deployment Guide

## Quick Navigation

| Document | Purpose |
|----------|---------|
| **METISS_INFRASTRUCTURE_KT.md** | Comprehensive infrastructure overview & troubleshooting |
| **METISS_ARCHITECTURE_DIAGRAMS.md** | Visual system architecture & data flow diagrams |
| **This Guide** | Step-by-step deployment procedures |

---

## 🚀 Quick Start - First Time Setup

### 1. Prerequisites Checklist
```bash
# Check if all tools are installed
gcloud --version           # Should be v400+
terraform --version        # Should be v1.0+
docker --version          # Latest version
git --version             # Latest version
```

### 2. GCP Project Setup (One-Time)
```bash
# Set default project
gcloud config set project metiss-dev

# Enable required APIs
gcloud services enable \
  cloudrun.googleapis.com \
  sqladmin.googleapis.com \
  artifactregistry.googleapis.com \
  apigateway.googleapis.com \
  servicemanagement.googleapis.com \
  servicecontrol.googleapis.com \
  cloudscheduler.googleapis.com \
  solar.googleapis.com \
  cloudbuilder.googleapis.com

# Create service account for Terraform
gcloud iam service-accounts create terraform-sa \
  --display-name="Terraform Service Account"

# Grant necessary roles
gcloud projects add-iam-policy-binding metiss-dev \
  --member="serviceAccount:terraform-sa@metiss-dev.iam.gserviceaccount.com" \
  --role="roles/editor"

# Create and download key
gcloud iam service-accounts keys create ~/key-dev.json \
  --iam-account=terraform-sa@metiss-dev.iam.gserviceaccount.com

# Set authentication
export GOOGLE_APPLICATION_CREDENTIALS=~/key-dev.json
```

### 3. Terraform Initialization
```bash
cd terraform/Dev

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# View what will be created
terraform plan
```

### 4. Deploy Infrastructure
```bash
# Apply infrastructure
terraform apply

# View outputs
terraform output
```

---

## 📋 Deployment Procedures

### A. Deploy a New Service

#### Step 1: Update Configuration
Edit `terraform/Dev/terraform.tfvars`:
```hcl
# Add your service configuration
my_service_name = "my-new-service"
my_service_image = "api/my-service:latest"
```

#### Step 2: Add Service Module
Create `terraform/Dev/my-service/main.tf`:
```hcl
resource "google_cloud_run_v2_service" "my_service" {
  name     = var.service_name
  location = var.region
  
  template {
    containers {
      image = var.image_url
      
      ports {
        container_port = var.port
      }
      
      dynamic "env" {
        for_each = var.env_vars
        content {
          name  = env.key
          value = env.value
        }
      }
      
      resources {
        limits = {
          cpu    = "2"
          memory = "2Gi"
        }
      }
    }
    
    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }
  }
}
```

#### Step 3: Update Main Module
Edit `terraform/Dev/main.tf`:
```hcl
module "my_service" {
  source = "./my-service"
  
  service_name = var.my_service_name
  image_url    = var.my_service_image
  port         = 8080
  region       = var.region
  env_vars     = {
    # Add environment variables
  }
}
```

#### Step 4: Plan and Apply
```bash
terraform plan
terraform apply
```

#### Step 5: Verify Deployment
```bash
# Check service status
gcloud run services describe my-service --region=us-west1

# View logs
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=my-service" \
  --limit=50 \
  --format=json

# Test endpoint
curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" \
  https://my-service-xxxxx.run.app/health
```

---

### B. Deploy Metiss Helio Service

#### Quick Deploy
```bash
cd cloudshell-deployment-scripts

./deploy.sh -s metiss-helio -e dev -b develop
```

#### Manual Deploy (Step-by-Step)

**Step 1: Build Docker Image**
```bash
# Clone repository
git clone https://github.com/[org]/metiss-helio.git
cd metiss-helio

# Build image
docker build -t metiss-helio:latest .

# Tag for GCP Artifact Registry
docker tag metiss-helio:latest us-west1-docker.pkg.dev/metiss-dev/gcr.io/metiss-helio:latest

# Push to registry
docker push us-west1-docker.pkg.dev/metiss-dev/gcr.io/metiss-helio:latest
```

**Step 2: Update Terraform Configuration**
Edit `terraform/Dev/metiss-helio/main.tf`:
```hcl
resource "google_cloud_run_v2_service" "metiss_helio" {
  name     = "metiss-helio"
  location = var.region
  
  template {
    containers {
      image = "us-west1-docker.pkg.dev/metiss-dev/gcr.io/metiss-helio:latest"
      
      ports {
        container_port = 1337
      }
      
      env {
        name  = "SOLAR_API_KEY"
        value = var.SOLAR_API_KEY
      }
      
      env {
        name  = "DATABASE_URL"
        value = var.DATABASE_URL
      }
      
      env {
        name  = "GEMINI_API_KEY"
        value = var.GEMINI_API_KEY
      }
      
      resources {
        limits = {
          cpu    = "2"
          memory = "2Gi"
        }
      }
    }
    
    scaling {
      min_instance_count = 0
      max_instance_count = 5
    }
    
    timeout = "300s"
  }
}

resource "google_cloud_run_v2_service_iam_member" "public_access" {
  location = google_cloud_run_v2_service.metiss_helio.location
  name     = google_cloud_run_v2_service.metiss_helio.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
```

**Step 3: Apply Terraform**
```bash
cd terraform/Dev

terraform plan
terraform apply
```

**Step 4: Verify Service**
```bash
# Get service URL
gcloud run services describe metiss-helio --region=us-west1 --format='value(status.url)'

# Test service
curl https://metiss-helio-xxxxx.run.app/health
```

---

### C. Update Environment Variables

#### Method 1: Through Terraform
Edit `terraform/Dev/terraform.tfvars`:
```hcl
SOLAR_API_KEY = "AIzaSy..."
GEMINI_API_KEY = "AIzaSy..."
DATABASE_URL = "postgresql://..."
```

Then apply:
```bash
terraform apply
```

#### Method 2: Direct gcloud Command
```bash
gcloud run services update metiss-helio \
  --set-env-vars=SOLAR_API_KEY=AIzaSy...,GEMINI_API_KEY=AIzaSy... \
  --region=us-west1
```

#### Method 3: View Current Variables
```bash
gcloud run services describe metiss-helio --region=us-west1 --format=json | jq '.spec.template.spec.containers[0].env'
```

---

### D. Deploy Across Environments

#### Deploy to Dev
```bash
cd terraform/Dev
terraform plan -out=dev.tfplan
terraform apply dev.tfplan
```

#### Deploy to Staging (Promote)
```bash
# Copy Dev config as base
cp terraform/Dev/terraform.tfvars terraform/Stage/terraform.tfvars

# Update staging-specific values
vim terraform/Stage/terraform.tfvars
# Change: project_id, database credentials, URLs, etc.

# Deploy to staging
cd terraform/Stage
terraform init
terraform plan -out=stage.tfplan
terraform apply stage.tfplan
```

#### Deploy to Production (Careful!)
```bash
# Backup current state
terraform state pull > prod-backup.json

# Deploy
cd terraform/Prod
terraform init
terraform plan -out=prod.tfplan

# Review plan carefully before applying
terraform apply prod.tfplan
```

---

## 🔧 Common Deployment Tasks

### 1. Scale a Service Up/Down

**Increase Max Instances:**
```bash
# Edit terraform.tfvars
max_instance_count = 10  # From 5

# Apply changes
terraform apply
```

**Or via gcloud:**
```bash
gcloud run services update metiss-helio \
  --max-instances=10 \
  --region=us-west1
```

### 2. Rollback to Previous Version

```bash
# Option 1: From Git
git log --oneline terraform/Dev/metiss-helio/main.tf
git checkout <commit-hash> -- terraform/Dev/metiss-helio/main.tf
terraform apply

# Option 2: From Terraform State
terraform state show google_cloud_run_v2_service.metiss_helio
# Manual rollback via gcloud

# Option 3: From Cloud Run History
gcloud run services describe metiss-helio --region=us-west1
# Look at revision history and promote previous revision
gcloud run services update-traffic metiss-helio \
  --to-revisions=<previous-revision-id>=100 \
  --region=us-west1
```

### 3. Check Resource Usage & Costs

```bash
# View resource metrics
gcloud monitoring time-series list \
  --filter='resource.type="cloud_run_revision"'

# View Cloud Run pricing
gcloud compute project-info describe --project=metiss-dev | grep -i quota

# Estimate costs
gcloud billing accounts list
```

### 4. Update Database

**Scale Database:**
```hcl
# Edit terraform.tfvars
db_tier = "db-custom-16-65536"  # Larger instance
db_version = "POSTGRES_17"

# Apply
terraform apply
```

**Create Database Backup:**
```bash
gcloud sql backups create \
  --instance=metiss \
  --backup-configuration=automatic

gcloud sql backups list --instance=metiss
```

**Restore from Backup:**
```bash
gcloud sql backups restore <BACKUP_ID> \
  --backup-instance=metiss
```

### 5. Monitor Deployments

```bash
# Watch deployment progress
watch 'gcloud run services describe metiss-helio --region=us-west1'

# View real-time logs
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=metiss-helio" \
  --limit=100 \
  --format='table(timestamp, jsonPayload.message)' \
  --follow

# Monitor metrics
gcloud monitoring read \
  "cloudfunctions.googleapis.com/execution_times" \
  --filter='resource.label.function_name=metiss-helio'
```

---

## 🐛 Troubleshooting Common Issues

### Issue 1: Build Fails with "Image not found"
```bash
# Verify image exists in Artifact Registry
gcloud artifacts docker images list us-west1-docker.pkg.dev/metiss-dev/gcr.io

# If missing, rebuild:
docker build -t us-west1-docker.pkg.dev/metiss-dev/gcr.io/metiss-helio:latest .
docker push us-west1-docker.pkg.dev/metiss-dev/gcr.io/metiss-helio:latest
```

### Issue 2: Service Not Getting Traffic
```bash
# Check service has invoker permissions
gcloud run services get-iam-policy metiss-helio --region=us-west1

# If missing, add public access:
gcloud run services add-iam-policy-binding metiss-helio \
  --member="allUsers" \
  --role="roles/run.invoker" \
  --region=us-west1
```

### Issue 3: Database Connection Timeout
```bash
# Test Cloud SQL connection
gcloud sql connect metiss --user=metiss

# Check Cloud SQL Auth proxy
gcloud sql instances describe metiss | grep -E "status|currentDiskSize"

# Test from Cloud Run (check service account has Cloud SQL Client role)
gcloud projects add-iam-policy-binding metiss-dev \
  --member=serviceAccount:[SERVICE_ACCOUNT_EMAIL] \
  --role="roles/cloudsql.client"
```

### Issue 4: Terraform State Lock
```bash
# Check lock
terraform state show

# If stuck, force unlock (use with caution):
terraform force-unlock <LOCK_ID>

# Or remove local lock file:
rm .terraform/terraform.tfstate.lock.hcl
```

---

## 📚 Essential Commands Reference

### Terraform Commands
```bash
terraform init              # Initialize Terraform
terraform validate          # Validate configuration
terraform plan              # Show what will change
terraform apply             # Apply changes
terraform destroy           # Destroy infrastructure
terraform state list        # List resources in state
terraform state show <res>  # Show resource details
terraform refresh           # Refresh state from cloud
terraform import <res> <id> # Import existing resource
```

### GCloud Commands
```bash
# Authentication
gcloud auth login
gcloud config set project <PROJECT_ID>
gcloud auth application-default login

# Cloud Run
gcloud run services list --region=us-west1
gcloud run services describe <SERVICE> --region=us-west1
gcloud run services update <SERVICE> --set-env-vars=KEY=VALUE --region=us-west1
gcloud run services delete <SERVICE> --region=us-west1

# Logging
gcloud logging read "resource.type=cloud_run_revision" --limit=50
gcloud logging read "resource.type=cloud_run_revision" --follow

# Cloud SQL
gcloud sql instances list
gcloud sql connect <INSTANCE> --user=postgres
gcloud sql backups list --instance=<INSTANCE>

# Artifact Registry
gcloud artifacts docker images list <REPOSITORY>
gcloud artifacts docker images describe <IMAGE_URL>
```

### Docker Commands
```bash
# Build and push
docker build -t <TAG> .
docker tag <SOURCE_TAG> <DEST_TAG>
docker push <TAG>

# Test locally
docker run -p 8080:8080 <TAG>

# Debug
docker logs <CONTAINER_ID>
docker exec -it <CONTAINER_ID> /bin/bash
```

---

## ✅ Pre-Deployment Checklist

Before each deployment:
- [ ] All code changes committed and pushed
- [ ] Code reviewed and tested locally
- [ ] Docker image builds successfully
- [ ] Environment variables in `terraform.tfvars` are correct
- [ ] Database backups are current
- [ ] Terraform plan reviewed and approved
- [ ] No uncommitted Terraform changes
- [ ] Sufficient GCP quota available
- [ ] Team notified of deployment window
- [ ] Rollback plan documented

---

## 📞 Getting Help

### Common Resources
- **Terraform Docs**: https://www.terraform.io/docs/providers/google
- **Google Cloud Docs**: https://cloud.google.com/docs
- **Cloud Run Docs**: https://cloud.google.com/run/docs
- **Helio Service Repo**: [GitHub URL]

### Debugging Steps
1. Check logs: `gcloud logging read ...`
2. Check service status: `gcloud run services describe ...`
3. Check Terraform state: `terraform state show`
4. Check GCP quotas and limits
5. Verify IAM permissions
6. Check firewall rules
7. Review error messages carefully

---

**Version**: 1.0  
**Last Updated**: 2026-06-17  
**Prepared For**: MEtiss Team KT Session
