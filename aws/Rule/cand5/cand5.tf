module "IAM" {
  source = "../Module/IAM"
  user_name = "cand5"
  group_name = "cand5"
}

# testcode 1

resource "aws_iam_policy_attachment" "pass1_1" {
  name       = "test-policy-attchment"
  policy_arn = module.IAM.iam_policy_cand1_id
  roles = [module.IAM.iam_role_cand1_id]
}

resource "aws_iam_policy_attachment" "pass1_2" {
  name       = "test-policy-attchment"
  policy_arn = module.IAM.iam_policy_cand2_id
  role = [module.IAM.iam_role_cand2_id]
}

# testcode 2
resource "aws_iam_role_policy_attachment" "pass2_1" {
  policy_arn = module.IAM.iam_policy_cand1_id
  role = module.IAM.iam_role_cand1_id
}

resource "aws_iam_role_policy_attachment" "pass2_2" {
  policy_arn = module.IAM.iam_policy_cand2_id
  role = module.IAM.iam_role_cand2_id
}

# testcode 3
resource "aws_iam_role_policy_attachment" "fail" {
  policy_arn = module.IAM.iam_policy_cand1_id
  role = module.IAM.iam_role_cand1_id
}

resource "aws_iam_policy_attachment" "fail" {
  name       = "test-policy-attachment"
  policy_arn = module.IAM.iam_policy_cand2_id
  roles = [module.IAM.iam_role_cand2_id]
}

