# Terraform Cloud AWS Infrastructure

This repository contains Terraform configuration files for managing AWS infrastructure using Terraform Cloud as the backend.

## Overview

- **Organization**: rahulkamblef2
- **Workspace**: rahulkamblef2-aws
- **AWS Region**: ap-south-1 (Asia Pacific - Mumbai)
- **Target**: AWS Free Tier usage

## Prerequisites

1. **Terraform CLI** (>= 1.0)
   ```bash
   # Install using tfenv (recommended)
   brew install tfenv
   tfenv install latest
   tfenv use latest
   ```

2. **Terraform Cloud Account**
   - Sign up at [app.terraform.io](https://app.terraform.io)
   - Create organization: `rahulkamblef2`
   - Create workspace: `rahulkamblef2-aws`

3. **AWS Account**
   - Set up AWS account with appropriate permissions
   - Configure AWS credentials in Terraform Cloud workspace

## Setup Instructions

### 1. Clone Repository
```bash
git clone <repository-url>
cd rahulkamblef2-aws
```

### 2. Terraform Cloud Authentication
```bash
# Login to Terraform Cloud
terraform login

# This will open a browser to generate an API token
# Copy the token and paste it in the CLI
```

### 3. Configure AWS Authentication in Terraform Cloud

Configure the recommended IAM role-based authentication in your Terraform Cloud workspace with these environment variables:

- `TFC_AWS_PROVIDER_AUTH`
- `TFC_AWS_RUN_ROLE_ARN`
- `AWS_DEFAULT_REGION`

This setup uses AWS IAM roles for secure authentication instead of static access keys, which is the best practice for production environments.

### 4. Initialize Terraform
```bash
terraform init
```

### 5. Plan and Apply
```bash
# Review the execution plan
terraform plan

# Apply the configuration
terraform apply
```

## File Structure

```
.
├── terraform.tf      # Terraform Cloud backend configuration
├── variables.tf      # Input variables
├── main.tf          # AWS provider and data sources
├── outputs.tf       # Output values
├── .gitignore       # Git ignore patterns
└── README.md        # This file
```

## Configuration Details

### Variables (`variables.tf`)
- `aws_region`: AWS region (default: ap-south-1)
- `environment`: Environment name (default: dev)
- `project_name`: Project name (default: rahulkamblef2-aws)
- `tags`: Common resource tags

### Data Sources (`main.tf`)
- AWS caller identity (account info)
- AWS region information
- Available availability zones
- Latest Amazon Linux 2 AMI (free tier eligible)

### Outputs (`outputs.tf`)
- AWS account ID and user ID
- AWS region and availability zones
- Amazon Linux AMI information

## Free Tier Considerations

This setup is optimized for AWS Free Tier usage:

- Uses `ap-south-1` region (check free tier availability)
- Includes Amazon Linux 2 AMI data source (free tier eligible)
- No billable resources created by default
- Ready for free tier EC2 instances, RDS, etc.

## Usage Examples

### Add an EC2 Instance (Free Tier)
```hcl
# Add to main.tf
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"  # Free tier eligible

  tags = merge(var.tags, {
    Name = "web-server"
  })
}
```

### Add a Security Group
```hcl
# Add to main.tf
resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Security group for web server"

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

  tags = var.tags
}
```

## Commands Reference

```bash
# Initialize workspace
terraform init

# Format code
terraform fmt

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes
terraform apply

# Show current state
terraform show

# List resources
terraform state list

# Destroy infrastructure
terraform destroy
```

## Security Best Practices

1. **IAM Role-Based Authentication** ✅:
   - Uses IAM roles instead of static access keys
   - Provides secure, temporary credentials
   - No long-lived credentials stored in Terraform Cloud

2. **Never commit sensitive data**:
   - `.tfvars` files are ignored
   - Use Terraform Cloud environment variables for secrets

3. **Use specific provider versions**:
   - Provider version is pinned in `terraform.tf`

4. **Enable resource tagging**:
   - All resources should use the common tags

5. **Review plans before applying**:
   - Always run `terraform plan` first

## Troubleshooting

### Common Issues

1. **Authentication Error**:
   ```bash
   # Re-authenticate with Terraform Cloud
   terraform login
   ```

2. **Provider Version Issues**:
   ```bash
   # Upgrade providers
   terraform init -upgrade
   ```

3. **State Lock Issues**:
   ```bash
   # Force unlock (use carefully)
   terraform force-unlock <lock-id>
   ```

## Contributing

1. Create a feature branch
2. Make changes and test locally
3. Run `terraform fmt` and `terraform validate`
4. Create a pull request
5. Apply changes through Terraform Cloud

## Support

For issues and questions:
- Check Terraform Cloud workspace logs
- Review AWS CloudTrail for API errors
- Consult [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## License

This project is licensed under the MIT License.