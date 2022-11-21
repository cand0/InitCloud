module "IAM" {
  source = "../Module/IAM"
  user_name = "cand22"
  group_name = "cand22"
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


