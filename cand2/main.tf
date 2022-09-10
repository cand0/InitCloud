provider "ncloud" {
    support_vpc = true
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.region
}

resource "ncloud_login_key" "key" {
    key_name = var.login_key_name
}

data "ncloud_root_password" "rootpwd" {
    count = "2"
    server_instance_no = ncloud_server.server[count.index].id
    private_key = ncloud_login_key.key.private_key
}

#network configuration
data "ncloud_vpc" "selected" {
    id = "25845"
}


resource "ncloud_network_acl" "nacl" {
    vpc_no = data.ncloud_vpc.selected.id
    name = "cand2-acl"
    description = "cand2 nacl configuration"
}

resource "ncloud_subnet" "subnet" {
  count = "2"
  vpc_no         = data.ncloud_vpc.selected.id
  subnet         = var.subnets[count.index] 
  zone           = var.zones
  network_acl_no = ncloud_network_acl.nacl.id
  subnet_type    = var.subnet_types[count.index]
  name           = var.subnet_names[count.index]
  usage_type     = var.subnet_usage[count.index]
}

resource "ncloud_init_script" "init" {
    name = "httpd-install"
    content = "#!/bin/bash\n yum -y install httpd\n systemctl enable --now httpd\necho $HOSTNAME >> /var/www/html/index.html"
}

resource "ncloud_access_control_group" "acg" {
    name = "cand2-acg"
    description = "description"
    vpc_no = data.ncloud_vpc.selected.id
}
resource "ncloud_access_control_group_rule" "acg-rule" {
    access_control_group_no = ncloud_access_control_group.acg.id

    inbound {
        protocol = "TCP"
        ip_block = "0.0.0.0/0"
        port_range = "22"
        description = "accept 22 port"
    }
    inbound {
        protocol = "TCP"
        ip_block = "0.0.0.0/0"
        port_range = "80"
        description = "accept 80 port"
    }
    outbound {
        protocol = "TCP"
        ip_block = "0.0.0.0/0"
        port_range = "1-65535"
        description = "accept 1-65535 port"
    }
}

resource "ncloud_network_interface" "nic" {
    count = "2"
    name = "cand2-nic-${count.index+1}"
    subnet_no = ncloud_subnet.subnet[0].id
    private_ip = var.ni_pi[count.index]
    access_control_groups = [ncloud_access_control_group.acg.id]
}

# server configuration
resource "ncloud_server" "server" {
    count = "2"
    subnet_no = ncloud_subnet.subnet[0].id
    name = "ncloud-terraform-cand2-vm-${count.index+1}"
    server_image_product_code = var.server_image_product_code
    server_product_code = var.server_product_code
    description = "terraform-vm-${count.index+1} in best tip !!"
    login_key_name = ncloud_login_key.key.key_name
    init_script_no = ncloud_init_script.init.id
    network_interface {
        network_interface_no = ncloud_network_interface.nic[count.index].id
        order = 0
    }
}

resource "ncloud_public_ip" "p1" {
    count = "2"
    server_instance_no = ncloud_server.server[count.index].id
    description = "terra-IP"
}

resource "ncloud_nas_volume" "nas" {
    volume_name_postfix = var.nasname
    volume_size = "500"
    volume_allotment_protocol_type="NFS"
    server_instance_no_list = [ncloud_server.server[0].id, ncloud_server.server[1].id]
}

resource "ncloud_lb_target_group" "tg" {
    name = "terra-tg"
    vpc_no = data.ncloud_vpc.selected.id
    protocol = "HTTP"
    target_type = "VSVR"
    port = 80
    description = "cand2_lb_group"
    health_check {
        protocol = "HTTP"
        http_method = "GET"
        port = 80
        url_path = "/"
        cycle = 30
        up_threshold = 2
        down_threshold = 2
    }
    algorithm_type = "RR"
}

#LB TargetGroup Attachment
resource "ncloud_lb_target_group_attachment" "att"{
    target_group_no = ncloud_lb_target_group.tg.id
    target_no_list = [ncloud_server.server[0].id, ncloud_server.server[1].id]
}

#LB
resource "ncloud_lb" "lb"{
    name = "cand2-LB"
    network_type = "PUBLIC"
    type = "APPLICATION"
    subnet_no_list = [ncloud_subnet.subnet[1].id]
}
resource "ncloud_lb_listener" "listener" {
    load_balancer_no = ncloud_lb.lb.id
    protocol = "HTTP"
    port = 80
    target_group_no = ncloud_lb_target_group.tg.id
}

#Auto scaling = Launch_configuration
resource "ncloud_launch_configuration" "lc" {
    name = "cand2-lc"
    server_image_product_code = var.server_image_product_code
    server_product_code = var.server_product_code
    login_key_name = var.login_key_name
    init_script_no = ncloud_init_script.init.id
}

resource "ncloud_auto_scaling_group" "asg" {
  name = "cand2-acg"
  subnet_no = ncloud_subnet.subnet[0].id
  access_control_group_no_list = [ncloud_access_control_group.acg.id]
  launch_configuration_no = ncloud_launch_configuration.lc.id
  min_size = 1
  desired_capacity = 0
  max_size = 3 
  target_group_list = [ncloud_lb_target_group.tg.target_group_no]
  default_cooldown = "300" 
  health_check_type_code = "LOADB" 
  health_check_grace_period = "300" 
  wait_for_capacity_timeout = "0"  
  
}

resource "ncloud_auto_scaling_policy" "policy" {
  count = "2"
  name = var.auto_scaling_policy_name[count.index]
  adjustment_type_code = "CHANG"
  scaling_adjustment = var.scaling_adjustment[count.index]
  auto_scaling_group_no = ncloud_auto_scaling_group.asg.auto_scaling_group_no
}

resource "null_resource" "ssh" {
    count = "2"
    connection {
        type = "ssh"
        host = ncloud_public_ip.p1[count.index].public_ip
        user = "root"
        port = 22
        password = data.ncloud_root_password.rootpwd[count.index].root_password
    }

    provisioner "remote-exec" {
        script = "./mount.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "echo 'redhat' | passwd --stdin root",
            "mount -t nfs ${var.nasserver}:/${ncloud_nas_volume.nas.name} /mnt/nas" ,
            "df -h",
        ]
    }
}

