#requires -Version 5.1
[CmdletBinding()]
param([switch]$SkipInit)
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$terraform = Get-Command terraform -ErrorAction Stop
Write-Host "Using Terraform: $($terraform.Source)"
& terraform version
if ($LASTEXITCODE -ne 0) { throw 'Terraform unavailable' }
Push-Location $root
try {
    & terraform fmt -check -recursive 'terraform'
    if ($LASTEXITCODE -ne 0) { throw 'Terraform formatting failed. Run terraform fmt -recursive terraform' }
    foreach ($cloud in @('aws','azure','gcp')) {
        $dir = Join-Path $root "terraform/environments/dev/$cloud"
        Write-Host "Validating $cloud ($dir)" -ForegroundColor Cyan
        Push-Location $dir
        try {
            if (-not $SkipInit) {
                & terraform init -backend=false -input=false
                if ($LASTEXITCODE -ne 0) { throw "Terraform init failed: $cloud" }
            }
            & terraform validate -no-color
            if ($LASTEXITCODE -ne 0) { throw "Terraform validate failed: $cloud" }
        }
        finally { Pop-Location }
    }
}
finally { Pop-Location }
Write-Host 'All three dev roots validated (no plan/apply).' -ForegroundColor Green
