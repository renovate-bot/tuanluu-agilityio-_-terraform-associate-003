# 01_Infrastructure-as-Code

## 📖 Overview

This module demonstrates fundamental Infrastructure as Code (IaC) concepts using Terraform with the Docker provider. It's designed as an introductory example for learning Terraform basics and understanding how infrastructure can be defined, versioned, and managed as code.

## 🎯 Learning Objectives

By completing this module, you will learn:

- **Provider Configuration**: How to configure and use Terraform providers
- **Resource Definition**: Creating and managing infrastructure resources
- **State Management**: Understanding Terraform state and lifecycle
- **Basic Networking**: Port mapping and container networking concepts
- **Terraform Workflow**: The standard `init`, `plan`, `apply`, `destroy` cycle

## 🏗️ Infrastructure Components

This module creates the following resources:

| Resource Type | Name | Description |
|---------------|------|-------------|
| `docker_image` | `nginx` | Downloads the latest nginx Docker image |
| `docker_container` | `nginx` | Creates a container named "tutorial" with port mapping |

### Architecture Diagram

```
┌─────────────────────────────────────┐
│           Local Machine             │
│                                     │
│  ┌─────────────────────────────┐   │
│  │      Docker Container       │   │
│  │                             │   │
│  │  ┌─────────────────────┐   │   │
│  │  │    Nginx Server     │   │   │
│  │  │    Port: 80         │   │   │
│  │  └─────────────────────┘   │   │
│  │                             │   │
│  └─────────────────────────────┘   │
│               │                     │
│               │ Port Mapping        │
│               │                     │
│  ┌─────────────────────────────┐   │
│  │      Host System            │   │
│  │      Port: 8000             │   │
│  └─────────────────────────────┘   │
└─────────────────────────────────────┘
```

## 📋 Prerequisites

Before running this module, ensure you have:

- **Terraform** installed (>= 1.0)
- **Docker Desktop** running on your system
- **Command line access** (PowerShell, CMD, or Git Bash)

### Verify Prerequisites

```bash
# Check Terraform installation
terraform version

# Check Docker installation
docker --version

# Verify Docker is running
docker ps
```

## 🚀 Quick Start

### 1. Navigate to Module Directory

```bash
cd 01_Infrastructure-as-Code
```

### 2. Initialize Terraform

```bash
terraform init
```

**Expected Output:**
```
Initializing the backend...
Initializing provider plugins...
- Finding kreuzwerker/docker versions matching "3.6.2"...
- Installing kreuzwerker/docker v3.6.2...
- Installed kreuzwerker/docker v3.6.2

Terraform has been successfully initialized!
```

### 3. Review the Execution Plan

```bash
terraform plan
```

### 4. Apply the Configuration

```bash
terraform apply
```

When prompted, type `yes` to confirm.

### 5. Verify the Deployment

```bash
# Check if container is running
docker ps

# Test the nginx server
curl http://localhost:8000
# Or open http://localhost:8000 in your browser
```

### 6. Clean Up Resources

```bash
terraform destroy
```

## 📁 File Structure

```
01_Infrastructure-as-Code/
├── main.tf              # Main configuration file
├── terraform.tf        # Provider requirements and versions
├── terraform.tfstate    # State file (auto-generated)
├── .terraform/          # Provider plugins (auto-generated)
│   └── providers/
└── README.md            # This documentation
```

## 🔧 Configuration Details

### Provider Configuration (`terraform.tf`)

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
  }
}
```

**Key Points:**
- Uses the community Docker provider
- Version pinned for reproducibility
- Source explicitly defined for clarity

### Resource Configuration (`main.tf`)

#### Docker Image Resource

```hcl
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}
```

**Configuration Explained:**
- `name`: Specifies the Docker image to pull
- `keep_locally`: When `false`, image is removed when resource is destroyed

#### Docker Container Resource

```hcl
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
```

**Configuration Explained:**
- `image`: References the image from the docker_image resource
- `name`: Container name (must be unique)
- `ports`: Maps host port 8000 to container port 80

## 🔍 Understanding Terraform Concepts

### State Management

Terraform maintains state in `terraform.tfstate`:
- **Tracks** resource mappings and metadata
- **Enables** updates and deletions
- **Should not** be manually edited
- **Contains** sensitive information

### Resource Dependencies

```hcl
# Implicit dependency
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id  # References docker_image.nginx
  # ... other configuration
}
```

Terraform automatically understands that the container depends on the image.

### Terraform Workflow

1. **Write** → Define infrastructure in `.tf` files
2. **Plan** → Review changes before applying
3. **Apply** → Create/update infrastructure
4. **Manage** → Modify configuration as needed
5. **Destroy** → Remove infrastructure when done

## 🛠️ Common Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `terraform init` | Initialize working directory | `terraform init` |
| `terraform validate` | Validate configuration | `terraform validate` |
| `terraform fmt` | Format configuration files | `terraform fmt` |
| `terraform plan` | Show execution plan | `terraform plan` |
| `terraform apply` | Apply changes | `terraform apply` |
| `terraform show` | Show current state | `terraform show` |
| `terraform destroy` | Destroy infrastructure | `terraform destroy` |

## 🔧 Troubleshooting

### Common Issues

#### 1. Docker Not Running
**Error:** `Error: Cannot connect to the Docker daemon`

**Solution:**
```bash
# Windows - Start Docker Desktop
# Or restart Docker service
```

#### 2. Port Already in Use
**Error:** `port is already allocated`

**Solution:**
```bash
# Check what's using port 8000
netstat -ano | findstr :8000

# Kill the process or change the port in main.tf
```

#### 3. Permission Issues
**Error:** `permission denied while trying to connect to Docker`

**Solution:**
- Ensure Docker Desktop is running
- Run terminal as administrator if needed
- Check Docker Desktop settings

### Debugging Commands

```bash
# Check Terraform version
terraform version

# Validate configuration
terraform validate

# Check Docker status
docker version
docker system info

# List running containers
docker ps

# Check container logs
docker logs tutorial
```

## 🎓 Next Steps

After completing this module, consider:

1. **Modify the configuration:**
   - Change the nginx version
   - Use a different port mapping
   - Add environment variables

2. **Explore more resources:**
   - Add multiple containers
   - Create custom networks
   - Mount volumes

3. **Learn advanced concepts:**
   - Variables and outputs
   - Modules and composition
   - Remote state management

## 📚 Additional Resources

### Docker Provider Documentation
- [Docker Provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs)
- [docker_image resource](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image)
- [docker_container resource](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container)

### Terraform Fundamentals
- [Terraform Configuration Language](https://www.terraform.io/docs/language/index.html)
- [Resource Dependencies](https://www.terraform.io/docs/language/resources/behavior.html#resource-dependencies)
- [State Management](https://www.terraform.io/docs/language/state/index.html)

## 💡 Pro Tips

1. **Always run `terraform plan`** before `terraform apply`
2. **Use version constraints** for providers and modules
3. **Keep state files secure** - they may contain sensitive data
4. **Use meaningful resource names** for better maintainability
5. **Comment your configuration** for team collaboration

---

**Happy Learning!** 🎉

*This module is part of the Terraform Associate 003 learning project.*