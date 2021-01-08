variable "logger_image_repository" {
  type        = string
  description = "The repo that the loggig image is stored in"
  default     = "docker.pkg.github.com"
}

variable "logger_image_name" {
  type        = string
  description = "The name of the logging image"
  default     = "turnbros/rusty-logger/rusty-logger"
}

variable "logger_image_tag" {
  type        = string
  description = "The tag of the logging image to use"
  default     = "0.1.0"
}

variable "wireguard_interface_name" {
  type        = string
  description = "The name of the wireguard interface"
  default     = "wg0"
}
variable "wireguard_ip_address" {
  type        = string
  description = "The IP address that this endpoint will use"
}
variable "wireguard_listen_port" {
  type        = string
  description = "The port wireguard will listen on"
}
variable "wireguard_private_key" {
  type        = string
  sensitive   = true
  description = "The private key that this endpoint will use"
  default     = null
}
variable "wireguard_remote_peer_public_key" {
  type        = string
  description = "The public they of the remote wireguard peer"
}
variable "wireguard_allowed_ip_cidrs" {
  type        = list(string)
  description = "A list of CIDRs that wireguard will pass"
}
variable "wireguard_remote_endpoint_ip" {
  type        = string
  description = "The IP address of the remote peer wireguard endpoint"
}
variable "wireguard_remote_endpoint_port" {
  type        = string
  description = "The port that the remote peer wireguard endpoint is listening on"
}

variable "elasticsearch_endpoint_hostname" {
  type        = string
  description = "The hostname of the elasticsearch endpoint to connect to"
}
variable "elasticsearch_endpoint_port" {
  type        = string
  description = "The port of the elasticsearch endpoint to connect to"
}
variable "elasticsearch_endpoint_username" {
  type        = string
  description = "The username that will be used to connect to this elasticsearch endpoint"
}
variable "elasticsearch_endpoint_password" {
  type        = string
  sensitive   = true
  description = "The password for the username that will be used to connect to this elasticsearch endpoint"
}