module "IAM" {
  source = "../../Module/IAM"
  user_name = "cand6"
  group_name = "cand6"
}

# testcode 1
resource "aws_iam_user_policy_attachment" "pass" {
  policy_arn = module.IAM.iam_policy_cand1_id
  user       = module.IAM.iam_user_cand1_id
}

# testcode 2
resource "aws_iam_user_policy_attachment" "fail1_1" {
  policy_arn = module.IAM.iam_policy_cand1_id
  user       = module.IAM.iam_user_cand1_id
}
resource "aws_iam_user_policy_attachment" "fail1_2" {
  policy_arn = module.IAM.iam_policy_cand1_id
  user       = module.IAM.iam_user_cand1_id
}
