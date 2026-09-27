environment = "stage"
location    = "East US"
owner       = "ETIC"
project     = "ETIC Notes"
costcenter  = "ETIC"

vnet_name = "etic-notes-stage-vnet"

vnet_address_space = ["10.1.0.0/16"]

subnets = {
  app = {
    address_prefix = "10.1.1.0/24"
  }

  private-endpoints = {
    address_prefix = "10.1.2.0/24"
  }
}

storage_account_name         = "eticnotesstagestorage"
private_endpoint_subnet_name = "private-endpoints"

app_service_plan_name = "etic-notes-stage-plan"
web_app_name          = "etic-notes-stage-webapp"
managed_identity_name = "etic-notes-stage-identity"
key_vault_name        = "etic-notes-stage-kv"

log_analytics_workspace_name = "etic-notes-stage-law"

enable_secondary_web_app = true