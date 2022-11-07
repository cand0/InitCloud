module "IAM" {
  source = "../../Module/IAM"
  user_name = "cand6"
  group_name = "cand6"
}

# testcode 1
resource "aws_iam_role_policy_attachment" "cand1" {
  policy_arn = module.IAM.iam_policy_cand1_id
  role       = module.IAM.iam_role_cand1_id
}

# testcode 2
resource "aws_iam_role_policy_attachment" "fail1_1" {
  role = module.IAM.iam_role_cand1_id
  policy_arn = module.IAM.iam_policy_cand1_id
}

resource "aws_iam_role_policy_attachment" "fail1_2" {
  role = module.IAM.iam_role_cand1_id
  policy_arn = module.IAM.iam_policy_cand1_id
}
