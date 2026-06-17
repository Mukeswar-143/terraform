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

### 4. **SECURITY_GUIDELINES_FOR_KT.md** 🔒 REQUIRED READING
**Purpose**: Critical security practices and incident response  
**Best for**: Everyone participating in the KT session  
**Contents**:
- ✅ What MUST NEVER be exposed
- ✅ What CAN safely be shared
- ✅ Pre-KT security checklist
- ✅ Documentation guidelines with examples
- ✅ .gitignore essentials
- ✅ Team training points by role
- ✅ Incident response procedures
- ✅ Best practices (DO's and DON'Ts)
- ✅ KT session security reminders
- ✅ Useful security commands

**Time to Read**: 15-20 minutes  
**For Roles**: EVERYONE - Mandatory for all team members

---

## 📋 Documentation Files (Updated)

### For **EVERYONE** (Mandatory First Reading):
- ⚠️ **SECURITY_GUIDELINES_FOR_KT.md** - 15 min - REQUIRED BEFORE KT

### For **Architects/Tech Leads**:
1. SECURITY_GUIDELINES_FOR_KT.md (15 min) - **REQUIRED**
2. METISS_ARCHITECTURE_DIAGRAMS.md (10 min)
3. METISS_INFRASTRUCTURE_KT.md (30 min)
4. Reference: QUICK_START_DEPLOYMENT_GUIDE.md (as needed)

### For **DevOps Engineers/SREs**:
1. SECURITY_GUIDELINES_FOR_KT.md (15 min) - **REQUIRED**
2. QUICK_START_DEPLOYMENT_GUIDE.md (30 min)
3. METISS_INFRASTRUCTURE_KT.md (45 min)
4. Troubleshooting: METISS_INFRASTRUCTURE_KT.md → Troubleshooting Guide

### For **New Developers**:
1. SECURITY_GUIDELINES_FOR_KT.md (15 min) - **REQUIRED**
2. METISS_ARCHITECTURE_DIAGRAMS.md (15 min)
3. METISS_INFRASTRUCTURE_KT.md - Services Overview section
4. Deploy Exercise: QUICK_START_DEPLOYMENT_GUIDE.md

### For **Operations/Support Team**:
1. SECURITY_GUIDELINES_FOR_KT.md (15 min) - **REQUIRED**
2. QUICK_START_DEPLOYMENT_GUIDE.md - Monitoring Deployments
3. METISS_INFRASTRUCTURE_KT.md - Troubleshooting Guide
4. Quick Commands: QUICK_START_DEPLOYMENT_GUIDE.md

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

### Step 1: Security First (15 min)
```bash
# READ FIRST - Everyone must understand security requirements
cat SECURITY_GUIDELINES_FOR_KT.md
```

### Step 2: Understand the System (30 min)
```bash
# Read the main KT document
cat METISS_INFRASTRUCTURE_KT.md

# View architecture diagrams
cat METISS_ARCHITECTURE_DIAGRAMS.md
```

### Step 3: Learn Deployment (20 min)
```bash
# Read the quick start guide
cat QUICK_START_DEPLOYMENT_GUIDE.md
```

### Step 4: Practice (Hands-on)
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

## 🔐 Critical Security Notes

### NEVER Expose in Documentation/Logs/VCS:
⚠️ **EXTREMELY SENSITIVE - NEVER commit or share**:
- `terraform.tfvars` files - Contains all secrets
- `key-*.json` - GCP service account keys
- `.env` files - Environment variables
- API keys (Google, Gemini, Solar API, etc.)
- Database passwords and connection strings
- Firebase private keys
- SMTP credentials
- Private encryption keys
- Service account emails (if internal)
- Internal service URLs (if sensitive)

### Best Practices
1. **Gitignore**: Add all sensitive files to `.gitignore`:
   ```
   terraform.tfvars
   *.tfvars
   key-*.json
   .env
   .env.local
   ```
2. **Documentation**: Use placeholders like `[API_KEY]`, `[DB_PASSWORD]`, `[PROJECT_ID]`
3. **Secret Management**: Use GCP Secret Manager or similar for production
4. **Rotation**: Rotate credentials every 90 days minimum
5. **Service Accounts**: Use for automation, not personal credentials
6. **Audit Logging**: Enable and monitor access logs
7. **Least Privilege**: Restrict IAM permissions to minimum required
8. **Code Review**: Never approve PRs that expose secrets
9. **Scanning**: Use tools to detect accidentally committed secrets
10. **Training**: Ensure team understands secret management practices

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
gcloud config set project [YOUR_PROJECT_ID]

# Planning & Deployment
cd terraform/Dev
terraform plan
terraform apply

# Monitoring
gcloud run services describe [SERVICE_NAME] --region=us-west1
gcloud logging read "resource.type=cloud_run_revision" --limit=50

# Troubleshooting
terraform state show
gcloud run services list --region=us-west1
```

---

## 📈 Learning Path

### Beginner (New to GCP/Terraform)
1. ⏱️ 15 min: Read SECURITY_GUIDELINES_FOR_KT.md (REQUIRED)
2. ⏱️ 10 min: Read Overview in Infrastructure KT
3. ⏱️ 15 min: View Architecture Diagrams
4. ⏱️ 10 min: Read Quick Start Prerequisites
5. ⏱️ 10 min: Try GCP Project Setup
6. **Total: 60 minutes**

### Intermediate (Some GCP experience)
1. ⏱️ 15 min: Read SECURITY_GUIDELINES_FOR_KT.md (REQUIRED)
2. ⏱️ 30 min: Read Infrastructure KT (skip basics)
3. ⏱️ 20 min: Review Architecture Diagrams
4. ⏱️ 25 min: Read Quick Start Guide
5. ⏱️ 15 min: Practice deployment steps
6. **Total: 105 minutes**

### Advanced (Senior engineer/architect)
1. ⏱️ 15 min: Read SECURITY_GUIDELINES_FOR_KT.md (REQUIRED)
2. ⏱️ 45 min: Read complete Infrastructure KT
3. ⏱️ 20 min: Review Architecture Diagrams & Terraform code structure
4. ⏱️ 20 min: Review Troubleshooting Guide
5. ⏱️ 15 min: Review deployment procedures for reference
6. **Total: 115 minutes**

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

### Pre-Session (Before KT)
- **All participants**: Read SECURITY_GUIDELINES_FOR_KT.md (15 min) - MANDATORY

### Morning (9:00 AM - 12:30 PM)
- **9:00-9:15**: Security Briefing & Q&A (Presenter: 15 min)
- **9:15-9:30**: Welcome & Agenda (Presenter: 15 min)
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
- **4:45-5:00**: Security Recap & Q&A, Wrap-up, Resources (15 min)

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
