#
# See README for more information
#

terraform {
  # Require Terraform version 1.0 (recommended)
  required_version = "~> 1.0"

  # Require the latest 2.x version of the New Relic provider
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
    }
  }
}

provider "newrelic" {
  account_id = var.nr_account_id   # Your New Relic account ID
  api_key = var.nr_api_key 
  region = "US"        # US or EU (defaults to US)
}


module "service_levels_module" {
    source = "./modules/service-level-tf-module"

    m_nr_account_id = var.nr_account_id
    m_app_latency = 0.561
    m_app_string = "3pi-tracking-fourkites"
    m_service_level_filter = var.service_level_filter
    m_team_names = var.team_names
    m_tenant = var.tenant
}

