#
# This module creates the following for a specific app:
# a latency service level with tags
# a success service level with tags
#
# The app name is constructed using variables tenant and app_string 

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

locals {
    app_name = "${var.m_tenant}-prod-${var.m_app_string}"
}

data "newrelic_entity" "targetApp" {
  name = local.app_name 
  domain = "APM"
  type = "APPLICATION"
}

# Latency service level
resource "newrelic_service_level" "latencyServiceLevel" {
    guid = data.newrelic_entity.targetApp.guid
    name = "${local.app_name} duration < ${var.m_app_latency}"
    description = "Proportion of requests that are served faster than a threshold."

    events {
        account_id = var.m_nr_account_id 
        valid_events {
            from = "Transaction"
            where = "entityGuid = '${data.newrelic_entity.targetApp.guid}' AND (transactionType='Web') ${var.m_service_level_filter}"
        }
        good_events {
            from = "Transaction"
            where = "entityGuid = '${data.newrelic_entity.targetApp.guid}' AND (transactionType= 'Web') ${var.m_service_level_filter} AND duration < ${var.m_app_latency}"
        }
    }

    objective {
        target = 95.00
        time_window {
            rolling {
                count = 7
                unit = "DAY"
            }
        }
    }
}

# Success rate service level
resource "newrelic_service_level" "successServiceLevel" {
    guid = data.newrelic_entity.targetApp.guid
    name = "${local.app_name} success rate"
    description = "Proportion of requests that are served without errors."

    events {
        account_id = var.m_nr_account_id
        valid_events {
            from = "Transaction"
            where = "entityGuid = '${data.newrelic_entity.targetApp.guid}' ${var.m_service_level_filter}"
        }
        bad_events {
            from = "TransactionError"
            where = "entityGuid = '${data.newrelic_entity.targetApp.guid}' ${var.m_service_level_filter} AND error.expected = false"
        }
    }

    objective {
        target = 99.00
        time_window {
            rolling {
                count = 7
                unit = "DAY"
            }
        }
    }
}

# Latency Service level tags
resource "newrelic_entity_tags" "latencyServiceLevelTags" {
   guid = newrelic_service_level.latencyServiceLevel.sli_guid

   tag {
       key = "category"
       values = ["latency"]
   } 

   tag {
       key = "type" # web, avail, boundary, internal, ingest
       values = ["boundary"]
   }

   tag { 
       key = "customer"
       values = [var.m_tenant]
   }

   tag {
       key = "team"
       values = var.m_team_names
   }
} 

# Success Service level tags
resource "newrelic_entity_tags" "successServiceLevelTags" {
   guid = newrelic_service_level.successServiceLevel.sli_guid

   tag {
       key = "category"
       values = ["success"]
   } 

   tag {
       key = "type" # web, avail, boundary, internal, ingest
       values = ["boundary"]
   }

   tag { 
       key = "customer"
       values = [var.m_tenant]
   }

   tag {
       key = "team"
       values = var.m_team_names
   }
} 



