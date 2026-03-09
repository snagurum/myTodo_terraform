locals {
  data = jsondecode(var.payload)
  role_name = local.data.role_name
  trust_policy_statement = local.data.trust_policy_statement
  inline_policies = lookup(local.data, "inline_policies",{})
  managed_policies = lookup(local.data, "managed_policies",[])
}


data "aws_iam_policy_document" "assume_role" {
  dynamic "statement" {
    for_each = local.trust_policy_statement

    content {
      effect  = lookup(statement.value, "effect", "Allow")
      actions = lookup(statement.value, "actions", ["sts:AssumeRole"])

      dynamic "principals" {
        for_each = statement.value.principals

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }
    }
  }
}


resource "aws_iam_role" "this" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


data "aws_iam_policy_document" "inline" {
  for_each = local.inline_policies

  dynamic "statement" {
    for_each = each.value.statements

    content {
      effect    = lookup(statement.value, "effect", "Allow")
      actions   = statement.value.Action
      resources = statement.value.Resource
    }
  }
}

resource "aws_iam_role_policy" "inline" {
  for_each = data.aws_iam_policy_document.inline

  name   = each.key
  role   = aws_iam_role.this.id
  policy = each.value.json
}


resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(local.managed_policies)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

