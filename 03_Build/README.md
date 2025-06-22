# 03_Build

## 📖 Overview

This module demonstrates building and provisioning AWS infrastructure using Terraform. It focuses on creating an EC2 instance from scratch, showcasing the complete Terraform workflow from configuration to deployment. This example serves as a foundation for understanding how to build cloud infrastructure programmatically.

## 🎯 Learning Objectives

By completing this module, you will learn:

- **Infrastructure Building**: Creating AWS resources from Terraform configuration
- **EC2 Instance Management**: Provisioning and configuring virtual machines
- **Resource Configuration**: Setting AMI, instance type, and tagging strategies
- **AWS Provider Usage**: Working with AWS services through Terraform
- **Build Process**: Complete workflow from init to apply
- **Resource Lifecycle**: Understanding creation, modification, and destruction

## 🏗️ Infrastructure Components

This module creates the following AWS resources:

| Resource Type | Name | Description | Configuration |
|---------------|------|-------------|---------------|
| `aws_instance` | `app_server` | EC2 instance for application hosting | t2.micro, tagged as "ExampleAppServerInstance" |

### Architecture Diagram

```
┌─────────────────────────────────────────────────────────┐
│                    AWS Cloud                            │
│                   Region: us-west-2                     │
│                                                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │                   VPC                           │    │
│  │              (Default VPC)                      │    │
│  │                                                 │    │
│  │    ┌─────────────────────────────────────┐      │    │
│  │    │         Availability Zone           │      │    │
│  │    │                                     │      │    │
│  │    │  ┌─────────────────────────────┐    │      │    │
│  │    │  │      EC2 Instance           │    │      │    │
│  │    │  │                             │    │      │    │
│  │    │  │  AMI: ami-830c94e3          │    │      │    │
│  │    │  │  Type: t2.micro             │    │      │    │
│  │    │  │  Name: ExampleAppServer...  │    │      │    │
│  │    │  │                             │    │      │    │
│  │    │  └─────────────────────────────┘    │      │    │
│  │    │                                     │      │    │
│  │    └─────────────────────────────────────┘      │    │
│  │                                                 │    │
│  └─────────────────────────────────────────────────┘    │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## 📋 Prerequisites

Before running this module, ensure you have:

- **Terraform** installed (>= 1.2.0)
- **AWS CLI** configured with valid credentials
- **AWS Account** with EC2 permissions
- **Valid AWS AMI ID** for your target region

### AWS Permissions Required

Your AWS credentials need the following permissions:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:RunInstances",
                "ec2:TerminateInstances",
                "ec2:DescribeInstances",
                "ec2:DescribeImages",
                "ec2:DescribeInstanceAttribute",
                "ec2:DescribeInstanceStatus",
                "ec2:CreateTags",
                "ec2:DescribeTags"
            ],
            "Resource": "*"
        }
    ]
}
```

### Verify Prerequisites

```bash
# Check Terraform version
terraform version

# Verify AWS CLI configuration
aws configure list

# Test AWS connectivity and permissions
aws sts get-caller-identity

# Check if AMI exists in target region
aws ec2 describe-images --image-ids ami-830c94e3 --region us-west-2
```

## 🚀 Quick Start

### 1. Navigate to Module Directory

```bash
cd 03_Build
```

### 2. Configure AWS Credentials

```bash
# Option 1: AWS CLI
aws configure

# Option 2: Environment Variables
set AWS_ACCESS_KEY_ID=your-access-key
set AWS_SECRET_ACCESS_KEY=your-secret-key
set AWS_DEFAULT_REGION=us-west-2

# Option 3: AWS Profile
set AWS_PROFILE=your-profile
```

### 3. Update AMI ID (Recommended)

The current AMI ID (`ami-830c94e3`) may be outdated. Find a current Amazon Linux 2 AMI:

```bash
# Find latest Amazon Linux 2 AMI
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" --query "Images[*].[ImageId,CreationDate,Description]" --output table --region us-west-2
```

Update `main.tf` with a current AMI ID before proceeding.

### 4. Initialize Terraform

```bash
terraform init
```

**Expected Output:**
```
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/aws versions matching "6.0.0"...
- Installing hashicorp/aws v6.0.0...

Terraform has been successfully initialized!
```

### 5. Validate Configuration

```bash
terraform validate
```

### 6. Review the Execution Plan

```bash
terraform plan
```

**Expected Output:**
```
Terraform will perform the following actions:

  # aws_instance.app_server will be created
  + resource "aws_instance" "app_server" {
      + ami                                  = "ami-830c94e3"
      + instance_type                        = "t2.micro"
      + tags                                 = {
          + "Name" = "ExampleAppServerInstance"
        }
      # ... additional computed attributes
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

### 7. Apply the Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### 8. Verify the Instance

```bash
# List EC2 instances
aws ec2 describe-instances --filters "Name=tag:Name,Values=ExampleAppServerInstance" --region us-west-2

# Get instance details from Terraform
terraform show
```

### 9. Clean Up Resources

```bash
terraform destroy
```

## 📁 File Structure

```
03_Build/
├── main.tf               # Main configuration file
├── .terraform.lock.hcl   # Provider dependency lock file
├── .terraform/           # Provider plugins (auto-generated)
├── terraform.tfstate     # State file (auto-generated)
└── README.md             # This documentation
```

## 🔧 Configuration Breakdown

### Terraform Block

```hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
  }
  required_version = ">= 1.2.0"
}
```

**Key Points:**
- **Provider Version**: Pinned to exact version 6.0.0 for consistency
- **Terraform Version**: Requires minimum 1.2.0 for modern features
- **Provider Source**: Explicitly defined for security and clarity

### Provider Configuration

```hcl
provider "aws" {
  region = "us-west-2"
}
```

**Configuration Details:**
- **Region**: Oregon (us-west-2) - cost-effective region
- **Credentials**: Inherited from AWS CLI or environment variables
- **Default VPC**: Uses default VPC and security group

### EC2 Instance Resource

```hcl
resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  
  tags = {
    Name = "ExampleAppServerInstance"
  }
}
```

**Resource Properties:**
- **AMI**: Amazon Machine Image ID (⚠️ may need updating)
- **Instance Type**: t2.micro (free tier eligible)
- **Tags**: Name tag for easy identification in AWS console

## 🔍 Understanding AWS EC2 Concepts

### AMI (Amazon Machine Image)

AMIs are pre-configured templates containing:
- **Operating System** (Amazon Linux, Ubuntu, Windows, etc.)
- **Software Packages** (web servers, databases, etc.)
- **Configuration Settings** (users, permissions, etc.)

### Instance Types

| Type | vCPUs | Memory | Network | Use Case |
|------|-------|--------|---------|----------|
| t2.nano | 1 | 0.5 GB | Low | Testing |
| t2.micro | 1 | 1 GB | Low | Development |
| t2.small | 1 | 2 GB | Low | Small apps |
| t3.medium | 2 | 4 GB | Moderate | Production |

### Resource Tags

Tags provide metadata for:
- **Organization** (Environment, Project, Team)
- **Cost Tracking** (Department, Cost Center)
- **Automation** (Backup, Monitoring)
- **Compliance** (Owner, Data Classification)

## 🛠️ Common Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `terraform init` | Initialize working directory | `terraform init` |
| `terraform validate` | Validate configuration syntax | `terraform validate` |
| `terraform fmt` | Format configuration files | `terraform fmt` |
| `terraform plan` | Preview changes | `terraform plan` |
| `terraform apply` | Create/update resources | `terraform apply` |
| `terraform show` | Display current state | `terraform show` |
| `terraform destroy` | Remove all resources | `terraform destroy` |

## 🔧 Troubleshooting

### Common Issues and Solutions

#### 1. **Invalid AMI ID**

**Error:** `InvalidAMIID.NotFound: The image id '[ami-830c94e3]' does not exist`

**Solutions:**
```bash
# Find current Amazon Linux 2 AMI
aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" \
  --query "Images | sort_by(@, &CreationDate) | [-1].ImageId" \
  --region us-west-2

# Common current AMIs (verify before use):
# Amazon Linux 2: ami-0c02fb55956c7d316
# Ubuntu 20.04: ami-0892d3c7ee96c0bf7
# Ubuntu 22.04: ami-0fcf52bcf5db7b003
```

#### 2. **Authentication Errors**

**Error:** `NoCredentialsError: Unable to locate credentials`

**Solutions:**
```bash
# Check AWS configuration
aws configure list

# Set credentials via environment
set AWS_ACCESS_KEY_ID=your-key
set AWS_SECRET_ACCESS_KEY=your-secret

# Use specific profile
set AWS_PROFILE=your-profile

# Test authentication
aws sts get-caller-identity
```

#### 3. **Permission Denied**

**Error:** `UnauthorizedOperation: You are not authorized to perform this operation`

**Solutions:**
```bash
# Check current user permissions
aws iam get-user

# Verify required permissions exist
aws iam list-attached-user-policies --user-name your-username

# Contact AWS administrator for EC2 permissions
```

#### 4. **Region Mismatch**

**Error:** `AMI not available in specified region`

**Solutions:**
```bash
# Check AMI availability in your region
aws ec2 describe-images --image-ids ami-830c94e3 --region us-west-2

# Find AMIs in specific region
aws ec2 describe-images --owners amazon --region us-west-2 --filters "Name=name,Values=amzn2-ami-hvm-*"
```

### Debugging Commands

```bash
# Enable debug logging
set TF_LOG=DEBUG
set TF_LOG_PATH=terraform.log

# Validate configuration
terraform validate

# Check provider requirements
terraform providers

# Show detailed state
terraform show -json | jq '.'

# Get specific resource information
terraform state show aws_instance.app_server
```

## 🎓 Enhancement Ideas

### 1. **Add Security Group**

```hcl
resource "aws_security_group" "app_sg" {
  name_prefix = "app-server-"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  
  tags = {
    Name = "ExampleAppServerInstance"
  }
}
```

### 2. **Add Key Pair for SSH**

```hcl
resource "aws_key_pair" "app_key" {
  key_name   = "app-server-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.app_key.key_name
  
  tags = {
    Name = "ExampleAppServerInstance"
  }
}
```

### 3. **Add User Data Script**

```hcl
resource "aws_instance" "app_server" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello from Terraform</h1>" > /var/www/html/index.html
  EOF
  
  tags = {
    Name = "ExampleAppServerInstance"
  }
}
```

## 💡 Best Practices

### 🔒 **Security**
- **Use specific AMI IDs** rather than `latest` tags
- **Implement least-privilege** security groups
- **Enable instance metadata service v2** (IMDSv2)
- **Use AWS Systems Manager** for secure access

### 💰 **Cost Optimization**
- **Use t2.micro** for development (free tier eligible)
- **Stop instances** when not in use
- **Set up billing alerts** for cost monitoring
- **Use spot instances** for non-critical workloads

### 🏗️ **Infrastructure Management**
- **Tag all resources** consistently
- **Use data sources** for dynamic AMI lookup
- **Implement proper naming conventions**
- **Version control** all Terraform code

### 📊 **Monitoring**
- **Enable CloudWatch** monitoring
- **Set up log aggregation**
- **Configure health checks**
- **Implement alerting** for critical metrics

## 📚 Additional Resources

### AWS Documentation
- [EC2 User Guide](https://docs.aws.amazon.com/ec2/)
- [AMI Management](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html)
- [Instance Types](https://aws.amazon.com/ec2/instance-types/)
- [Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)

### Terraform AWS Provider
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [aws_instance Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [AWS Provider Configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)

### Best Practices
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [AWS Security Best Practices](https://aws.amazon.com/architecture/security-identity-compliance/)

## 🎯 Next Steps

After completing this module, consider:

1. **Add networking components** (VPC, subnets, security groups)
2. **Implement auto-scaling** for high availability
3. **Add load balancing** for traffic distribution
4. **Set up monitoring and logging**
5. **Create reusable modules** for common patterns
6. **Implement CI/CD pipelines** for automated deployments

## 💡 Pro Tips

1. **Always validate AMI IDs** before applying
2. **Use data sources** to dynamically fetch AMI IDs
3. **Tag resources consistently** for better organization
4. **Test in dev environment** before production deployment
5. **Keep state files secure** and use remote backends
6. **Document infrastructure decisions** for team collaboration

---

**Happy Building!** 🎉

*This module is part of the Terraform Associate 003 learning project.*