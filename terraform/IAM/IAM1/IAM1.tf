
resource "aws_iam_group_policy_attachment" "attch_test_cand1" {
  group = aws_iam_group.iam_group.cand1.name
