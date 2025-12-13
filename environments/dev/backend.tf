# Backend configuration for remote state storage
# For local development, comment out this entire block to use local state
# Uncomment and configure for remote state in CI/CD or team environments
terraform {
  backend "s3" {
    # These values can be overridden via -backend-config flags or backend config file
    # Example: terraform init -backend-config="bucket=my-bucket" -backend-config="key=dev/terraform.tfstate"
    bucket         = "mycompany-terraform-backend"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"  # For state locking (optional but recommended)
    encrypt        = true               # Enable server-side encryption
  }
}
