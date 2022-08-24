variable "project" {
  description = "The project to deploy to, if not set the default provider project is used."
  default     = "codimite"
}

variable "region" {
  description = "Region for cloud resources"
  default     = "asia-southeast1-b"
}

variable "tier" {
  description = "Machine type"
  default     = "f1-micro"
}

variable "os_type" {
  description = "Image of OS"
  default     = "debian-cloud/debian-11"
}

variable "app_name" {
  description = "Name of the application"
  default     = "todo"
}

variable "db_instance" {
  description = "Instance name for Cloud SQL"
  default     = "db-instance"
}

variable "db_version" {
  description = "Version of MySQL"
  default     = "MYSQL_8_0"
}


variable "db_region" {
  description = "Region for cloud resources"
  default     = "asia-southeast1"
}

variable "db_tier" {
  description = "The machine tier (First Generation) or type (Second Generation). See this page for supported tiers and pricing: https://cloud.google.com/sql/pricing"
  default     = "db-f1-micro"
}

variable "db_name" {
  description = "Name of the default database to create"
  default     = "todo"
}

