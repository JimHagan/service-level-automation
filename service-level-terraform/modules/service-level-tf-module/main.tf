#
# This module creates the following for a specific app:
# a latency service level with tags
# a success service level with tags
#
# The app name is constructed using variables tenant and app_string 

#

#
# To do: Finish creating module
# Edit success service level and checking naming conventions match with defaults
# Edit variables file
# Test out on TechOps - does it work?
#

/*
provider "newrelic" {
  account_id = var.m_nr_account_id 
  api_key = var.m_nr_api_key 
  region = "US"        # US or EU (defaults to US)
}*/

locals {
    app_name = "${var.m_tenant}-prod-{$var.m_app_string}"
}

data "newrelic_entity" "targetApp" {
  name = local.app_name 
  domain = "APM"
  type = "APPLICATION"
}

# Create service levels
resource "newrelic_service_level" "latencyServiceLevel" {
    guid = data.newrelic_entity.targetApp.guid
    name = join(var.m_app_name," transactions < ", var.m_app_latency) 
    description = "Proportion of requests that are served faster than a threshold."

    events {
        account_id = var.m_nr_account_id 
        valid_events {
            from = "Transaction"
            where = "appName = '${local.app_name}' AND (transactionType='Web') ${var.m_service_level_filter}"
        }
        good_events {
            from = "Transaction"
            where = "appName = '${local.app_name}' AND (transactionType= 'Web') ${var.m_service_level_filter} AND duration < ${var.m_app_latency}"
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
    name = join(local.app_name," success rate")
    description = "Proportion of requests that are served without errors."

    events {
        account_id = var.m_nr_account_id
        valid_events {
            from = "Transaction"
            where = "appName LIKE '${local.app_name}' AND (transactionType='Web') ${var.m_service_level_filter}"
        }
        good_events {
            from = "Transaction"
            where = "appName LIKE '${local.app_name}' AND (transactionType= 'Web') ${var.m_service_level_filter} AND error = false"
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
       values = [var.m_tenant_name]
   }

   tag {
       key = "team"
       values = [var.m_team_name]
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
       values = [var.m_tenant_name]
   }

   tag {
       key = "team"
       values = [var.m_team_name]
   }
} 


