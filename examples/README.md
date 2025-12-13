# Example Root-Level Configuration

This directory contains an example of how to use the modules directly from the root level.

**Note:** The recommended approach is to use environment-specific configurations in the `environments/` directory, which allows for:
- Separate state files per environment
- Environment-specific backend configurations
- Better isolation between environments

To use this example:
1. Copy `terraform.tfvars.example` to `terraform.tfvars`
2. Fill in the required values
3. Run `terraform init`, `terraform plan`, `terraform apply`

