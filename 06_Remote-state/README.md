# 06_Remote-state

## 📖 Overview

This module demonstrates remote state management using Terraform Cloud (HCP Terraform). It showcases how to move from local state files to remote state storage, enabling team collaboration, state locking, and centralized state management. This is a crucial step for production Terraform deployments and team-based infrastructure management.

## 🎯 Learning Objectives

By completing this module, you will learn:

- **Remote State Concepts**: Understanding why remote state is essential
- **Terraform Cloud Integration**: Setting up and configuring HCP Terraform
- **State Migration**: Moving from local to remote state
- **Team Collaboration**: Sharing state across team members
- **State Locking**: Preventing concurrent modifications
- **Workspace Management**: Organizing environments with workspaces
- **Security Benefits**: Protecting sensitive state data
- **Version Control**: State versioning and rollback capabilities

## 🏗️ Infrastructure Components

This module creates the same basic infrastructure as previous modules but demonstrates remote state management:

| Resource Type | Name | Description | State Storage |
|---------------|------|-------------|---------------|
| `aws_instance` | `app_server` | EC2 instance for demonstrating remote state | Terraform Cloud |

### Remote State Architecture

```
┌─────────────────────────────────────────────────────────┐
│                 Terraform Cloud                         │
│                  (HCP Terraform)                        │
│                                                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │            Organization: tuanluuvn              │    │
│  │                                                 │    │
│  │  ┌─────────────────────────────────────────┐    │   │
│  │  │    Workspace: terraform-hcp-workspace   │    │   │
│  │  │                                         │    │   │
│  │  │  📁 Remote State Storage                │    │   │
│  │  │  🔒 State Locking                       │    │   │
│  │  │  📊 State Versioning                    │   │   │
│  │  │  👥 Team Access Control                 │   │   │
│  │  │  🔐 Sensitive Data Encryption          │    │   │
│  │  │                                         │    │   │
│  │  └─────────────────────────────────────────┘    │   │
│  │                                                 │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
└─────────────────────────────────────────────────────────┘
                              │
                              │ API Calls
                              │
┌─────────────────────────────────────────────────────────┐
│                 Local Development                       │
│                                                         │
│  💻 Developer Machine                                  │
│  ├─ terraform init                                      │
│  ├─ terraform plan                                      │
│  ├─ terraform apply                                     │
│  └─ No local .tfstate file                             │
│                                                         │
└─────────────────────────────────────────────────────────┘
                              │
                              │ Provisions
                              │
┌─────────────────────────────────────────────────────────┐
│                    AWS Cloud                           │
│                                                         │
│  🖥️ EC2 Instance (app_server)                         │
│  ├─ AMI: ami-08d70e59c07c61a3a                         │
│  ├─ Type: t2.micro                                      │
│  └─ Region: us-west-2                                   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## 📋 Prerequisites

Before running this module, ensure you have:

- **Terraform** installed (>= 1.2.0)
- **Terraform Cloud Account** (free tier available)
- **AWS CLI** configured with valid credentials
- **Git** for version control (optional but recommended)

### Terraform Cloud Setup

1. **Create Terraform Cloud Account**:
   - Visit [https://app.terraform.io/signup](https://app.terraform.io/signup)
   - Create a free account
   - Verify your email address

2. **Create Organization**:
   - Create or join an organization (e.g., "tuanluuvn")
   - Note your organization name for configuration

3. **Create Workspace**:
   - Create a new workspace
   - Choose "CLI-driven workflow"
   - Name it "terraform-hcp-workspace" (or update main.tf)

4. **Generate API Token**:
   - Go to User Settings → Tokens
   - Create new API token
   - Save the token securely

### Verify Prerequisites

```bash
# Check Terraform version
terraform version

# Check AWS CLI configuration
aws configure list

# Login to Terraform Cloud
terraform login
```

## 🚀 Quick Start

### Step 1: Navigate to Module Directory

```bash
cd 06_Remote-state
```

### Step 2: Configure Terraform Cloud

Update `main.tf` with your organization details if different:

```hcl
terraform {
  cloud {
    organization = "your-organization-name"  # Update this

    workspaces {
      name = "your-workspace-name"           # Update this
    }
  }
  # ... rest of configuration
}
```

### Step 3: Authenticate with Terraform Cloud

```bash
# Login to Terraform Cloud
terraform login

# Follow the prompts to enter your API token
```

### Step 4: Initialize with Remote Backend

```bash
terraform init
```

**Expected Output:**
```
Initializing Terraform Cloud...
Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 4.16"...

Terraform Cloud has been successfully initialized!
```

### Step 5: Configure AWS Credentials in Terraform Cloud

**Method 1: Environment Variables in Workspace**
1. Go to your Terraform Cloud workspace
2. Navigate to Variables tab
3. Add environment variables:
   - `AWS_ACCESS_KEY_ID` (sensitive)
   - `AWS_SECRET_ACCESS_KEY` (sensitive)
   - `AWS_DEFAULT_REGION` = `us-west-2`

**Method 2: Using AWS CLI Profile (Local)**
```bash
# Ensure AWS credentials are configured locally
aws configure list
```

### Step 6: Plan and Apply

```bash
# Create execution plan
terraform plan

# Apply the configuration
terraform apply
```

### Step 7: Verify Remote State

```bash
# Check that no local state file exists
ls -la terraform.tfstate*  # Should show no files

# View state in Terraform Cloud
# Go to your workspace → States → View current state
```

## 🔄 State Migration Scenarios

### Scenario 1: Migrate from Local State

If you have existing local state to migrate:

```bash
# Backup existing state
cp terraform.tfstate terraform.tfstate.backup

# Configure remote backend in main.tf
# Run init to migrate
terraform init

# Terraform will prompt to migrate state
# Type 'yes' to confirm migration

# Verify migration
terraform state list
```

### Scenario 2: Import Existing Resources

If you have existing AWS resources:

```bash
# Import existing EC2 instance
terraform import aws_instance.app_server i-1234567890abcdef0

# Verify import
terraform plan
```

## 🔧 Remote State Configuration Options

### Basic Cloud Configuration

```hcl
terraform {
  cloud {
    organization = "your-org-name"
    
    workspaces {
      name = "production"
    }
  }
}
```

### Advanced Cloud Configuration

```hcl
terraform {
  cloud {
    organization = "your-org-name"
    hostname     = "app.terraform.io"  # Optional: for Terraform Enterprise
    
    workspaces {
      # Option 1: Single workspace
      name = "production"
      
      # Option 2: Multiple workspaces with tags
      # tags = ["production", "aws", "us-west-2"]
    }
  }
}
```

### Alternative: S3 Backend

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "06-remote-state/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-state-locks"
  }
}
```

## 🔍 Understanding Remote State Benefits

### 1. **Team Collaboration** 👥

**Problem with Local State:**
```bash
# Developer A applies changes
terraform apply

# Developer B tries to apply
terraform apply  # ❌ Conflicts with local state
```

**Solution with Remote State:**
```bash
# Both developers share the same remote state
# Developer A
terraform apply  # ✅ Updates remote state

# Developer B  
terraform apply  # ✅ Uses latest remote state
```

### 2. **State Locking** 🔒

**Without State Locking:**
```bash
# Two developers run apply simultaneously
Developer A: terraform apply  # Starts
Developer B: terraform apply  # Also starts - DANGEROUS!
```

**With Remote State Locking:**
```bash
# Terraform Cloud automatically handles locking
Developer A: terraform apply  # Acquires lock
Developer B: terraform apply  # Waits for lock release
```

### 3. **Sensitive Data Protection** 🔐

**Local State Issues:**
- State files contain sensitive data (passwords, keys)
- Files can be accidentally committed to version control
- No encryption at rest

**Remote State Benefits:**
- Encrypted in transit and at rest
- Access control and audit logs
- Never stored in version control

### 4. **State Versioning** 📊

Remote state provides:
- **Version History**: See all state changes over time
- **Rollback Capability**: Restore previous state versions
- **Audit Trail**: Track who made what changes when

## 🛠️ Remote State Management Commands

### Basic Commands

| Command | Purpose | Remote State Behavior |
|---------|---------|----------------------|
| `terraform init` | Initialize remote backend | Downloads remote state |
| `terraform plan` | Create execution plan | Uses remote state for comparison |
| `terraform apply` | Apply changes | Updates remote state |
| `terraform refresh` | Update state from real resources | Updates remote state |
| `terraform state list` | List resources in state | Queries remote state |

### Advanced State Commands

```bash
# Force unlock if lock is stuck
terraform force-unlock LOCK_ID

# Show current state
terraform show

# List all resources
terraform state list

# Show specific resource
terraform state show aws_instance.app_server

# Move resource in state
terraform state mv aws_instance.old aws_instance.new

# Remove resource from state (doesn't destroy)
terraform state rm aws_instance.app_server
```

## 💼 Workspace Management

### Creating Multiple Workspaces

```bash
# List workspaces
terraform workspace list

# Create new workspace
terraform workspace new staging

# Switch workspaces
terraform workspace select production

# Show current workspace
terraform workspace show
```

### Environment-Specific Configuration

```hcl
# Use workspace name for environment-specific resources
locals {
  environment = terraform.workspace
}

resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = local.environment == "production" ? "t3.medium" : "t2.micro"
  
  tags = {
    Name        = "app-server-${local.environment}"
    Environment = local.environment
  }
}
```

## 🔧 Troubleshooting Remote State

### Common Issues and Solutions

#### 1. **Authentication Errors**

**Error:** `Error: No valid credential sources found for Terraform Cloud`

**Solutions:**
```bash
# Re-authenticate with Terraform Cloud
terraform logout
terraform login

# Check credentials file
cat ~/.terraform.d/credentials.tfrc.json

# Set environment variable
export TF_TOKEN_app_terraform_io=your-token-here
```

#### 2. **State Lock Conflicts**

**Error:** `Error acquiring the state lock`

**Solutions:**
```bash
# Check who has the lock in Terraform Cloud UI
# If lock is stuck, force unlock (use carefully)
terraform force-unlock LOCK_ID

# Wait for current operation to complete
```

#### 3. **Workspace Not Found**

**Error:** `workspace "xyz" not found`

**Solutions:**
```bash
# List available workspaces
terraform workspace list

# Create the workspace
terraform workspace new workspace-name

# Update main.tf with correct workspace name
```

#### 4. **State File Conflicts**

**Error:** `State file version conflicts`

**Solutions:**
```bash
# Pull latest state
terraform init

# Force refresh state
terraform refresh

# Check for manual state modifications in UI
```

### Debugging Commands

```bash
# Enable debug logging
export TF_LOG=DEBUG
export TF_LOG_PATH=terraform.log

# Check Terraform Cloud connectivity
terraform login --help

# Validate configuration
terraform validate

# Show detailed plan
terraform plan -detailed-exitcode
```

## 🎓 Advanced Remote State Patterns

### 1. **Multi-Environment Setup**

```hcl
# environments/production/main.tf
terraform {
  cloud {
    organization = "your-org"
    workspaces {
      name = "production"
    }
  }
}

# environments/staging/main.tf
terraform {
  cloud {
    organization = "your-org"
    workspaces {
      name = "staging"
    }
  }
}
```

### 2. **Remote State Data Sources**

```hcl
# Reference another workspace's state
data "terraform_remote_state" "vpc" {
  backend = "remote"
  
  config = {
    organization = "your-org"
    workspaces = {
      name = "vpc-production"
    }
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnet_id
}
```

### 3. **State Encryption with Customer Keys**

```hcl
# For Terraform Enterprise
terraform {
  cloud {
    organization = "your-org"
    workspaces {
      name = "production"
    }
  }
  
  encryption {
    key_provider "pbkdf2" "example" {
      passphrase = var.encryption_passphrase
    }
    
    method "aes_gcm" "example" {
      keys = key_provider.pbkdf2.example
    }
    
    state {
      method = method.aes_gcm.example
    }
  }
}
```

## 💡 Best Practices for Remote State

### 🔒 **Security**
- **Never commit credentials** to version control
- **Use environment variables** for sensitive data in workspaces
- **Enable two-factor authentication** on Terraform Cloud
- **Regularly rotate API tokens**
- **Use least-privilege access** for workspace permissions

### 👥 **Team Collaboration**
- **Use descriptive workspace names** (e.g., "app-production-us-west-2")
- **Document workspace purposes** in workspace descriptions
- **Implement approval workflows** for production workspaces
- **Use consistent tagging** across workspaces

### 🏗️ **State Management**
- **Regularly review state** for drift and inconsistencies
- **Use remote state data sources** to share outputs between workspaces
- **Implement proper workspace organization** (by environment, team, application)
- **Monitor state file sizes** and consider splitting large states

### 📊 **Operations**
- **Set up notifications** for failed runs
- **Use workspace variables** for environment-specific configuration
- **Implement proper backup strategies** (Terraform Cloud handles this automatically)
- **Monitor costs** associated with Terraform Cloud usage

## 📚 Additional Resources

### Terraform Cloud Documentation
- [Terraform Cloud Overview](https://www.terraform.io/cloud)
- [Remote State Management](https://www.terraform.io/docs/language/state/remote.html)
- [Workspaces](https://www.terraform.io/docs/cloud/workspaces/index.html)
- [API Tokens](https://www.terraform.io/docs/cloud/users-teams-organizations/api-tokens.html)

### Alternative Remote Backends
- [S3 Backend](https://www.terraform.io/docs/language/settings/backends/s3.html)
- [Azure Backend](https://www.terraform.io/docs/language/settings/backends/azurerm.html)
- [Google Cloud Backend](https://www.terraform.io/docs/language/settings/backends/gcs.html)

### Security Best Practices
- [Terraform Security Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/part1.html)
- [State File Security](https://www.terraform.io/docs/language/state/sensitive-data.html)
- [Workspace Security](https://www.terraform.io/docs/cloud/workspaces/settings.html#general)

## 🎯 Next Steps

After completing this module, consider:

1. **Set up multiple environments** (dev, staging, production)
2. **Implement workspace-based deployments** with CI/CD
3. **Explore Terraform Cloud features** (policy as code, cost estimation)
4. **Set up notifications and monitoring** for state changes
5. **Create shared modules** with remote state outputs
6. **Implement approval workflows** for critical infrastructure

## 💡 Pro Tips

1. **Always use remote state** for production workloads
2. **Keep workspace names consistent** and descriptive
3. **Use environment variables** for credentials in workspaces
4. **Regular state reviews** help catch configuration drift
5. **Document workspace purposes** for team clarity
6. **Monitor Terraform Cloud costs** if using paid features
7. **Use tags** to organize workspaces by team, environment, or application

---

**Happy Remote State Management!** ☁️

*This module is part of the Terraform Associate 003 learning project.*
