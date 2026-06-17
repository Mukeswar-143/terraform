# MEtiss Architecture Diagrams

## 1. System Architecture Diagram

```mermaid
graph TB
    subgraph "User Layer"
        WEB["🌐 Vista Web App"]
        PORTAL["📊 Portal Dashboard"]
        WIDGET["🎨 Roof View Widget"]
    end

    subgraph "API Gateway Layer"
        GATEWAY["🔗 Google API Gateway<br/>metiss-ai-gateway"]
    end

    subgraph "Backend Services - Cloud Run"
        AUTH["🔐 Auth Service<br/>authenticator-service"]
        BACKEND["🔧 Backend Services<br/>utility-bill-service"]
        MCP_SERVER["📡 MCP Server"]
        EMAIL["📧 Email Agent"]
        PDF["📄 PDF Generator"]
        
        SOLENCE["📈 Solence<br/>Analytics"]
        ORION_AI["🤖 Orion AI<br/>ML Services"]
        ORION_BACKEND["🎯 Orion Backend"]
        
        HELIO["☀️ Metiss Helio<br/>Solar Engine"]
        AMS["📦 AMS Bulk Upload"]
    end

    subgraph "Data Layer"
        MAIN_DB["🗄️ PostgreSQL Main DB<br/>metiss"]
        AMS_DB["🗄️ PostgreSQL AMS DB<br/>metiss-ams-shared"]
        READONLY["📖 Read-Only Replicas"]
        STORAGE["☁️ Cloud Storage<br/>Buckets"]
        ARTIFACTS["📦 Artifact Registry<br/>Docker Images"]
    end

    subgraph "External Services"
        FIREBASE["🔑 Firebase Auth"]
        MAPS["🗺️ Google Maps API"]
        GEMINI["✨ Gemini AI API"]
        SOLAR["☀️ Solar API"]
        GMAIL["📧 Gmail/SMTP"]
        SALESFORCE["💼 Salesforce CRM"]
    end

    WEB --> GATEWAY
    PORTAL --> GATEWAY
    WIDGET --> GATEWAY
    
    GATEWAY --> AUTH
    GATEWAY --> BACKEND
    GATEWAY --> ORION_BACKEND
    GATEWAY --> HELIO
    
    AUTH --> FIREBASE
    BACKEND --> MAIN_DB
    BACKEND --> MAPS
    BACKEND --> GMAIL
    
    ORION_AI --> GEMINI
    ORION_AI --> MAIN_DB
    
    HELIO --> SOLAR
    HELIO --> MAIN_DB
    
    MCP_SERVER --> MAIN_DB
    MCP_SERVER --> AMS_DB
    EMAIL --> GMAIL
    EMAIL --> MAIN_DB
    PDF --> MAIN_DB
    
    SOLENCE --> MAIN_DB
    SOLENCE --> READONLY
    
    AMS --> AMS_DB
    
    MAIN_DB -.Replication.- READONLY
    MAIN_DB -.Backup.- STORAGE
    
    AUTH -.Image.- ARTIFACTS
    BACKEND -.Image.- ARTIFACTS
    ORION_AI -.Image.- ARTIFACTS
    HELIO -.Image.- ARTIFACTS

    style WEB fill:#e1f5ff
    style PORTAL fill:#e1f5ff
    style WIDGET fill:#e1f5ff
    style GATEWAY fill:#fff3e0
    style AUTH fill:#f3e5f5
    style BACKEND fill:#f3e5f5
    style HELIO fill:#e8f5e9
    style MAIN_DB fill:#fce4ec
    style AMS_DB fill:#fce4ec
    style ARTIFACTS fill:#fff9c4
```

## 2. Deployment Environment Architecture

```mermaid
graph LR
    subgraph DEV["Development (metiss-dev)"]
        DEV_GCP["GCP Project: metiss-dev"]
        DEV_DB["PostgreSQL 17<br/>db-custom-8-32768"]
        DEV_CR["Cloud Run<br/>Services 0-5"]
        DEV_STORAGE["Cloud Storage"]
    end

    subgraph STAGE["Staging (metiss-stage)"]
        STAGE_GCP["GCP Project: metiss-stage"]
        STAGE_DB["PostgreSQL 17<br/>db-custom-8-32768"]
        STAGE_CR["Cloud Run<br/>Services"]
        STAGE_STORAGE["Cloud Storage"]
    end

    subgraph PROD["Production (metiss-prod)"]
        PROD_GCP["GCP Project: metiss-prod"]
        PROD_DB["PostgreSQL 17<br/>Optimized Tier"]
        PROD_CR["Cloud Run<br/>High Availability"]
        PROD_STORAGE["Cloud Storage"]
    end

    GIT["GitHub Repo"]
    TERRAFORM["Terraform Code"]
    
    GIT -->|Deploy Script| DEV
    GIT -->|Deploy Script| STAGE
    GIT -->|Deploy Script| PROD
    
    TERRAFORM -->|Init & Apply| DEV_GCP
    TERRAFORM -->|Init & Apply| STAGE_GCP
    TERRAFORM -->|Init & Apply| PROD_GCP
    
    DEV_GCP --> DEV_DB
    DEV_GCP --> DEV_CR
    DEV_GCP --> DEV_STORAGE
    
    STAGE_GCP --> STAGE_DB
    STAGE_GCP --> STAGE_CR
    STAGE_GCP --> STAGE_STORAGE
    
    PROD_GCP --> PROD_DB
    PROD_GCP --> PROD_CR
    PROD_GCP --> PROD_STORAGE

    style DEV fill:#c8e6c9
    style STAGE fill:#fff9c4
    style PROD fill:#ffccbc
```

## 3. Metiss Helio Service Architecture

```mermaid
graph TB
    subgraph "Input"
        API["Solar Data API Requests"]
        SOURCES["External Data Sources"]
    end

    subgraph "Metiss Helio Service"
        PORT["Port: 1337"]
        CONTAINER["Container Config:<br/>CPU: 2 cores<br/>Memory: 2GB<br/>Timeout: 300s"]
        IMAGE["Docker Image:<br/>Artifact Registry<br/>helio_image"]
    end

    subgraph "Processing"
        SOLAR_API["Solar API Integration<br/>solar.googleapis.com"]
        GEMINI["Gemini AI<br/>Processing"]
        CALCULATIONS["Energy Calculations<br/>& Analysis"]
    end

    subgraph "Storage & Output"
        DB["PostgreSQL<br/>Main Database"]
        CACHE["Query Results<br/>Cache"]
        OUTPUT["API Response"]
    end

    subgraph "Scaling"
        MIN["Min Instances: 0"]
        MAX["Max Instances: 5"]
        AUTO["Auto-scaling<br/>Based on Load"]
    end

    API --> PORT
    SOURCES --> PORT
    PORT --> CONTAINER
    CONTAINER --> IMAGE
    
    IMAGE --> SOLAR_API
    IMAGE --> GEMINI
    IMAGE --> CALCULATIONS
    
    SOLAR_API --> DB
    GEMINI --> DB
    CALCULATIONS --> DB
    
    DB --> CACHE
    CACHE --> OUTPUT
    
    PORT --> MIN
    MIN --> AUTO
    AUTO --> MAX

    style PORT fill:#e0f2f1
    style CONTAINER fill:#f1f8e9
    style SOLAR_API fill:#ffe0b2
    style DB fill:#fce4ec
    style OUTPUT fill:#c8e6c9
```

## 4. Data Flow Diagram

```mermaid
graph TD
    USERS["👥 Users<br/>Web/Mobile/API"]
    
    USERS -->|Request| GATEWAY["🔗 API Gateway<br/>Route & Authenticate"]
    
    GATEWAY -->|Auth Request| AUTH["🔐 Auth Service<br/>Firebase Integration"]
    AUTH -->|Token| GATEWAY
    
    GATEWAY -->|Data Request| SERVICES["☁️ Cloud Run Services"]
    
    SERVICES -->|Query| PRIMARY["🗄️ Primary DB<br/>metiss"]
    SERVICES -->|Write| PRIMARY
    
    PRIMARY -->|Replicate| READONLY["📖 Read-Only DB<br/>Analytics Replica"]
    
    SERVICES -->|Read| READONLY
    SERVICES -->|External API| EXTERNAL["🌐 Google APIs<br/>Firebase, Maps, Solar"]
    EXTERNAL -->|Response| SERVICES
    
    SERVICES -->|Store| STORAGE["☁️ Cloud Storage<br/>Media & Exports"]
    
    SERVICES -->|Cache| CACHE["⚡ Response Cache"]
    
    SERVICES -->|Response| GATEWAY
    GATEWAY -->|Response| USERS
    
    SERVICES -->|Logs & Metrics| MONITORING["📊 Cloud Logging<br/>Cloud Monitoring"]
    MONITORING -->|Alerts| ALERTS["🔔 Alerting<br/>Notification"]

    style USERS fill:#bbdefb
    style GATEWAY fill:#fff3e0
    style AUTH fill:#f3e5f5
    style SERVICES fill:#e8f5e9
    style PRIMARY fill:#fce4ec
    style READONLY fill:#fce4ec
    style EXTERNAL fill:#ffe0b2
    style MONITORING fill:#f0f4c3
```

## 5. Terraform Infrastructure Code Structure

```mermaid
graph TD
    subgraph "Root Module"
        ROOT["terraform/Dev/<br/>main.tf"]
    end
    
    subgraph "App Module"
        APP_MAIN["modules/app/<br/>main.tf"]
        APP_VAR["modules/app/<br/>variable.tf"]
    end
    
    subgraph "Service Modules"
        HELIO["metiss-helio/<br/>main.tf"]
        ORION_AI["orion-ai/<br/>main.tf"]
        ORION_BE["orion-backend/<br/>main.tf"]
        ORION_WEB["orion-web/<br/>main.tf"]
    end
    
    subgraph "Configuration Files"
        TFVARS["terraform.tfvars<br/>Environment Values"]
        PROVIDER["provider.tf<br/>GCP Config"]
        BACKEND["backend.tf<br/>State Storage"]
        VAR["variable.tf<br/>Variable Definitions"]
    end
    
    subgraph "Resources Created"
        CLOUD_RUN["Cloud Run Services"]
        DB["Cloud SQL<br/>PostgreSQL"]
        IAM["IAM Service<br/>Accounts"]
        STORAGE_RES["Storage Buckets"]
        API_GW["API Gateway"]
    end
    
    ROOT -->|imports| APP_MAIN
    ROOT -->|imports| HELIO
    ROOT -->|imports| ORION_AI
    ROOT -->|imports| ORION_BE
    ROOT -->|imports| ORION_WEB
    
    APP_MAIN -->|uses| APP_VAR
    HELIO -->|defines variables| ORION_AI
    
    TFVARS -->|provides values| ROOT
    PROVIDER -->|configures| ROOT
    BACKEND -->|stores state| ROOT
    VAR -->|declares variables| ROOT
    
    APP_MAIN -->|creates| CLOUD_RUN
    APP_MAIN -->|creates| DB
    APP_MAIN -->|creates| IAM
    APP_MAIN -->|creates| STORAGE_RES
    APP_MAIN -->|creates| API_GW
    
    HELIO -->|creates| CLOUD_RUN
    ORION_AI -->|creates| CLOUD_RUN
    ORION_BE -->|creates| CLOUD_RUN
    ORION_WEB -->|creates| CLOUD_RUN

    style ROOT fill:#fff3e0
    style APP_MAIN fill:#f3e5f5
    style TFVARS fill:#c8e6c9
    style CLOUD_RUN fill:#bbdefb
    style DB fill:#fce4ec
```

## 6. Deployment Pipeline

```mermaid
graph LR
    CODE["👨‍💻 Code Commit<br/>to GitHub"]
    
    CODE -->|Push| REPO["📦 GitHub<br/>Repository"]
    
    REPO -->|Trigger| BUILD["🔨 Build Docker<br/>Image"]
    
    BUILD -->|docker build| IMG["🐳 Docker<br/>Image"]
    
    IMG -->|docker push| ARTIFACT["📦 Artifact<br/>Registry"]
    
    ARTIFACT -->|Image Reference| PLAN["📋 Terraform Plan<br/>terraform plan"]
    
    PLAN -->|Review Changes| APPROVAL["✅ Approval<br/>Gate"]
    
    APPROVAL -->|Approved| APPLY["🚀 Terraform Apply<br/>terraform apply"]
    
    APPLY -->|Creates/Updates| RUN["☁️ Cloud Run<br/>Service"]
    
    APPLY -->|Configures| DB["🗄️ Database<br/>Settings"]
    
    RUN -->|Pulls Image| ARTIFACT
    
    RUN -->|Running| PROD["✨ Production<br/>Service"]
    
    PROD -->|Monitored| LOGS["📊 Cloud Logs<br/>& Metrics"]
    
    LOGS -->|Alerts| TEAM["👥 DevOps<br/>Team"]

    style CODE fill:#c8e6c9
    style REPO fill:#bbdefb
    style BUILD fill:#fff9c4
    style IMG fill:#ffccbc
    style ARTIFACT fill:#f8bbd0
    style PLAN fill:#e1bee7
    style APPLY fill:#c5cae9
    style RUN fill:#b2dfdb
    style PROD fill:#a5d6a7
    style LOGS fill:#fff9c4
```

## 7. Service Dependencies Graph

```mermaid
graph TD
    WEB["Vista Web<br/>Frontend"]
    PORTAL["Portal<br/>Dashboard"]
    
    WEB -->|Calls| AUTH["Auth Service"]
    PORTAL -->|Calls| AUTH
    
    WEB -->|Calls| BACKEND["Backend<br/>Services"]
    PORTAL -->|Calls| BACKEND
    
    BACKEND -->|Calls| HELIO["Helio Service<br/>Solar Data"]
    BACKEND -->|Calls| REPORTS["Reports<br/>Service"]
    BACKEND -->|Calls| EMAIL["Email<br/>Service"]
    
    AUTH -->|Validate| FIREBASE["Firebase<br/>Auth"]
    
    HELIO -->|Query| MAIN_DB["Main DB"]
    HELIO -->|Call| SOLAR["Solar API"]
    HELIO -->|Process| GEMINI["Gemini AI"]
    
    REPORTS -->|Query| MAIN_DB
    REPORTS -->|Generate| PDF["PDF Generator"]
    
    EMAIL -->|Send via| SMTP["Gmail/SMTP"]
    
    BACKEND -->|Read Analytics| READONLY["Read-Only DB<br/>Replica"]
    
    ORION["Orion AI<br/>Service"] -->|Query| MAIN_DB
    ORION -->|Query| AMS["AMS DB<br/>Shared"]
    ORION -->|Process| GEMINI
    
    MCP["MCP Services"] -->|Query| MAIN_DB
    MCP -->|Query| AMS

    style WEB fill:#e3f2fd
    style AUTH fill:#f3e5f5
    style BACKEND fill:#e8f5e9
    style HELIO fill:#fff3e0
    style FIREBASE fill:#fce4ec
    style MAIN_DB fill:#f8bbd0
    style GEMINI fill:#c8e6c9
```

---

**Diagrams Generated**: 7 comprehensive architecture diagrams
**Format**: Mermaid (auto-rendered in most markdown viewers)
