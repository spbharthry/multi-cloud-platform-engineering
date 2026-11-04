# Deployment readiness (not an automated deployment guide)

This repository intentionally has **no `terraform apply` workflow** and no cloud credentials. Before any real deployment, obtain cloud account authorization, enable budgets and alerts, choose appropriate regions, inspect naming and CIDR overlap, set up remote encrypted state with locking per cloud, set up least-privilege OIDC identities, review security scanning findings, and require human approval. These examples use local state solely for `terraform validate`; do **not** deploy or collaborate on shared state without proper backends. Azure resource group names must be unique per subscription; adjust before deployment. Confirm provider versions/API availability before applying.

Provisioning any cloud resources can incur costs. No deployment is included in the starter milestone.
