
provider "ncloud" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.region
}

data "template_file" "user_data" {
    template = "${file("user_data.sh")}"
}

resource "ncloud_login_key" "loginkey" {
  key_name = "cand1"
}
#server create
resource "ncloud_server" "server" {
    count = "2"
     name = "cand${count.index}"

    server_image_product_code = var.server_image_prodict_code
    server_product_code = var.server_product_code
    user_data = "${data.template_file.user_data.rendered}"
}


resource "ncloud_load_balancer" "lb" {
  name           = "cand1-lb"
  algorithm_type = "RR"
  description    = "tftest_lb description"

    rule_list {
        protocol_type = "HTTP"
        load_balancer_port = 80
        server_port = 80
        l7_health_check_path = "/"
    }

    server_instance_no_list = ["${ncloud_server.server.*.id[0]}", "${ncloud_server.server.*.id[1]}"]
    network_usage_type = "PBLIP"

    region = "KR"

}
