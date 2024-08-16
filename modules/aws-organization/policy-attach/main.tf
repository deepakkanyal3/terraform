resource "aws_organizations_policy_attachment" "attach" {
  for_each = toset(var.policy_ids)

  policy_id    = each.value
  target_id    = var.target_id
  skip_destroy = var.skip_destroy
}