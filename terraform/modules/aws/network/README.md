# AWS VPC network module

Creates a two-AZ VPC with two public and two isolated private subnets, an internet gateway, and distinct route tables. **No NAT gateway, public-IP auto-assignment, or compute** is created. No infrastructure is deployed by repository CI.

Inputs: `name`, `vpc_cidr`, `availability_zones` (2), `public_subnet_cidrs` (2), `private_subnet_cidrs` (2), optional `tags`. CIDR overlap and AZ availability must be checked against your environment before planning. For production, add VPC Flow Logs, private endpoints/NAT as needed, and security-layer controls.
