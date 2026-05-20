variable "service_account_key_file" {
  description = "Путь до JSON-ключа сервисного аккаунта"
  type        = string
  default     = "./key.json"
}

variable "cloud_id" {
  description = "ID облака в Yandex Cloud"
  type        = string
}

variable "folder_id" {
  description = "ID каталога в Yandex Cloud"
  type        = string
}

variable "zone" {
  description = "Зона доступности"
  type        = string
  default     = "ru-central1-a"
}

variable "ubuntu_image_id" {
  description = "ID образа Ubuntu 22.04 LTS в Yandex Cloud"
  type        = string
  default     = "fd8ne6e3etbrr2ve9nlc" # Ubuntu 22.04 LTS ru-central1-a
}

variable "ssh_public_key" {
  description = "Публичный SSH ключ для доступа к VM"
  type        = string
}
