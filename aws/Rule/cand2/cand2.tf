module "IAM" {
  source = "../Module/IAM"
  user_name = "cand2"
  group_name = "cand2"
}

# testcode 1
resource "aws_iam_policy_attachment" "pass1" {
  name       = "test-policy-attchment"
  policy_arn = module.IAM.iam_policy_cand1_id
  groups = [module.IAM.iam_group_cand0_id]
}

# testcode 2
resource "aws_iam_group_policy_attachment" "fail1_1" {
  group = module.IAM.iam_group_cand0_id
  policy_arn = module.IAM.iam_policy_cand1_id
}

resource "aws_iam_group_policy_attachment" "fail1_2" {
  group = module.IAM.iam_group_cand0_id
  policy_arn = module.IAM.iam_policy_cand2_id
}


