# Contributing to Terraform Associate 003 Learning Project

Thank you for your interest in contributing to our Terraform learning project! This guide will help you understand how to contribute effectively and make the learning experience better for everyone.

## 📋 Table of Contents

- [Getting Started](#getting-started)
- [Types of Contributions](#types-of-contributions)
- [Development Setup](#development-setup)
- [Contribution Workflow](#contribution-workflow)
- [Coding Standards](#coding-standards)
- [Documentation Guidelines](#documentation-guidelines)
- [Testing Requirements](#testing-requirements)
- [Review Process](#review-process)
- [Community Guidelines](#community-guidelines)
- [Recognition](#recognition)

## 🚀 Getting Started

### Prerequisites

Before contributing, ensure you have:

- **Terraform** (>= 1.2.0) installed
- **AWS CLI** configured (for AWS-related modules)
- **Git** for version control
- **GitHub Account** for pull requests
- **Text Editor** with Terraform syntax support (VS Code recommended)

### First-Time Contributors

1. **Read the Code of Conduct**: Familiarize yourself with our [Code of Conduct](CODE_OF_CONDUCT.md)
2. **Explore the Project**: Review existing modules and documentation
3. **Check Issues**: Look for issues labeled `good first issue` or `help wanted`
4. **Join Discussions**: Participate in GitHub Discussions to understand project direction

## 🎯 Types of Contributions

We welcome various types of contributions:

### 📚 **Documentation**
- **README improvements**: Clarify explanations, fix typos, add examples
- **Code comments**: Improve inline documentation
- **Tutorials**: Create step-by-step guides
- **Architecture diagrams**: Visual representations of infrastructure
- **Troubleshooting guides**: Common issues and solutions

### 🔧 **Code Contributions**
- **New modules**: Additional Terraform learning examples
- **Bug fixes**: Resolve issues in existing configurations
- **Security improvements**: Enhance security practices
- **Performance optimizations**: Improve resource efficiency
- **Provider updates**: Keep providers current

### 🧪 **Testing & Validation**
- **Configuration testing**: Validate Terraform configurations
- **Documentation testing**: Ensure examples work as described
- **Cross-platform testing**: Verify compatibility across systems
- **Provider version testing**: Test with different provider versions

### 🎨 **Learning Experience**
- **Interactive examples**: Hands-on learning scenarios
- **Best practices**: Document lessons learned
- **Common pitfalls**: Share mistakes to avoid
- **Advanced patterns**: Complex infrastructure examples

## 🛠️ Development Setup

### 1. Fork and Clone

```bash
# Fork the repository on GitHub
# Clone your fork
git clone https://github.com/YOUR_USERNAME/terraform-associate-003.git
cd terraform-associate-003

# Add upstream remote
git remote add upstream https://github.com/tuanluu-agilityio/terraform-associate-003.git
```

### 2. Environment Setup

```bash
# Verify Terraform installation
terraform version

# Configure AWS CLI (for AWS modules)
aws configure

# Install Terraform extensions for your editor
# VS Code: HashiCorp Terraform extension
```

### 3. Workspace Configuration

```bash
# Create a new branch for your contribution
git checkout -b feature/your-feature-name

# Keep your fork updated
git fetch upstream
git rebase upstream/main
```

## 🔄 Contribution Workflow

### Step 1: Plan Your Contribution

1. **Check existing issues** to avoid duplication
2. **Create an issue** for significant changes to discuss approach
3. **Comment on issues** you plan to work on
4. **Get feedback** before starting large contributions

### Step 2: Make Your Changes

```bash
# Create a new branch
git checkout -b feature/add-networking-module

# Make your changes
# Follow coding standards (see below)

# Test your changes thoroughly
terraform init
terraform validate
terraform plan
```

### Step 3: Commit Your Changes

```bash
# Stage your changes
git add .

# Commit with descriptive message
git commit -m "feat: add VPC networking module with subnets and routing

- Add VPC module with public/private subnets
- Include NAT gateway and internet gateway
- Add comprehensive documentation and examples
- Include troubleshooting section

Closes #123"
```

### Step 4: Submit Pull Request

```bash
# Push to your fork
git push origin feature/add-networking-module

# Create pull request on GitHub
# Fill out the pull request template
# Request review from maintainers
```

## 📝 Coding Standards

### Terraform Configuration Standards

#### 1. **File Organization**

```
module-name/
├── main.tf           # Primary resources
├── variables.tf      # Input variables
├── outputs.tf        # Output values
├── versions.tf       # Provider requirements
├── terraform.tfvars.example  # Example variables
└── README.md         # Module documentation
```

#### 2. **Naming Conventions**

```hcl
# Resource naming: use underscores
resource "aws_instance" "web_server" {
  # Configuration
}

# Variable naming: descriptive and consistent
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# Tag naming: consistent across resources
tags = {
  Name        = "web-server-${var.environment}"
  Environment = var.environment
  Project     = "terraform-learning"
  ManagedBy   = "terraform"
}
```

#### 3. **Code Formatting**

```bash
# Always format your code
terraform fmt -recursive

# Validate syntax
terraform validate

# Use consistent indentation (2 spaces)
# Keep lines under 120 characters
# Use descriptive comments for complex logic
```

#### 4. **Security Best Practices**

```hcl
# ✅ DO: Use variables for sensitive data
variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

# ❌ DON'T: Hardcode secrets
resource "aws_db_instance" "example" {
  password = "hardcoded-password"  # Never do this
}

# ✅ DO: Use data sources for AMIs
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# ❌ DON'T: Use hardcoded AMI IDs
resource "aws_instance" "web" {
  ami = "ami-12345678"  # This will become outdated
}
```

#### 5. **Resource Configuration**

```hcl
# Use lifecycle rules when appropriate
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  
  # Prevent accidental destruction
  lifecycle {
    prevent_destroy = true
  }
  
  # Consistent tagging
  tags = {
    Name        = "${var.project_name}-web-server"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
```

### Documentation Standards

#### 1. **README Structure**

Each module should have a README with:

```markdown
# Module Name

## Overview
Brief description of what the module does

## Learning Objectives
What users will learn

## Prerequisites
Required tools and setup

## Quick Start
Step-by-step usage instructions

## Configuration
Detailed parameter explanations

## Examples
Real-world usage examples

## Troubleshooting
Common issues and solutions

## Resources
Additional learning materials
```

#### 2. **Code Comments**

```hcl
# Create VPC with public and private subnets
# This configuration supports high availability across multiple AZs
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Public subnet for resources that need internet access
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.project_name}-public-${count.index + 1}"
    Type = "public"
  }
}
```

#### 3. **Variable Documentation**

```hcl
variable "instance_type" {
  description = "EC2 instance type for the web server. Choose based on your performance requirements."
  type        = string
  default     = "t2.micro"
  
  validation {
    condition = contains([
      "t2.micro", "t2.small", "t2.medium",
      "t3.micro", "t3.small", "t3.medium"
    ], var.instance_type)
    error_message = "Instance type must be a valid t2 or t3 instance type."
  }
}
```

## 🧪 Testing Requirements

### 1. **Configuration Validation**

All contributions must pass:

```bash
# Format check
terraform fmt -check -recursive

# Validation check
terraform validate

# Plan check (should not error)
terraform plan
```

### 2. **Documentation Testing**

```bash
# Verify all links work
# Test all code examples
# Confirm instructions are accurate
# Check for typos and grammar
```

### 3. **Cross-Platform Testing**

Test on multiple platforms when possible:
- **Windows** (PowerShell, CMD)
- **macOS** (Bash, Zsh)
- **Linux** (Bash)

### 4. **Provider Version Testing**

```hcl
# Test with pinned versions
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

# Test with latest versions
terraform init -upgrade
```

## 👀 Review Process

### Pull Request Requirements

Your PR should include:

- [ ] **Clear description** of changes and motivation
- [ ] **Reference to related issues** (Closes #123)
- [ ] **Documentation updates** for any new features
- [ ] **Testing confirmation** that changes work as expected
- [ ] **Breaking change notes** if applicable

### Review Criteria

Reviewers will check for:

- **Code Quality**: Follows standards and best practices
- **Documentation**: Clear and comprehensive
- **Security**: No hardcoded secrets or insecure practices
- **Learning Value**: Contributes to educational goals
- **Compatibility**: Works across different environments

### Review Timeline

- **Initial Review**: 2-3 business days
- **Follow-up Reviews**: 1-2 business days
- **Final Merge**: After approval from 1-2 maintainers

## 🏷️ Issue and PR Labels

### Issue Labels

- `bug` - Something isn't working
- `documentation` - Improvements or additions to docs
- `enhancement` - New feature or request
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention is needed
- `question` - Further information is requested
- `terraform` - Related to Terraform configuration
- `aws` - Related to AWS provider

### PR Labels

- `ready for review` - PR is ready for maintainer review
- `work in progress` - PR is still being worked on
- `needs changes` - PR requires modifications
- `approved` - PR has been approved

## 🤝 Community Guidelines

### Communication

- **Be respectful** and constructive in all interactions
- **Ask questions** if you're unsure about anything
- **Help others learn** by sharing your knowledge
- **Provide context** when reporting issues or asking questions

### Code of Conduct

All contributors must adhere to our [Code of Conduct](CODE_OF_CONDUCT.md). Key points:

- **Be inclusive** and welcoming to all contributors
- **Be patient** with learners at all levels
- **Give constructive feedback** and accept it gracefully
- **Focus on learning** and helping others grow

## 🎉 Recognition

### Contributors

All contributors are recognized in our:

- **README.md** - Contributors section
- **Release Notes** - Major contributions highlighted
- **GitHub Contributors** - Automatic recognition
- **Special Thanks** - Outstanding contributions noted

### Types of Recognition

- **First-time contributors** - Welcome and encourage
- **Regular contributors** - Acknowledge ongoing support
- **Major contributors** - Special recognition for significant impact
- **Maintainer nominations** - Outstanding contributors may be invited to maintain

## 📞 Getting Help

### Where to Ask Questions

1. **GitHub Discussions** - General questions and ideas
2. **GitHub Issues** - Bug reports and feature requests
3. **Pull Request Comments** - Code-specific questions
4. **Direct Contact** - For sensitive matters: tuan.luu@asnet.com.vn

### What to Include When Asking for Help

- **Clear description** of what you're trying to do
- **Error messages** (full text, not screenshots when possible)
- **Configuration files** that aren't working
- **Steps you've already tried**
- **Your environment** (OS, Terraform version, etc.)

## 📋 Contribution Checklist

Before submitting your contribution:

- [ ] I have read the Code of Conduct
- [ ] I have read these Contributing Guidelines
- [ ] My code follows the project's coding standards
- [ ] I have tested my changes thoroughly
- [ ] I have updated documentation as needed
- [ ] My commit messages are descriptive
- [ ] I have referenced any related issues
- [ ] My changes don't break existing functionality

## 🚀 Quick Start for Contributors

```bash
# 1. Fork and clone
git clone https://github.com/YOUR_USERNAME/terraform-associate-003.git
cd terraform-associate-003

# 2. Create feature branch
git checkout -b feature/your-contribution

# 3. Make changes and test
terraform fmt -recursive
terraform validate

# 4. Commit and push
git add .
git commit -m "feat: describe your changes"
git push origin feature/your-contribution

# 5. Create pull request on GitHub
```

## 📚 Additional Resources

### Terraform Resources
- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [Terraform Style Guide](https://www.terraform.io/docs/language/syntax/style.html)

### AWS Resources
- [AWS Documentation](https://docs.aws.amazon.com/)
- [AWS Provider for Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)

### Git and GitHub
- [Git Handbook](https://guides.github.com/introduction/git-handbook/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Writing Good Commit Messages](https://chris.beams.io/posts/git-commit/)

---

Thank you for contributing to the Terraform Associate 003 Learning Project! Your contributions help make infrastructure learning accessible to everyone. 🎉

**Questions?** Feel free to reach out through GitHub Discussions or create an issue.

*This document is a living guide and may be updated based on community feedback and project evolution.*
