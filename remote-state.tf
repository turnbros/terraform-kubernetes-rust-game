data "terraform_remote_state" "infra" {
  backend = "remote"
  config = {
    organization = var.remote_state_organization
    token        = var.remote_state_token
    workspaces = {
      name = var.remote_state_workspace
    }
  }
}