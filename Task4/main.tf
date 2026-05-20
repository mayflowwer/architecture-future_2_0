terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.90"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

# =============================================================================
# СЕТЬ
# =============================================================================

resource "yandex_vpc_network" "data_platform_network" {
  name = "data-platform-network"
}

resource "yandex_vpc_subnet" "data_platform_subnet" {
  name           = "data-platform-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.data_platform_network.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

# =============================================================================
# SECURITY GROUPS
# =============================================================================

resource "yandex_vpc_security_group" "data_platform_sg" {
  name       = "data-platform-sg"
  network_id = yandex_vpc_network.data_platform_network.id

  # SSH доступ
  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Airflow UI
  ingress {
    protocol       = "TCP"
    port           = 8080
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Metabase UI
  ingress {
    protocol       = "TCP"
    port           = 3000
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Trino
  ingress {
    protocol       = "TCP"
    port           = 8081
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # DataHub
  ingress {
    protocol       = "TCP"
    port           = 9002
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # MinIO
  ingress {
    protocol       = "TCP"
    port           = 9000
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Весь исходящий трафик
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# =============================================================================
# VM: Airflow (оркестрация ETL)
# =============================================================================

resource "yandex_compute_instance" "airflow" {
  name        = "airflow"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
      size     = 20
    }
  }

  secondary_disk {
    disk_id = yandex_compute_disk.airflow_data.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.data_platform_subnet.id
    security_group_ids = [yandex_vpc_security_group.data_platform_sg.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

resource "yandex_compute_disk" "airflow_data" {
  name = "airflow-data-disk"
  size = 30
  zone = var.zone
  type = "network-ssd"
}

# =============================================================================
# VM: MinIO (S3 DataWarehouse)
# =============================================================================

resource "yandex_compute_instance" "minio" {
  name        = "minio"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 8
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
      size     = 20
    }
  }

  secondary_disk {
    disk_id = yandex_compute_disk.minio_data.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.data_platform_subnet.id
    security_group_ids = [yandex_vpc_security_group.data_platform_sg.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

resource "yandex_compute_disk" "minio_data" {
  name = "minio-data-disk"
  size = 100
  zone = var.zone
  type = "network-hdd"
}

# =============================================================================
# VM: Trino + Metabase (Query Engine + Data Mart)
# =============================================================================

resource "yandex_compute_instance" "trino_metabase" {
  name        = "trino-metabase"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = 4
    memory        = 16
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
      size     = 30
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.data_platform_subnet.id
    security_group_ids = [yandex_vpc_security_group.data_platform_sg.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

# =============================================================================
# VM: DataHub (Data Catalog)
# =============================================================================

resource "yandex_compute_instance" "datahub" {
  name        = "datahub"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = 4
    memory        = 16
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
      size     = 30
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.data_platform_subnet.id
    security_group_ids = [yandex_vpc_security_group.data_platform_sg.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}
