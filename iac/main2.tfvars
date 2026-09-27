environment = "dev"
location    = "East US"
owner       = "ETIC"
project     = "ETIC Notes"
costcenter  = "ETIC"

vnet_name = "etic-notes-dev-vnet"

vnet_address_space = ["10.0.0.0/16"]

subnets = {
  app = {
    address_prefix = "10.0.1.0/24"
  }

  private-endpoints = {
    address_prefix = "10.0.2.0/24"
  }
}

storage_account_name         = "eticnotesdevstorage"
private_endpoint_subnet_name = "private-endpoints"

app_service_plan_name = "etic-notes-dev-plan"
web_app_name          = "etic-notes-dev-webapp"
managed_identity_name = "etic-notes-dev-identity"
key_vault_name        = "etic-notes-dev-kv"

log_analytics_workspace_name = "etic-notes-dev-law"

enable_secondary_web_app = false