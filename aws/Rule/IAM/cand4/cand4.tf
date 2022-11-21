module "IAM" {
  source = "../Module/IAM"
  user_name = "cand4"
  group_name = "cand4"
}

# testcode 1

resource "aws_iam_policy_attachment" "pass1_1" {
  name       = "test-policy-attchment"
  policy_arn = module.IAM.iam_policy_cand1_id
  users = [module.IAM.iam_user_cand0_id]
}

resource "aws_iam_policy_attachment" "pass1_2" {
  name       = "test-policy-attchment"
  policy_arn = module.IAM.iam_policy_cand2_id
  users = [module.IAM.iam_user_cand0_id]
}

# testcode 2
resource "aws_iam_user_policy_attachment" "pass2_1" {
  policy_arn = module.IAM.iam_policy_cand1_id
  user       = module.IAM.iam_user_cand0_id
}

resource "aws_iam_user_policy_attachment" "pass2_2" {
  policy_arn = module.IAM.iam_policy_cand2_id
  user       = module.IAM.iam_user_cand0_id
}

# testcode 3
resource "aws_iam_user_policy_attachment" "fail" {
  policy_arn = module.IAM.iam_policy_cand1_id
  user       = module.IAM.iam_user_cand0_id
}

resource "aws_iam_policy_attachment" "fail" {
  name       = "test-policy-attachment"
  policy_arn = module.IAM.iam_policy_cand2_id
  users = [module.IAM.iam_user_cand0_id]
}

