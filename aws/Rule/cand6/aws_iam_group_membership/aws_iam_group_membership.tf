resource "aws_iam_group" "cand1" {
  name = "cand1"
}
resource "aws_iam_user" "cand1" {
  name = "cand1"
}
resource "aws_iam_user" "cand2" {
  name = "cand2"
}
resource "aws_iam_user" "cand3" {
  name = "cand3"
}
resource "aws_iam_user" "cand4" {
  name = "cand4"
}

#fail
resource "aws_iam_group_membership" "fail1_1" {
  group = "${aws_iam_group.cand1.id}"
  name  = "fail"
  users = [aws_iam_user.cand1.id, aws_iam_user.cand2.id]
}

resource "aws_iam_group_membership" "fail1_2" {
  group = "${aws_iam_group.cand1.id}"
  name  = "fail"
  users = [aws_iam_user.cand3.id]
}

#pass
resource "aws_iam_group_membership" "pass" {
  group = "${aws_iam_group.cand1.id}"
  name  = "pass"
  users = [aws_iam_user.cand1.id, aws_iam_user.cand2.id, aws_iam_user.cand3.id]
}

