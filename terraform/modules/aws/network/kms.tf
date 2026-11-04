# AWS KMS encryption for VPC Flow Logs

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}

locals {
  flow_log_group_name = "/aws/vpc/${var.name}/flow-logs"

  flow_log_group_arn = format(
    "arn:%s:logs:%s:%s:log-group:%s",
    data.aws_partition.current.partition,
    data.aws_region.current.region,
    data.aws_caller_identity.current.account_id,
    local.flow_log_group_name
  )
}

data "aws_iam_policy_document" "kms_policy" {
  #checkov:skip=CKV_AWS_109: KMS key policy Resource "*" means this key; principal access is constrained.
  #checkov:skip=CKV_AWS_111: KMS key policy wildcard resource is scoped to the attached key.
  #checkov:skip=CKV_AWS_356: AWS KMS key policies use Resource "*" to identify their own key.

  statement {
    sid = "EnableAccountKeyAdministration"

    principals {
      type = "Service"
      identifiers = [
        "logs.${data.aws_region.current.region}.${data.aws_partition.current.dns_suffix}"
      ]
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = ["*"]

    condition {
      test     = "ArnEquals"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = [local.flow_log_group_arn]
    }
  }
}

resource "aws_kms_key" "vpc_flow_logs" {
  description = "KMS key for VPC Flow Logs"

  enable_key_rotation     = true
  deletion_window_in_days = 30

  policy = data.aws_iam_policy_document.kms_policy.json

  tags = merge(local.common_tags, {
    Name = "${var.name}-flow-logs-kms"
  })
}

resource "aws_kms_alias" "vpc_flow_logs" {
  name          = "alias/${var.name}-flow-logs"
  target_key_id = aws_kms_key.vpc_flow_logs.key_id
}
