# Windows PowerShell validation guide

Prerequisites: Terraform 1.17.1 Windows AMD64, Git, internet for provider plugins. AWS/Azure/GCP CLI binaries are not needed for `init -backend=false` and `validate`. **No real cloud credentials are required for validation.** If your network blocks registry.terraform.io, `init` cannot download plugins.

From repository root in PowerShell:

```powershell
terraform version
git branch --show-current
terraform fmt -recursive terraform
.\scripts\validate.ps1
python -m unittest discover -s tests -v
```

To validate an individual cloud:

```powershell
cd terraform/environments/dev/aws
terraform init -backend=false -input=false
terraform validate
```

Return to repository root before committing. Terraform `init` generates `.terraform/` and `.terraform.lock.hcl`. Generated `.terraform/` should be ignored. **Commit version lock files** for reproducible provider selections once generated, and review the three lock files in your PR. Do not use `terraform plan` or `terraform apply` as part of this validation milestone. Provider `init` only fetches plugins; it does not create infrastructure.

If fmt check fails, run `terraform fmt -recursive terraform`, then repeat validation. If provider download fails, check network/proxy settings and rerun initialization. Azure example includes a placeholder subscription ID solely for static validation; do not use it for actual deployments.
