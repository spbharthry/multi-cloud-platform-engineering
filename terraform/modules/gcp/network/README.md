# GCP VPC network module

Creates one custom-mode VPC and regional subnets with VPC Flow Logs enabled and Private Google Access. Default routes are removed upon creation; no permissive inbound firewall rule is added. A project with the Compute Engine API enabled is required for deployment. No VMs or external IPs are created.
