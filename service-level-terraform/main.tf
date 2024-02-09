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
    for_each = var.service_level_param_map 
    source = "./modules/service-level-tf-module"

    m_nr_account_id = var.nr_account_id
    m_service_level_filter = var.service_level_filter
    m_team_names = var.team_names
    m_tenant = var.tenant

    m_app_string = each.value.app_string
    m_app_latency = each.value.latency
}

