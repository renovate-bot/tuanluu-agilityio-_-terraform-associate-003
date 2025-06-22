# 04_Change

## 📖 Overview

This module demonstrates how to modify and update existing infrastructure using Terraform. It focuses on the change management capabilities of Terraform, showing how infrastructure can be modified, updated, and evolved over time while maintaining state consistency and minimizing downtime.

## 🎯 Learning Objectives

By completing this module, you will learn:

- **Change Management**: Understanding how Terraform handles infrastructure modifications
- **State Comparison**: How Terraform compares current state with desired configuration
- **Update Strategies**: Different approaches to updating running infrastructure
- **Plan Analysis**: Reading and interpreting Terraform execution plans
- **Rolling Updates**: Managing changes without service interruption
- **Rollback Procedures**: Reverting changes when needed
- **Change Impact**: Understanding the effects of different types of modifications

## 🏗️ Infrastructure Components

This module starts with a basic EC2 instance and demonstrates various types of changes:

| Resource Type | Name | Description | Changeable Attributes |
|---------------|------|-------------|----------------------|
| `aws_instance` | `app_server` | EC2 instance for demonstrating changes | AMI, instance type, tags, security groups |

### Change Types Demonstrated

```
┌─────────────────────────────────────────────────────────┐
│                   Change Categories                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  🔄 In-Place Updates                                   │
│  ├─ Tags modification                                   │
│  ├─ Security group changes                              │
│  └─ User data updates                                   │
│                                                         │
│  🔄 Replacement Updates                                │
│  ├─ AMI changes (new image)                             │
│  ├─ Instance type changes                               │
│  └─ Availability zone changes                           │
│                                                         │
│  🔄 Additive Changes                                   │
│  ├─ Additional resources                                │
│  ├─ New tags                                            │
│  └─ Additional security groups                          │
│                                                         │
│  🔄 Destructive Changes                                │
│  ├─ Resource removal                                    │
│  ├─ Critical attribute changes                          │
│  └─ Dependency modifications                            │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## 📋 Prerequisites

Before running this module, ensure you have:

- **Terraform** installed (>= 1.2.0)
- **AWS CLI** configured with valid credentials
- **Basic understanding** of Terraform fundamentals
- **Existing infrastructure** to modify (or start from scratch)

### Verify Prerequisites

```bash
# Check Terraform version
terraform version

# Verify AWS CLI configuration
aws configure list

# Test AWS connectivity
aws sts get-caller-identity
```

## 🚀 Change Demonstration Workflow

### Phase 1: Initial Deployment

```bash
# Navigate to the module
cd 04_Change

# Initialize Terraform
terraform init

# Review initial plan
terraform plan

# Deploy initial infrastructure
terraform apply
```

### Phase 2: Tag Modification (In-Place Update)

Modify the tags in `main.tf`:

```hcl
resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  tags = {
    Name        = "ExampleAppServerInstance"
    Environment = "Development"        # Add this
    Project     = "TerraformLearning"  # Add this
  }
}
```

```bash
# See the planned changes
terraform plan

# Apply the tag changes
terraform apply
```

### Phase 3: Instance Type Change (Replacement Update)

Modify the instance type in `main.tf`:

```hcl
resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.small"  # Changed from t2.micro

  tags = {
    Name        = "ExampleAppServerInstance"
    Environment = "Development"
    Project     = "TerraformLearning"
  }
}
```

```bash
# Review the replacement plan
terraform plan

# Apply the instance type change
terraform apply
```

### Phase 4: AMI Update (Replacement Update)

Update to a newer AMI:

```bash
# Find latest Amazon Linux 2 AMI
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" --query "Images | sort_by(@, &CreationDate) | [-1].ImageId" --region us-west-2
```

Update `main.tf` with new AMI:

```hcl
resource "aws_instance" "app_server" {
  ami           = "ami-0c02fb55956c7d316"  # New AMI ID
  instance_type = "t2.small"

  tags = {
    Name        = "ExampleAppServerInstance"
    Environment = "Development"
    Project     = "TerraformLearning"
  }
}
```

```bash
# Review the AMI change plan
terraform plan

# Apply the AMI update
terraform apply
```

## 🔄 Understanding Change Types

### 1. **In-Place Updates** ✅

Changes that can be applied without recreating the resource:

```hcl
# These changes are applied in-place:
tags = {
  Name = "UpdatedName"           # ✅ In-place
  NewTag = "NewValue"            # ✅ In-place
}

# Security group modifications (some)
vpc_security_group_ids = [sg-123, sg-456]  # ✅ In-place
```

**Characteristics:**
- No downtime
- Minimal disruption
- Fast application
- State preserved

### 2. **Replacement Updates** ⚠️

Changes that require resource recreation:

```hcl
# These changes require replacement:
ami           = "ami-new123456"     # ⚠️ Replacement
instance_type = "t3.medium"        # ⚠️ Replacement
availability_zone = "us-west-2b"   # ⚠️ Replacement
```

**Characteristics:**
- Temporary downtime
- Data loss risk
- Longer application time
- New resource created

### 3. **Additive Changes** ➕

Changes that add new resources or attributes:

```hcl
# Adding new resources
resource "aws_security_group" "new_sg" {
  # New resource
}

# Adding new tags
tags = {
  ExistingTag = "value"
  NewTag = "newvalue"    # ➕ Addition
}
```

**Characteristics:**
- No downtime
- Safe operation
- Incremental growth
- Reversible

### 4. **Destructive Changes** ❌

Changes that remove resources or critical attributes:

```hcl
# Removing resources (commenting out)
# resource "aws_instance" "old_server" {
#   # This resource will be destroyed
# }

# Removing tags
tags = {
  # RemovedTag = "value"  # ❌ Destruction
  KeptTag = "value"
}
```

**Characteristics:**
- Potential data loss
- Irreversible operation
- Requires careful planning
- May break dependencies

## 🔍 Reading Terraform Plans

### Plan Symbols and Meanings

```bash
# Plan output symbols:
  + create      # New resource will be created
  - destroy     # Resource will be destroyed
  ~ update      # Resource will be updated in-place
  +/- replace   # Resource will be destroyed and recreated
  
# Example plan output:
# aws_instance.app_server will be updated in-place
  ~ resource "aws_instance" "app_server" {
      ~ tags = {
          + "Environment" = "Development"
          + "Project"     = "TerraformLearning"
            # (1 unchanged attribute hidden)
        }
        # (8 unchanged attributes hidden)
    }
```

### Plan Analysis Checklist

Before applying changes, always check:

- [ ] **Resource Count**: How many resources will be affected?
- [ ] **Change Type**: In-place, replacement, or destruction?
- [ ] **Dependencies**: Will changes affect other resources?
- [ ] **Data Impact**: Could data be lost during replacement?
- [ ] **Downtime**: Will there be service interruption?
- [ ] **Rollback Plan**: How to revert if needed?

## 🛠️ Change Management Commands

| Command | Purpose | Use Case |
|---------|---------|----------|
| `terraform plan` | Preview changes | Before any modification |
| `terraform plan -out=planfile` | Save plan to file | For review and approval |
| `terraform apply planfile` | Apply saved plan | Controlled execution |
| `terraform refresh` | Update state from real resources | State drift detection |
| `terraform show` | Display current state | Current configuration review |
| `terraform state list` | List resources in state | Resource inventory |

### Advanced Change Commands

```bash
# Target specific resources
terraform plan -target=aws_instance.app_server

# Apply only specific changes
terraform apply -target=aws_instance.app_server

# Refresh state before planning
terraform refresh && terraform plan

# Show what would be destroyed
terraform plan -destroy

# Force replacement of specific resource
terraform apply -replace=aws_instance.app_server
```

## 🔧 Practical Change Scenarios

### Scenario 1: Emergency Tag Update

```bash
# Quick tag update for compliance
terraform plan -var="environment=production"
terraform apply -auto-approve
```

### Scenario 2: Staged Instance Type Upgrade

```bash
# Step 1: Plan the change
terraform plan -out=upgrade.plan

# Step 2: Review with team
terraform show upgrade.plan

# Step 3: Apply during maintenance window
terraform apply upgrade.plan
```

### Scenario 3: Rollback After Failed Update

```bash
# Revert to previous configuration
git checkout HEAD~1 -- main.tf

# Apply the rollback
terraform plan
terraform apply
```

### Scenario 4: Blue-Green Deployment Simulation

```bash
# Create new instance alongside existing
# (Modify main.tf to add second instance)
terraform apply

# Verify new instance works
# Switch traffic to new instance
# Remove old instance
terraform apply
```

## 🔧 Troubleshooting Changes

### Common Change Issues

#### 1. **State Drift**

**Problem:** Real infrastructure doesn't match Terraform state

**Solution:**
```bash
# Detect drift
terraform plan -refresh-only

# Fix drift
terraform apply -refresh-only

# Or refresh and plan
terraform refresh
terraform plan
```

#### 2. **Resource Dependencies**

**Problem:** Cannot change resource due to dependencies

**Solution:**
```bash
# Identify dependencies
terraform graph | dot -Tpng > graph.png

# Force dependency resolution
terraform apply -replace=aws_security_group.example
```

#### 3. **Failed Partial Apply**

**Problem:** Apply failed halfway through

**Solution:**
```bash
# Check current state
terraform show

# Plan to see what's needed
terraform plan

# Apply remaining changes
terraform apply
```

#### 4. **Resource Replacement Failure**

**Problem:** New resource creation fails during replacement

**Solution:**
```bash
# Use create_before_destroy lifecycle
resource "aws_instance" "app_server" {
  # ... configuration ...
  
  lifecycle {
    create_before_destroy = true
  }
}
```

## 🎓 Advanced Change Management

### Lifecycle Rules

```hcl
resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  lifecycle {
    # Prevent accidental destruction
    prevent_destroy = true
    
    # Create new before destroying old
    create_before_destroy = true
    
    # Ignore changes to specific attributes
    ignore_changes = [
      ami,
      user_data,
    ]
  }

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
```

### Data Sources for Dynamic Changes

```hcl
# Always use latest AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  
  tags = {
    Name = "ExampleAppServerInstance"
  }
}
```

### Conditional Changes

```hcl
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}

resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = var.environment == "production" ? "t3.medium" : "t2.micro"

  tags = {
    Name        = "ExampleAppServerInstance"
    Environment = var.environment
  }
}
```

## 💡 Best Practices for Change Management

### 🔒 **Planning Phase**
- **Always run** `terraform plan` before applying
- **Save plans** to files for review: `terraform plan -out=plan.out`
- **Review changes** with team members
- **Test changes** in non-production environments first

### 🚀 **Execution Phase**
- **Apply during maintenance windows** for disruptive changes
- **Use targeted applies** for specific resources when needed
- **Monitor logs** during application
- **Have rollback plan** ready

### 🛡️ **Safety Measures**
- **Use lifecycle rules** to prevent accidental destruction
- **Implement proper tagging** for resource identification
- **Maintain backup strategies** for critical resources
- **Use remote state** with locking for team collaboration

### 📊 **Change Tracking**
- **Document all changes** in version control
- **Use descriptive commit messages**
- **Tag releases** for major changes
- **Maintain change logs** for audit trails

## 📚 Additional Resources

### Terraform Change Management
- [Terraform Apply](https://www.terraform.io/docs/cli/commands/apply.html)
- [Terraform Plan](https://www.terraform.io/docs/cli/commands/plan.html)
- [Resource Lifecycle](https://www.terraform.io/docs/language/meta-arguments/lifecycle.html)

### AWS Instance Management
- [EC2 Instance Lifecycle](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-lifecycle.html)
- [AMI Management](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html)
- [Instance Types](https://aws.amazon.com/ec2/instance-types/)

### Change Management Best Practices
- [Infrastructure as Code Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [GitOps Principles](https://www.gitops.tech/)

## 🎯 Next Steps

After completing this module, consider:

1. **Implement automated testing** for infrastructure changes
2. **Set up CI/CD pipelines** for controlled deployments
3. **Create change approval workflows**
4. **Explore advanced lifecycle management**
5. **Implement monitoring and alerting** for changes
6. **Practice disaster recovery** scenarios

## 💡 Pro Tips

1. **Always plan before applying** - it's free and prevents mistakes
2. **Use version control** for all infrastructure code
3. **Test changes** in development environments first
4. **Keep backups** of critical resources
5. **Document your changes** for team knowledge sharing
6. **Monitor resources** after changes are applied
7. **Use descriptive names** and tags for better organization

---

**Happy Changing!** 🔄

*This module is part of the Terraform Associate 003 learning project.*