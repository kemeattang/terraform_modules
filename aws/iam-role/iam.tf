resource "aws_iam_role" "this" {
  name                 = substr(local.name, 0, 31)
  assume_role_policy   = var.assume_role_policy
  path                 = var.path
  max_session_duration = var.max_session_duration
  tags                 = var.tags
}

resource "aws_iam_role_policy_attachment" "managed_policies" {
  count      = length(var.managed_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = element(var.managed_policy_arns, count.index)
}

resource "aws_iam_policy" "this" {
  count  = length(var.policies)
  name   = "${local.name}-${count.index}"
  policy = element(var.policies, count.index)
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = length(var.policies)
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this[count.index].arn
}

resource "aws_iam_instance_profile" "this" {
  count = var.create_instance_profile ? 1 : 0
  name  = local.name
  role  = aws_iam_role.this.name
}
