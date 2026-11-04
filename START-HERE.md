# Multi-cloud Terraform foundation — additive starter package

**For:** `spbharthry/multi-cloud-platform-engineering`, branch `feature/terraform-foundation`.

## Important: preserves existing repository files

This ZIP intentionally contains **no top-level `README.md`, `.gitignore`, or `LICENSE`**, so extracting it into your existing repository does not overwrite any of those files. It supplies `START-HERE.md`, Terraform modules, dev examples, GitHub Actions CI, documentation, scripts and structural tests.

## Install into your existing repository on Windows

```powershell
cd "$HOME\multi-cloud-platform-engineering"
git status
# Download ZIP to Downloads first, then:
Expand-Archive -Path "$HOME\Downloads\multi-cloud-terraform-foundation-starter.zip" -DestinationPath "$HOME\Downloads\mcp-foundation" -Force
Copy-Item -Path "$HOME\Downloads\mcp-foundation\*" -Destination . -Recurse -Force
```

**Important:** Check `git status` before extraction. For the clean repo shown in the conversation, this adds new files. If your repo already contains any matching paths under `.github`, `terraform`, `docs`, `scripts`, `tests` or `architecture`, inspect differences before copying; `Copy-Item -Force` overwrites matching files. ZIP top-level includes no original GitHub root artifacts.

## Run validation only

```powershell
terraform fmt -recursive terraform
.\scripts\validate.ps1
python -m unittest discover -s tests -v
```

If `terraform init` fails because it can't access the public Terraform registry, check internet/proxy configuration. No cloud login required for these commands.

## Push as PR

```powershell
git status
git add .github terraform scripts tests docs architecture START-HERE.md
git commit -m "feat: add multi-cloud Terraform network foundation and CI"
git push -u origin feature/terraform-foundation
```

Review GitHub Actions CI after creating PR. **Do not run `terraform apply`.** This starter is a reference implementation; environment specifics, production controls and a remote state backend must be configured before real use.
