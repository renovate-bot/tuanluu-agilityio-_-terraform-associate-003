# Terraform Associate 003 - Learning Project

This repository contains Terraform configurations and examples for learning Infrastructure as Code (IaC) concepts and preparing for the Terraform Associate certification.

## 📋 Table of Contents

- [About](#about)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Modules](#modules)
- [Usage](#usage)
- [Best Practices](#best-practices)
- [Contributing](#contributing)
- [Resources](#resources)

## 🎯 About

This project demonstrates Infrastructure as Code principles using Terraform. It includes practical examples covering:

- Basic Terraform syntax and configuration
- Provider configuration (Docker, AWS, etc.)
- Resource management
- State management
- Variables and outputs
- Modules and reusability
- Best practices for production environments

## 🔧 Prerequisites

Before you begin, ensure you have the following installed:

- **Terraform** (>= 1.0)
  ```bash
  # Windows (using Chocolatey)
  choco install terraform
  
  # Or download from: https://www.terraform.io/downloads.html
  ```

- **Docker Desktop** (for Docker provider examples)
  ```bash
  # Download from: https://www.docker.com/products/docker-desktop
  ```

- **Git** for version control
- **VS Code** (recommended) with Terraform extension

## 📁 Project Structure

```
terraform-associate-003/
├── 01_Infrastructure-as-Code/    # Basic IaC examples
│   ├── main.tf                   # Main configuration
│   ├── variables.tf              # Input variables
│   ├── outputs.tf                # Output values
│   └── README.md                 # Module-specific documentation
├── .gitignore                    # Git ignore rules for Terraform
├── LICENSE                       # Project license
└── README.md                     # This file
```

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/tuanluu-agilityio/terraform-associate-003.git
cd terraform-associate-003
```

### 2. Navigate to a Module

```bash
cd 01_Infrastructure-as-Code
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Plan Your Infrastructure

```bash
terraform plan
```

### 5. Apply Configuration

```bash
terraform apply
```

### 6. Clean Up Resources

```bash
terraform destroy
```

## 📦 Modules

### 01_Infrastructure-as-Code

**Purpose**: Introduction to basic Terraform concepts using Docker provider

**Resources Created**:
- Docker image (nginx:latest)
- Docker container with port mapping (8000:80)

**Learning Objectives**:
- Understanding Terraform providers
- Basic resource configuration
- Port mapping and container management

**Usage**:
```bash
cd 01_Infrastructure-as-Code
terraform init
terraform plan
terraform apply
```

Access the nginx server at: `http://localhost:8000`

## 💡 Usage Examples

### Basic Commands

```bash
# Initialize working directory
terraform init

# Validate configuration
terraform validate

# Format configuration files
terraform fmt

# Plan changes
terraform plan

# Apply changes
terraform apply

# Show current state
terraform show

# List resources in state
terraform state list

# Destroy infrastructure
terraform destroy
```

### Working with Variables

```bash
# Use variable file
terraform apply -var-file="variables.tfvars"

# Set variables via command line
terraform apply -var="environment=dev"

# Use environment variables
export TF_VAR_environment=dev
terraform apply
```

## ✅ Best Practices

### 1. **State Management**
- Never commit `terraform.tfstate` to version control
- Use remote state for team collaboration
- Enable state locking when possible

### 2. **Code Organization**
- Use meaningful resource names
- Group related resources in modules
- Keep configurations DRY (Don't Repeat Yourself)

### 3. **Security**
- Never hardcode secrets in configurations
- Use variables for sensitive data
- Store `.tfvars` files securely

### 4. **Version Control**
- Use `.gitignore` for Terraform-specific files
- Tag releases for stable configurations
- Use descriptive commit messages

### 5. **Documentation**
- Document module inputs and outputs
- Provide usage examples
- Keep README files updated

## 🔐 Security Considerations

- **Sensitive Data**: Use Terraform variables and external secret management
- **State Files**: Contain sensitive information - secure appropriately
- **Provider Credentials**: Use environment variables or IAM roles
- **Network Security**: Apply principle of least privilege

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Terraform naming conventions
- Run `terraform fmt` before committing
- Add appropriate documentation
- Test configurations before submitting

## 📚 Resources

### Official Documentation
- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [HashiCorp Learn](https://learn.hashicorp.com/terraform)

### Terraform Associate Certification
- [Exam Objectives](https://www.hashicorp.com/certification/terraform-associate)
- [Study Guide](https://learn.hashicorp.com/tutorials/terraform/associate-study)
- [Practice Exams](https://learn.hashicorp.com/tutorials/terraform/associate-questions)

### Community Resources
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [Awesome Terraform](https://github.com/shuaibiyy/awesome-terraform)
- [Terraform Examples](https://github.com/hashicorp/terraform/tree/main/examples)

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

If you have questions or need help:

1. Check the [documentation](#resources)
2. Search existing [issues](https://github.com/tuanluu-agilityio/terraform-associate-003/issues)
3. Create a new issue with detailed information

## 🏷️ Tags

`terraform` `infrastructure-as-code` `iac` `devops` `docker` `automation` `learning` `certification`

---

**Happy Learning!** 🎉

*Last updated: June 2025*