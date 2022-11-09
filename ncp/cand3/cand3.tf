

resource "ncloud_auto_scaling_policy" "fail1_1" {
  adjustment_type_code  = "CHANG"
  auto_scaling_group_no = "${ncloud_auto_scaling_group.auto.id}"
  name                  = "cand1"
  scaling_adjustment    = 0
}
resource "ncloud_auto_scaling_policy" "fail1_2" {
  adjustment_type_code  = "EXACT"
  auto_scaling_group_no = "${ncloud_auto_scaling_group.auto.id}"
  name                  = "cand1"
  scaling_adjustment    = 0
}

resource "ncloud_auto_scaling_policy" "pass" {
  adjustment_type_code  = "EXACT"
  auto_scaling_group_no = "${ncloud_auto_scaling_group.auto.id}"
  name                  = "cand1"
  scaling_adjustment    = 0
}
