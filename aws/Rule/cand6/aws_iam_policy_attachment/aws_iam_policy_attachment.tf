module "IAM" {
  source = "../../Module/IAM"
  group_name = "cand6"
  user_name = "cand6"
}

#fail
resource "aws_iam_policy_attachment" "fail1_1" {
  name       = "test-attachment"
  policy_arn = "${module.IAM.iam_policy_cand1_id}"
  users = [module.IAM.iam_user_cand1_id]
}

resource "aws_iam_policy_attachment" "fail1_2" {
  name       = "test-attachment"
  policy_arn = "${module.IAM.iam_policy_cand1_id}"
  users = [module.IAM.iam_user_cand2_id]
}

resource "aws_iam_policy_attachment" "fail2_1" {
  name       = "test-attachment"
  policy_arn = "${module.IAM.iam_policy_cand1_id}"
  groups = [module.IAM.iam_group_cand1_id]
}

resource "aws_iam_policy_attachment" "fail2_2" {
  name       = "test-attachment"
  policy_arn = "${module.IAM.iam_policy_cand1_id}"
  users = [module.IAM.iam_group_cand2_id]
}

resource "aws_iam_policy_attachment" "fail3_1" {
  name       = "test-attachment"
  policy_arn = "${module.IAM.iam_policy_cand1_id}"
  roles = [module.IAM.iam_role_cand1_id]
}

resource "aws_iam_policy_attachment" "fail3_2" {
  name       = "test-attachment"
  policy_arn = "${module.IAM.iam_policy_cand1_id}"
  roles = [module.IAM.iam_role_cand2_id]
}

#pass
resource "aws_iam_policy_attachment" "pass1" {
  name       = "test-attachment"
  policy_arn = "${module.IAM.iam_policy_cand1_id}"
  users = [module.IAM.iam_user_cand1_id, module.IAM.iam_user_cand2_id]
}
resource "aws_iam_policy_attachment" "pass2" {
  name       = "test-attachment"
  policy_arn = "${module.IAM.iam_policy_cand1_id}"
  groups = [module.IAM.iam_group_cand1_id, module.IAM.iam_group_cand2_id]
}
resource "aws_iam_policy_attachment" "pass3" {
  name       = "test-attachment"
  policy_arn = "${module.IAM.iam_policy_cand1_id}"
  roles = [module.IAM.iam_role_cand1_id, module.IAM.iam_role_cand2_id]
}
