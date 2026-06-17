# 🔒 Security Guidelines for MEtiss Infrastructure KT

**CRITICAL**: This document outlines mandatory security practices for sharing and managing MEtiss infrastructure knowledge.

---

## ⚠️ What MUST NEVER Be Exposed

### Absolutely Forbidden to Share:
```
❌ terraform.tfvars files
❌ key-*.json (service account keys)
❌ .env files with secrets
❌ API keys (any kind)
❌ Database passwords
❌ Firebase private keys
❌ SMTP passwords
❌ Actual database URLs/IPs
❌ Actual service URLs
❌ Firebase credentials
❌ Personal access tokens
```

### Examples of What NOT to Share:
```
❌ postgresql://metiss:Metiss@2025@43.225.21.76:5432/metiss
❌ AIzaSyA2SuI5jq2VCun1GCq44_gGrBcFLup0iEs
❌ -----BEGIN PRIVATE KEY-----MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKg...
❌ https://metiss-ai-gateway-6m7odqj.wl.gateway.dev
```

---

## ✅ What CAN Be Shared

### Safe Documentation Includes:
```
✅ Architecture diagrams
✅ Service names and relationships
✅ Configuration structure (not values)
✅ Deployment procedures
✅ Troubleshooting guides
✅ Code patterns and examples
✅ Database schema (not credentials)
✅ API endpoints (generic)
✅ Service port numbers
✅ Region information
✅ Generic placeholder values [PROJECT_ID], [API_KEY], etc.
```

---

## 📋 Pre-KT Session Security Checklist

### Preparation:
- [ ] Remove all actual secrets from code examples
- [ ] Use placeholders: `[PROJECT_ID]`, `[API_KEY]`, `[DB_PASSWORD]`
- [ ] Remove real URLs from documentation
- [ ] Sanitize all configuration examples
- [ ] Review all code samples for exposed secrets
- [ ] Verify `.gitignore` includes `terraform.tfvars`
- [ ] Verify `.gitignore` includes `*.tfvars`
- [ ] Verify `.gitignore` includes `key-*.json`
- [ ] Verify `.gitignore` includes `.env`

### Document Review:
- [ ] Search for email addresses in credentials
- [ ] Search for `://` (URLs)
- [ ] Search for `BEGIN PRIVATE KEY`
- [ ] Search for database connection strings
- [ ] Search for actual API keys
- [ ] Search for IP addresses (suspicious ones)
- [ ] Search for actual project IDs (where not needed)

### Example - Safe vs Unsafe:

**UNSAFE** ❌
```yaml
DATABASE_URL: postgresql://metiss:Metiss@2025@43.225.21.76:5432/metiss
GOOGLE_API_KEY: AIzaSyA2SuI5jq2VCun1GCq44_gGrBcFLup0iEs
FIREBASE_PROJECT_ID: metiss-dev
```

**SAFE** ✅
```yaml
DATABASE_URL: postgresql://[DB_USER]:[DB_PASSWORD]@[DB_IP]:5432/[DB_NAME]
GOOGLE_API_KEY: [YOUR_GOOGLE_API_KEY]
FIREBASE_PROJECT_ID: [YOUR_FIREBASE_PROJECT_ID]
```

---

## 📚 Documentation Guidelines

### When Writing Examples:

1. **Never include actual values**
   - ❌ Wrong: `project_id= "metiss-dev"`
   - ✅ Right: `project_id= "[YOUR_PROJECT_ID]"`

2. **Replace URLs with placeholders**
   - ❌ Wrong: `https://metiss-ai-gateway-6m7odqj.wl.gateway.dev`
   - ✅ Right: `https://[API-GATEWAY-URL]`

3. **Use descriptive placeholders**
   - ❌ Wrong: `key = "xxx"`
   - ✅ Right: `GOOGLE_API_KEY = "[YOUR_GOOGLE_API_KEY]"`

4. **Add security warnings**
   - Always mention where secrets should be stored
   - Add ⚠️ indicators for sensitive operations
   - Include `.gitignore` recommendations

5. **Document the structure, not the values**
   - ✅ Document: "Firebase requires PRIVATE_KEY field"
   - ❌ Don't: Share actual private key

---

## 🔐 .gitignore Essentials

Ensure your `.gitignore` includes:
```
# Terraform
terraform.tfvars
terraform.tfvars.*
*.tfvars
override.tf
override.tf.json
.terraform.lock.hcl
.terraform/*

# GCP
key-*.json
*-key.json
.env
.env.local
.env.*.local

# IDE
.vscode/*
.idea/*
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
*.out
```

---

## 🎓 Team Training Points

### What Each Role Should Know:

#### For All Team Members:
- ✅ Never commit secrets to Git
- ✅ Use `.gitignore` properly
- ✅ Report suspected exposures immediately
- ✅ Use placeholders in documentation

#### For DevOps Engineers:
- ✅ How to rotate credentials safely
- ✅ How to use secret management systems
- ✅ How to audit access logs
- ✅ How to handle key compromise

#### For Developers:
- ✅ How to load secrets from environment variables
- ✅ How to use local `.env.local` files
- ✅ How to never log sensitive data
- ✅ How to report security concerns

#### For Architects/Leads:
- ✅ How to design secure secret management
- ✅ How to implement principle of least privilege
- ✅ How to audit configurations
- ✅ How to establish security culture

---

## 🚨 If a Secret Is Accidentally Exposed

### Immediate Actions:
1. **DO NOT PANIC** - Act quickly but methodically
2. **STOP** sharing the exposed material immediately
3. **ALERT** your security team
4. **DOCUMENT** what was exposed (don't repeat it)
5. **REVOKE** compromised credentials immediately
6. **ROTATE** all related credentials
7. **MONITOR** for unauthorized access
8. **INVESTIGATE** how it happened
9. **PREVENT** future exposure (update processes)

### Revocation Steps:
```bash
# For GCP API Keys
gcloud services api-keys list
gcloud services api-keys delete [KEY_ID]

# For Service Account Keys
gcloud iam service-accounts keys list --iam-account=[EMAIL]
gcloud iam service-accounts keys delete [KEY_ID] --iam-account=[EMAIL]

# For Database Passwords
# Change via Cloud SQL console or:
gcloud sql users set-password [USER] --instance=[INSTANCE] --password=[NEW_PASSWORD]

# For API Keys and tokens
# Regenerate through respective provider consoles
```

---

## 🔍 Auditing Checklist

### Regular Security Audits:

**Weekly**:
- [ ] Review recent Git commits for exposed secrets
- [ ] Check for new `.gitignore` violations
- [ ] Verify no sensitive data in logs

**Monthly**:
- [ ] Audit IAM permissions
- [ ] Review service account usage
- [ ] Check for unused API keys
- [ ] Verify credential rotation status

**Quarterly**:
- [ ] Full security review of documentation
- [ ] Assessment of secret management practices
- [ ] Team security training refresher
- [ ] Penetration testing (if applicable)

### Tools to Help:

```bash
# Detect committed secrets in Git history
git log -S 'password' --oneline

# Scan for common secret patterns
grep -r 'PRIVATE_KEY' . --include='*.tf'
grep -r 'BEGIN.*KEY' . --include='*.json'

# Check .gitignore effectiveness
git status --ignored

# Use secret detection tools:
# - git-secrets
# - truffleHog
# - detect-secrets
```

---

## 📞 Incident Response

### Report Security Issues To:
- **Immediate**: [SECURITY_CONTACT_EMAIL]
- **Emergency**: [EMERGENCY_NUMBER]
- **Anonymous**: [SECURITY_HOTLINE]

### Include in Report:
- What secret was exposed
- Where it was exposed (document/log/message)
- When it was discovered
- Who has access
- Any suspicious activity

---

## 💡 Best Practices Summary

### DO:
✅ Use placeholders in documentation  
✅ Store secrets in `terraform.tfvars` (git-ignored)  
✅ Use GCP Secret Manager for production  
✅ Rotate credentials regularly  
✅ Audit access logs  
✅ Use service accounts for automation  
✅ Enable MFA for critical accounts  
✅ Document procedures without exposing secrets  

### DON'T:
❌ Commit secrets to Git  
❌ Share credentials via email/Slack  
❌ Include secrets in logs  
❌ Use personal credentials for automation  
❌ Hardcode secrets in code  
❌ Share actual API keys in examples  
❌ Expose database credentials  
❌ Include URLs with credentials  

---

## 🎯 KT Session Security Reminders

### For Presenters:
1. ⚠️ Review all slides/docs before session
2. ⚠️ Use presenter mode to avoid accidental screen sharing
3. ⚠️ Have sanitized examples ready
4. ⚠️ Know which questions need private answers
5. ⚠️ Never demo with real credentials

### For Attendees:
1. ⚠️ Don't screenshot sensitive information
2. ⚠️ Don't record sessions with exposed data
3. ⚠️ Don't share access to live environments
4. ⚠️ Ask presenter for clarifications on secrets
5. ⚠️ Report any exposed information immediately

---

## 📖 Reference

### Security Resources:
- [OWASP Secrets Management](https://owasp.org/)
- [GCP Secret Manager](https://cloud.google.com/secret-manager)
- [Terraform Sensitive Data](https://www.terraform.io/docs/language/state/sensitive-data.html)
- [Git Security Best Practices](https://git-scm.com/book/en/v2)

### Useful Commands:
```bash
# Find potential secrets in code
grep -r "password\|secret\|key\|token" . --include="*.tf" | grep -v "^Binary"

# Check what would be committed
git diff --cached --name-only

# Verify gitignore works
git check-ignore -v *.tfvars

# Show ignored files
git status --ignored
```

---

## ✋ Sign-off

By participating in this KT session, you acknowledge:
- ✅ Understanding the security requirements
- ✅ Commitment to protecting secrets
- ✅ Responsibility to report issues
- ✅ Agreeing to follow these guidelines

---

**Last Updated**: 2026-06-17  
**Version**: 1.0  
**Status**: Active  
**Approved By**: Security Team
