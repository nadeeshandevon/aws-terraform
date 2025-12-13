# Terraform: AWS Infrastructure as Code

This Terraform project creates AWS infrastructure using a modular, environment-based approach:
- VPC with public subnet and Internet Gateway
- EC2 instance using latest Amazon Linux 2 AMI
- Security group allowing SSH (22) and HTTP (80)
- S3 bucket with optional versioning

## Project Structure

```
.
├── modules/              # Reusable Terraform modules
│   ├── vpc/             # VPC, subnet, IGW, route tables
│   ├── security_group/  # Security group rules
│   ├── ec2/             # EC2 instance configuration
│   └── s3/              # S3 bucket configuration
├── environments/        # Environment-specific configurations
│   ├── dev/            # Development environment
│   ├── stage/           # Staging environment (to be configured)
│   └── prod/            # Production environment (to be configured)
└── examples/            # Example root-level configuration
```

## Prerequisites

- Terraform 1.0+
- AWS credentials configured (environment variables or named profile)
- An existing EC2 key pair in the target region

## Quick Start

### Using Environment-Specific Configuration (Recommended)

Each environment has its own directory with isolated state files:

```powershell
# Navigate to the dev environment
cd environments/dev

# Copy example variables and edit
copy terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars to set bucket_name and key_name

# For local development (without S3 backend):
# Option 1: Initialize with local backend
terraform init -backend=false

# Option 2: Use local state by temporarily renaming backend.tf
# ren backend.tf backend.tf.disabled
# terraform init

# For remote state (requires AWS credentials and S3 bucket):
terraform init

# Plan and apply
terraform plan
terraform apply
```

### Using Root-Level Example

See the `examples/` directory for a root-level configuration example.

## Environment Configuration

Each environment directory contains:
- `main.tf` - Module orchestration
- `variables.tf` - Environment-specific variables
- `outputs.tf` - Environment-specific outputs
- `backend.tf` - Remote state configuration (if applicable)
- `terraform.tfvars.example` - Example variable values

## Backend Configuration

### Local Development

For local development without AWS S3 backend:

```powershell
# Initialize with local state
terraform init -backend=false
```

Or temporarily disable the S3 backend by renaming `backend.tf`:

```powershell
ren backend.tf backend.tf.disabled
terraform init
```

### Remote State (S3 Backend)

For team environments or CI/CD, configure the S3 backend in `backend.tf`:

1. Update `backend.tf` with your S3 bucket name and DynamoDB table
2. Ensure AWS credentials are configured
3. Run `terraform init`

**Note:** The `dynamodb_table` parameter warning can be ignored - it's still valid for state locking. If you see this warning, it's safe to proceed.

## Troubleshooting

### Error: "No valid credential sources found"

This occurs when Terraform tries to access the S3 backend but AWS credentials aren't configured. Solutions:

1. **For local development:** Use `terraform init -backend=false` to skip backend initialization
2. **For remote state:** Configure AWS credentials:
   ```powershell
   # Option 1: Environment variables
   $env:AWS_ACCESS_KEY_ID="your-access-key"
   $env:AWS_SECRET_ACCESS_KEY="your-secret-key"
   $env:AWS_REGION="us-east-1"
   
   # Option 2: AWS CLI profile
   aws configure --profile your-profile
   $env:AWS_PROFILE="your-profile"
   ```

### Deprecation Warning for dynamodb_table

If you see a deprecation warning about `dynamodb_table`, you can safely ignore it. The parameter is still valid and functional. Alternatively, you can remove the `dynamodb_table` line if you don't need state locking.

## Notes

- `bucket_name` must be globally unique across AWS S3
- If you don't have a key pair, create one in the AWS console or with `aws ec2 create-key-pair`
- The security group uses an open SSH rule (0.0.0.0/0) for demonstration. Lock this down in production
- Each environment maintains its own Terraform state file for isolation
