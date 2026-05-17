# =============================================================================
# IP адреса VM
# =============================================================================

output "airflow_external_ip" {
  description = "Внешний IP адрес Airflow"
  value       = yandex_compute_instance.airflow.network_interface[0].nat_ip_address
}

output "minio_external_ip" {
  description = "Внешний IP адрес MinIO"
  value       = yandex_compute_instance.minio.network_interface[0].nat_ip_address
}

output "trino_metabase_external_ip" {
  description = "Внешний IP адрес Trino + Metabase"
  value       = yandex_compute_instance.trino_metabase.network_interface[0].nat_ip_address
}

output "datahub_external_ip" {
  description = "Внешний IP адрес DataHub"
  value       = yandex_compute_instance.datahub.network_interface[0].nat_ip_address
}

# =============================================================================
# Внутренние IP (для связи между сервисами)
# =============================================================================

output "airflow_internal_ip" {
  description = "Внутренний IP адрес Airflow"
  value       = yandex_compute_instance.airflow.network_interface[0].ip_address
}

output "minio_internal_ip" {
  description = "Внутренний IP адрес MinIO"
  value       = yandex_compute_instance.minio.network_interface[0].ip_address
}

# =============================================================================
# URL сервисов
# =============================================================================

output "airflow_url" {
  description = "URL Airflow UI"
  value       = "http://${yandex_compute_instance.airflow.network_interface[0].nat_ip_address}:8080"
}

output "metabase_url" {
  description = "URL Metabase UI"
  value       = "http://${yandex_compute_instance.trino_metabase.network_interface[0].nat_ip_address}:3000"
}

output "datahub_url" {
  description = "URL DataHub UI"
  value       = "http://${yandex_compute_instance.datahub.network_interface[0].nat_ip_address}:9002"
}

output "minio_url" {
  description = "URL MinIO"
  value       = "http://${yandex_compute_instance.minio.network_interface[0].nat_ip_address}:9000"
}

# =============================================================================
# Сеть
# =============================================================================

output "network_id" {
  description = "ID сети"
  value       = yandex_vpc_network.data_platform_network.id
}

output "subnet_id" {
  description = "ID подсети"
  value       = yandex_vpc_subnet.data_platform_subnet.id
}
