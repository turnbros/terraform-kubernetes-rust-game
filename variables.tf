###################################
### Infrastructure Remote State ###
###################################
variable "remote_state_token" {
  type        = string
  description = "A cloud token to authenticate with when pulling the Infrastructure remote state"
}
variable "remote_state_organization" {
  type        = string
  description = "The name of the Terraform Cloud organization to pull the infrastructure remote state from"
}
variable "remote_state_workspace" {
  type        = string
  description = "The name of the Terraform Cloud workspace to pull the infrastructure remote state from"
}

variable "cpu_request" {
  type        = string
  description = ""
  default     = "200m"
}
variable "memory_request" {
  type        = string
  description = ""
  default     = "512Mi"
}
variable "cpu_limit" {
  type        = string
  description = ""
  default     = "400m"
}
variable "memory_limit" {
  type        = string
  description = ""
  default     = "1536Mi"
}

variable "image_repository" {
  type        = string
  description = ""
  default     = "registry.hub.docker.com"
}

variable "image_name" {
  type        = string
  description = ""
  default     = "didstopia/rust-server"
}

variable "image_tag" {
  type        = string
  description = ""
  default     = "latest"
}

variable "image_pull_policy" {
  type        = string
  description = ""
  default     = "IfNotPresent"
}

variable "name" {
  type        = string
  description = ""
  default     = "rust"
}

# RUST_SERVER_NAME
variable "rust_server_name" {
  type        = string
  description = "The publicly visible server name"
  default     = "Rust Server [DOCKER]"
}

# RUST_SERVER_STARTUP_ARGUMENTS
variable "rust_server_startup_arguments" {
  type        = string
  description = ""
  default     = "-batchmode -load -nographics +server.secure 1"
}

# RUST_SERVER_IDENTITY
variable "rust_server_identity" {
  type        = string
  description = "Mainly used for the name of the save directory"
  default     = "docker"
}

# RUST_SERVER_PORT
variable "rust_server_port" {
  type        = number
  description = "Rust server port 28015 if left blank or numeric value"
  default     = 28015
}

# RUST_SERVER_SEED
variable "rust_server_seed" {
  type        = number
  description = "The server map seed, must be an integer"
  default     = 12345
}

# RUST_SERVER_WORLDSIZE
variable "rust_server_worldsize" {
  type        = number
  description = "The map size, must be an integer"
  default     = 3500
}

# RUST_SERVER_MAXPLAYERS
variable "rust_server_maxplayers" {
  type        = number
  description = "Maximum players on the server, must be an integer"
  default     = 500
}

# RUST_SERVER_DESCRIPTION
variable "rust_server_description" {
  type        = string
  description = "The publicly visible server description"
  default     = "This is a Rust server running inside a Docker container!"
}

# RUST_SERVER_URL
variable "rust_server_url" {
  type        = string
  description = "The publicly visible server website"
  default     = "https://hub.docker.com/r/didstopia/rust-server/"
}

# RUST_SERVER_BANNER_URL
variable "rust_server_banner_url" {
  type        = string
  description = "The publicly visible server banner image URL"
  default     = ""
}

# RUST_SERVER_SAVE_INTERVAL
variable "rust_server_save_interval" {
  type        = number
  description = "Amount of seconds between automatic saves."
  default     = 600
}

# RUST_RCON_WEB
variable "rust_rcon_web" {
  type        = number
  description = "Set to 1 or 0 to enable or disable the web-based RCON server"
  default     = 1
}

# RUST_RCON_PORT
variable "rust_rcon_port" {
  type        = number
  description = "RCON server port"
  default     = 28016
}

# RUST_RCON_PASSWORD
variable "rust_rcon_password" {
  type        = string
  description = "RCON server password"
}

# RUST_APP_PORT
variable "rust_app_port" {
  type        = number
  description = "Rust+ companion app port"
  default     = 28082
}

# RUST_BRANCH
variable "rust_branch" {
  type        = string
  description = "Sets the branch argument to use, eg. set to `-beta prerelease` for the prerelease branch"
  default     = null
}

# RUST_UPDATE_CHECKING
variable "rust_update_checking" {
  type        = number
  description = "Set to 1 to enable fully automatic update checking, notifying players and restarting to install updates"
  default     = 0
}

# RUST_UPDATE_BRANCH
variable "rust_update_branch" {
  type        = string
  description = "Set to match the branch that you want to use for updating, ie. `prerelease` or `public`, but do not specify arguments like `-beta`"
  default     = "public"
}
# RUST_START_MODE
variable "rust_start_mode" {
  type        = number
  description = "Determines if the server should update and then start (0), only update (1) or only start (2)"
  default     = 0
}

# RUST_OXIDE_ENABLED
variable "rust_oxide_enabled" {
  type        = number
  description = "Set to 1 to automatically install the latest version of Oxide"
  default     = 0
}

# RUST_OXIDE_UPDATE_ON_BOOT
variable "rust_oxide_update_on_boot" {
  type        = number
  description = "Set to 0 to disable automatic update of Oxide on boot"
  default     = 1
}