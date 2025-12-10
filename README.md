# Terraform: S3 bucket and EC2 instance

This small Terraform config creates:
- One S3 bucket (`aws_s3_bucket.bucket`)
- One EC2 instance (`aws_instance.web`) using latest Amazon Linux 2 AMI
- A security group allowing SSH (22) and HTTP (80)

Prerequisites
- Terraform 1.0+
- AWS credentials configured (environment variables or named profile)
- An existing EC2 key pair in the target region (set `key_name`)

Quick start (PowerShell)

```powershell
cd d:/Devon/aws_terraform
# copy example vars and edit
copy .\terraform.tfvars.example .\terraform.tfvars
# edit terraform.tfvars to set bucket_name and key_name
terraform init
terraform plan
terraform apply
```

Notes
- `bucket_name` must be globally unique across AWS S3.
- If you don't have a key pair, create one in the AWS console or with `aws ec2 create-key-pair` and set `key_name` accordingly.
- This config uses an open SSH rule (0.0.0.0/0) for demonstration. Lock this down in production.
