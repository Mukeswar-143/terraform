# 📚 MEtiss Infrastructure KT Session - Complete Documentation Index

## 📖 Overview
This folder contains comprehensive Knowledge Transfer (KT) documentation for the MEtiss Infrastructure setup and deployment process. Use this index to navigate through all materials.

---

## 📋 Documentation Files

### 1. **METISS_INFRASTRUCTURE_KT.md** ⭐ START HERE
**Purpose**: Comprehensive infrastructure knowledge base  
**Best for**: Understanding the complete system, components, and architecture  
**Contents**:
- ✅ System overview and key characteristics
- ✅ Detailed architecture explanation
- ✅ Infrastructure components breakdown
- ✅ Environment setup requirements
- ✅ Terraform directory structure
- ✅ Deployment environments (Dev/Stage/Prod)
- ✅ Services overview (all 15+ microservices)
- ✅ Database configuration and connection methods
- ✅ Configuration management details
- ✅ External integrations
- ✅ Troubleshooting guide
- ✅ Deployment checklist

**Time to Read**: 30-45 minutes  
**For Roles**: Architects, DevOps Engineers, Tech Leads

---

### 2. **METISS_ARCHITECTURE_DIAGRAMS.md** 🎨 VISUAL REFERENCE
**Purpose**: Visual representation of the system architecture  
**Best for**: Understanding system flow and component relationships  
**Contents**:
- ✅ System Architecture Diagram (services & data flow)
- ✅ Deployment Environment Architecture (Dev/Stage/Prod)
- ✅ Metiss Helio Service Architecture (detailed)
- ✅ Data Flow Diagram (request/response patterns)
- ✅ Terraform Infrastructure Code Structure
- ✅ Deployment Pipeline (CI/CD flow)
- ✅ Service Dependencies Graph
- ✅ 7 comprehensive Mermaid diagrams

**Time to Review**: 15-20 minutes  
**For Roles**: Everyone (visual learners), Architects, Tech Leads

---

### 3. **QUICK_START_DEPLOYMENT_GUIDE.md** 🚀 PRACTICAL GUIDE
**Purpose**: Step-by-step operational procedures  
**Best for**: Hands-on deployment and day-to-day operations  
**Contents**:
- ✅ Quick start - first time setup (5 steps)
- ✅ GCP project setup with service accounts
- ✅ Terraform initialization guide
- ✅ Detailed deployment procedures (A, B, C, D sections)
- ✅ Deploy new services
- ✅ Deploy Metiss Helio service
- ✅ Update environment variables
- ✅ Cross-environment deployment (Dev→Stage→Prod)
- ✅ Common deployment tasks (scaling, rollback, etc.)
- ✅ Monitoring and troubleshooting
- ✅ Essential commands reference
- ✅ Pre-deployment checklist

**Time to Read**: 25-35 minutes  
**For Roles**: DevOps Engineers, SREs, Developers

---

## 🎯 Quick Navigation by Role

### For **Architects/Tech Leads**:
1. Start: METISS_ARCHITECTURE_DIAGRAMS.md (10 min)
2. Read: METISS_INFRASTRUCTURE_KT.md (30 min)
3. Reference: QUICK_START_DEPLOYMENT_GUIDE.md (as needed)

### For **DevOps Engineers/SREs**:
1. Start: QUICK_START_DEPLOYMENT_GUIDE.md (30 min)
2. Deep Dive: METISS_INFRASTRUCTURE_KT.md (45 min)
3. Troubleshooting: METISS_INFRASTRUCTURE_KT.md → Troubleshooting Guide

### For **New Developers**:
1. Start: METISS_ARCHITECTURE_DIAGRAMS.md (15 min)
2. Read: METISS_INFRASTRUCTURE_KT.md - Services Overview section
3. Deploy Exercise: QUICK_START_DEPLOYMENT_GUIDE.md - Deploy a New Service

### For **Operations/Support Team**:
1. Start: QUICK_START_DEPLOYMENT_GUIDE.md - Monitoring Deployments
2. Reference: METISS_INFRASTRUCTURE_KT.md - Troubleshooting Guide
3. Quick Commands: QUICK_START_DEPLOYMENT_GUIDE.md - Essential Commands Reference

---

## 🔍 Topic Quick Reference

### Understanding the System
| Topic | Document | Section |
|-------|----------|---------|
| **High-level overview** | Infrastructure KT | Overview |
| **System architecture** | Architecture Diagrams | System Architecture Diagram |
| **Component breakdown** | Infrastructure KT | Infrastructure Components |
| **Services list** | Infrastructure KT | Services Overview |
| **Data flow** | Architecture Diagrams | Data Flow Diagram |

### Infrastructure & Technology
| Topic | Document | Section |
|-------|----------|---------|
| **GCP setup** | Quick Start Guide | Prerequisites & GCP Project Setup |
| **Terraform structure** | Infrastructure KT | Terraform Structure |
| **Environment setup** | Infrastructure KT | Environment Setup |
| **Terraform code layout** | Architecture Diagrams | Terraform Infrastructure Code Structure |
| **Database configuration** | Infrastructure KT | Database Configuration |

### Deployment & Operations
| Topic | Document | Section |
|-------|----------|---------|
| **First-time setup** | Quick Start Guide | Quick Start - First Time Setup |
| **Deploy a service** | Quick Start Guide | Deployment Procedures - A |
| **Deploy Metiss Helio** | Quick Start Guide | Deployment Procedures - B |
| **Update env variables** | Quick Start Guide | Deployment Procedures - C |
| **Cross-environment deploy** | Quick Start Guide | Deployment Procedures - D |
| **Scaling services** | Quick Start Guide | Common Deployment Tasks - 1 |
| **Rollback procedure** | Quick Start Guide | Common Deployment Tasks - 2 |

### Troubleshooting & Monitoring
| Topic | Document | Section |
|-------|----------|---------|
| **Troubleshooting guide** | Infrastructure KT | Troubleshooting Guide |
| **Common issues** | Quick Start Guide | Troubleshooting Common Issues |
| **Monitoring** | Quick Start Guide | Common Deployment Tasks - Monitoring |
| **Debug commands** | Infrastructure KT | Troubleshooting Guide → Debugging Commands |

---

## 📊 Infrastructure Statistics

### Services Deployed
- **Total Services**: 15+
- **Backend Services**: 12
- **Frontend Services**: 2
- **Support Services**: 3+

### Environments
- **Development**: metiss-dev (Active)
- **Staging**: metiss-stage (Active)
- **Production**: metiss-prod (Active)

### Key Technologies
- **Infrastructure**: Google Cloud Platform (GCP)
- **IaC**: Terraform v1.0+
- **Compute**: Google Cloud Run (serverless)
- **Database**: PostgreSQL 17
- **Container Registry**: Artifact Registry
- **API Gateway**: Google API Gateway
- **CI/CD**: Automated deployment scripts

### Resource Sizing (Dev)
- **Database Tier**: db-custom-8-32768 (8 vCPU, 32GB RAM)
- **Cloud Run Min/Max**: 0-5 instances per service
- **Container Resources**: Varies (typically 2 CPU, 2-4GB Memory)
- **Storage**: Configurable buckets

---

## 🛠️ Getting Started - 3 Simple Steps

### Step 1: Understand the System (30 min)
```bash
# Read the main KT document
cat METISS_INFRASTRUCTURE_KT.md

# View architecture diagrams
cat METISS_ARCHITECTURE_DIAGRAMS.md
```

### Step 2: Learn Deployment (20 min)
```bash
# Read the quick start guide
cat QUICK_START_DEPLOYMENT_GUIDE.md
```

### Step 3: Practice (Hands-on)
```bash
# Follow "Quick Start - First Time Setup" in QUICK_START_DEPLOYMENT_GUIDE.md
# Or follow "Deploy a New Service" procedure
```

---

## 📝 Key Concepts & Terminology

### Core Concepts
- **Cloud Run**: Google's serverless compute platform
- **Terraform**: Infrastructure as Code tool
- **Microservices**: Independent, deployable services
- **PostgreSQL**: Relational database
- **API Gateway**: Central routing for all services
- **Artifact Registry**: Docker image repository

### MEtiss-Specific
- **Metiss Helio**: Solar energy data processing service
- **Orion**: AI-powered features suite
- **MCP**: Model Context Protocol services
- **Vista**: Main web application
- **Portal**: Dashboard interface
- **GENAI**: Generative AI features (Gemini)

### Deployment Terms
- **Terraform State**: Current infrastructure configuration stored remotely
- **Cloud Run Service**: Deployed containerized application
- **Environment Variables**: Configuration values passed to services
- **IAM**: Identity and Access Management (permissions)
- **Service Account**: GCP identity for automated operations

---

## 🔐 Important Security Notes

### Sensitive Information
⚠️ **The following files/folders contain secrets and must be protected**:
- `terraform/*/terraform.tfvars` - Contains API keys and credentials
- `.env` files - Local environment variables
- `key-*.json` - GCP service account keys

### Best Practices
1. Never commit secrets to Git
2. Use `.gitignore` for sensitive files
3. Rotate credentials regularly
4. Use service accounts for automation
5. Enable audit logging
6. Restrict IAM permissions (principle of least privilege)

---

## 📞 Support & Resources

### Internal Resources
- **DevOps Team Email**: [team-email]
- **Infrastructure Owner**: [owner-name]
- **Slack Channel**: #infrastructure-team

### External Resources
- **Terraform Docs**: https://www.terraform.io/docs
- **Google Cloud Docs**: https://cloud.google.com/docs
- **Cloud Run Guide**: https://cloud.google.com/run/docs
- **PostgreSQL Docs**: https://www.postgresql.org/docs

### Useful Commands Cheat Sheet
```bash
# Authentication
gcloud auth login
gcloud config set project metiss-dev

# Planning & Deployment
cd terraform/Dev
terraform plan
terraform apply

# Monitoring
gcloud run services describe metiss-helio --region=us-west1
gcloud logging read "resource.type=cloud_run_revision" --limit=50

# Troubleshooting
terraform state show
gcloud run services list --region=us-west1
```

---

## 📈 Learning Path

### Beginner (New to GCP/Terraform)
1. ⏱️ 10 min: Read Overview in Infrastructure KT
2. ⏱️ 15 min: View Architecture Diagrams
3. ⏱️ 10 min: Read Quick Start Prerequisites
4. ⏱️ 10 min: Try GCP Project Setup
5. **Total: 45 minutes**

### Intermediate (Some GCP experience)
1. ⏱️ 30 min: Read Infrastructure KT (skip basics)
2. ⏱️ 20 min: Review Architecture Diagrams
3. ⏱️ 25 min: Read Quick Start Guide
4. ⏱️ 15 min: Practice deployment steps
5. **Total: 90 minutes**

### Advanced (Senior engineer/architect)
1. ⏱️ 45 min: Read complete Infrastructure KT
2. ⏱️ 20 min: Review Architecture Diagrams & Terraform code structure
3. ⏱️ 20 min: Review Troubleshooting Guide
4. ⏱️ 15 min: Review deployment procedures for reference
5. **Total: 100 minutes**

---

## ✅ Self-Assessment Checklist

After completing the KT, you should be able to:

### Understanding
- [ ] Explain MEtiss system architecture
- [ ] Describe key components and their roles
- [ ] Understand service dependencies
- [ ] Explain data flow through the system

### Operational Knowledge
- [ ] Set up GCP project for deployment
- [ ] Initialize and use Terraform
- [ ] Deploy a service using the deployment script
- [ ] Check service status and logs
- [ ] Update environment variables

### Troubleshooting
- [ ] Identify common deployment issues
- [ ] Use debugging commands effectively
- [ ] Check Cloud SQL connectivity
- [ ] Review and interpret logs
- [ ] Perform basic rollbacks

### Best Practices
- [ ] Follow security guidelines
- [ ] Use proper naming conventions
- [ ] Manage Terraform state correctly
- [ ] Document changes appropriately
- [ ] Communicate with team on deployments

---

## 📅 Recommended Study Schedule (Full Day KT Session)

### Morning (9:00 AM - 12:30 PM)
- **9:00-9:30**: Welcome & Agenda (Presenter: 30 min)
- **9:30-10:15**: Infrastructure Overview (Read: 30 min, Q&A: 15 min)
- **10:15-10:30**: Break (15 min)
- **10:30-11:10**: Architecture Walkthrough using Diagrams (Presenter: 40 min)
- **11:10-11:40**: Q&A & Discussion (30 min)
- **11:40-12:30**: GCP Setup Demo (Live Demo: 50 min)

### Afternoon (1:00 PM - 5:00 PM)
- **1:00-1:30**: Terraform Overview (Presentation: 30 min)
- **1:30-2:30**: Deployment Procedures Walkthrough (Live Demo: 60 min)
- **2:30-2:45**: Break (15 min)
- **2:45-3:45**: Hands-on Exercise 1: Deploy Test Service (Hands-on: 60 min)
- **3:45-4:15**: Troubleshooting Guide Walkthrough (Presentation: 30 min)
- **4:15-4:45**: Hands-on Exercise 2: Fix a Broken Deployment (Hands-on: 30 min)
- **4:45-5:00**: Q&A, Wrap-up, Resources (15 min)

---

## 🎓 Certification Track (Optional)

### Level 1: Infrastructure User
**Requirements**:
- Complete KT materials
- Successfully deploy one service
- **Time**: 2-3 hours

### Level 2: Infrastructure Operator
**Requirements**:
- Level 1 + 
- Deploy services across all environments
- Perform basic troubleshooting
- **Time**: 4-6 hours

### Level 3: Infrastructure Developer
**Requirements**:
- Level 2 +
- Create custom service modules
- Manage Terraform state
- Implement monitoring
- **Time**: 8-12 hours

---

## 📎 Document Information

| Attribute | Value |
|-----------|-------|
| **Created**: | 2026-06-17 |
| **Version**: | 1.0 |
| **Status**: | Active |
| **Maintained By**: | DevOps Team |
| **Last Updated**: | 2026-06-17 |
| **Next Review**: | 2026-12-17 |

---

## 📌 Quick Links

- **Infrastructure KT Document**: [METISS_INFRASTRUCTURE_KT.md](METISS_INFRASTRUCTURE_KT.md)
- **Architecture Diagrams**: [METISS_ARCHITECTURE_DIAGRAMS.md](METISS_ARCHITECTURE_DIAGRAMS.md)
- **Quick Start Guide**: [QUICK_START_DEPLOYMENT_GUIDE.md](QUICK_START_DEPLOYMENT_GUIDE.md)
- **Terraform Code**: [terraform/](terraform/)
- **Deployment Scripts**: [cloudshell-deployment-scripts/](cloudshell-deployment-scripts/)

---

## 🎯 Next Steps

1. **Immediately**: Read METISS_INFRASTRUCTURE_KT.md
2. **Today**: Review METISS_ARCHITECTURE_DIAGRAMS.md
3. **This Week**: Complete QUICK_START_DEPLOYMENT_GUIDE.md exercises
4. **Going Forward**: Use these documents as reference during deployments

---

**Happy Learning! 🚀**

For questions or clarifications, reach out to the DevOps team.
