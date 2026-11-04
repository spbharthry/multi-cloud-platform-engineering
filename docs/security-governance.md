# Security governance notes

- CI uses read-only checkout; no cloud credentials are supplied.
- Checkov is advisory (`soft_fail: true`) for the first PR. Review, triage and remediate findings; make it blocking when the baseline is clean.
- AWS private subnets have no internet route; public subnets do not auto-assign public IPv4 addresses.
- Azure NSGs are associated with every example subnet; default Azure rules still apply. Define workload-specific restrictions separately.
- GCP VPC has no default internet routes and logs subnet flows; no permissive ingress rules are provisioned.
- Production additions: AWS flow logs, centralized logs, Azure network diagnostic policy, provider identity controls, policy as code, secrets handling and network egress policy.
- Do not commit credentials, tfstate, `.tfvars` with secrets, SSH keys, client data or client-specific architecture.
- Set GitHub branch protection and require all relevant checks on pull requests. No GitHub Actions workflow here grants deployment permissions.
