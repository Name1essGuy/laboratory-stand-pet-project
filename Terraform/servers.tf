# Конфиденциальные переменные

variable "token" {
    type      = string
    sensitive = true
}

variable "cloud_id" {
    type = string
}

variable "folder_id" {
    type = string
}

variable "vm_user" {
    type = string
}

variable "ssh_key_path" {
    type      = string
    sensitive = true
}

variable "ca_cores" {
    type = number
}

variable "ca_disk_size" {
    type = number
}

variable "ca_memory" {
    type = number
}

variable "mon_cores" {
    type = number
}

variable "mon_disk_size" {
    type = number
}

variable "mon_memory" {
    type = number
}

variable "vpn_cores" {
    type = number
}

variable "vpn_disk_size" {
    type = number
}

variable "vpn_memory" {
    type = number
}

variable "web_cores" {
    type = number
}

variable "web_disk_size" {
    type = number
}

variable "web_memory" {
    type = number
}

variable "db_cores" {
    type = number
}

variable "db_disk_size" {
    type = number
}

variable "db_memory" {
    type = number
}

data "yandex_compute_image" "ubuntu-2204-1" {
    family = var.OS_family
}

# Настройка провайдера

terraform {
    required_providers {
        yandex = {
            source = "yandex-cloud/yandex"
        }
    }
    required_version = ">= 0.47.0"
}

provider "yandex" {
    token     = var.token
    cloud_id  = var.cloud_id
    folder_id = var.folder_id
    zone      = "ru-central1-a"
}
t
# Создание облачной сети и подсети

resource "yandex_vpc_network" "stand-network" {
    name = local.network_name
}

resource "yandex_vpc_subnet" "stand-subnet" {
    name           = local.subnet_name
    zone           = "ru-central1-a"
    network_id     = yandex_vpc_network.stand-network.id
    v4_cidr_blocks = ["192.168.1.0/24"]
}



# Cоздание группы безопасности

resource "yandex_vpc_security_group" "allow-all" {
    name        = "allow-all"
    network_id  = yandex_vpc_network.prod-network.id

  ingress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 1
    to_port        = 65535
  }

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 1
    to_port        = 65535
  }
}


# Создание виртуальной машины удостоверяющего центра

resource "yandex_compute_instance" "ca-center" {
    name        = "ca-center"
    platform_id = "standart-v1"
    zone        = "ru-central1-a"

    resources {
        cores   = var.ca_cores
        memory  = var.ca_memory
    }

    boot_disk {
        initialize_params = "${data.yandex_compute_image.ubuntu-2004-1.id}"
        size = var.ca_disk_size
    }

    network_interface {
        subnet_id           = yandex_vpc_subnet.stand-subnet.id
        nat                 = true
        security_group_ids  = [yandex_vpc_security_group.allow-all.id]
    }

    metadata = {
        user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("${path.root}/${var.ssh_key_path}")}"
    }
}

# Создание виртуальной машины сервера мониторинга

resource "yandex_compute_instance" "monitoring-server" {
    name        = "monitoring-server"
    platform_id = "standart-v1"
    zone        = "ru-central1-a"

    resources {
        cores   = var.mon_cores
        memory  = var.mon_memory
    }

    boot_disk {
        initialize_params = "${data.yandex_compute_image.ubuntu-2004-1.id}"
        size = var.mon_disk_size
    }

    network_interface {
        subnet_id           = yandex_vpc_subnet.stand-subnet.id
        nat                 = true
        security_group_ids  = [yandex_vpc_security_group.allow-all.id]
    }

    metadata = {
        user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("${path.root}/${var.ssh_key_path}")}"
    }
}

# Создание виртуальной машины впн сервера

resource "yandex_compute_instance" "vpn-server" {
    name        = "vpn-server"
    platform_id = "standart-v1"
    zone        = "ru-central1-a"

    resources {
        cores   = var.vpn_cores
        memory  = var.vpn_memory
    }

    boot_disk {
        initialize_params = "${data.yandex_compute_image.ubuntu-2004-1.id}"
        size = var.vpn_disk_size
    }

    network_interface {
        subnet_id           = yandex_vpc_subnet.stand-subnet.id
        nat                 = true
        security_group_ids  = [yandex_vpc_security_group.allow-all.id]
    }

    metadata = {
        user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("${path.root}/${var.ssh_key_path}")}"
    }
}

# Создание виртуальной машины web сервера

resource "yandex_compute_instance" "web-server" {
    name        = "web-server"
    platform_id = "standart-v1"
    zone        = "ru-central1-a"

    resources {
        cores   = var.web_cores
        memory  = var.web_memory
    }

    boot_disk {
        initialize_params = "${data.yandex_compute_image.ubuntu-2004-1.id}"
        size = var.web_disk_size
    }

    network_interface {
        subnet_id           = yandex_vpc_subnet.stand-subnet.id
        nat                 = true
        security_group_ids  = [yandex_vpc_security_group.allow-all.id]
    }

    metadata = {
        user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("${path.root}/${var.ssh_key_path}")}"
    }
}

# Создание виртуальной машины сервера базы данных

resource "yandex_compute_instance" "db-server" {
    name        = "db-server"
    platform_id = "standart-v1"
    zone        = "ru-central1-a"

    resources {
        cores   = var.db_cores
        memory  = var.db_memory
    }

    boot_disk {
        initialize_params = "${data.yandex_compute_image.ubuntu-2004-1.id}"
        size = var.db_disk_size
    }

    network_interface {
        subnet_id           = yandex_vpc_subnet.stand-subnet.id
        nat                 = true
        security_group_ids  = [yandex_vpc_security_group.allow-all.id]
    }

    metadata = {
        user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("${path.root}/${var.ssh_key_path}")}"
    }
}

# Вывод IP-адресов всех созданных
output "ca_center_ip" {
  value = yandex_compute_instance.ca-center.network_interface.0.nat_ip_address
}

output "monitoring_server_ip" {
  value = yandex_compute_instance.monitoring-server.network_interface.0.nat_ip_address
}

output "vpn_server_ip" {
  value = yandex_compute_instance.vpn-server.network_interface.0.nat_ip_address
}

output "web_server_ip" {
  value = yandex_compute_instance.web-server.network_interface.0.nat_ip_address
}

output "db_server_ip" {
  value = yandex_compute_instance.db-server.network_interface.0.nat_ip_address
}