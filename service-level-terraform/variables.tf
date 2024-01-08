# 
# NR API Key
#
# You can input the api key when prompted or 
# 1. Create a secret.tfvars file
# 2. Add nr_api_key = "<value>"
# 3. Run terraform <command> -var-file "secret.tfvars" 
#

variable "nr_api_key" {
    description = "New Relic user api key"
    type = string
    sensitive = true
}

#
# NR Account ID
#
variable "nr_account_id" {
    description = "NR account id"
    type = number
    default = 0 
} 

#
# Service level filter - filter transactions to include or exclude 
#
variable "service_level_filter" {
    description = "transactions to include or exclude"
    type = string
    default = "AND request.uri NOT LIKE '/health%' AND request.uri NOT LIKE '/readiness' AND request.uri NOT LIKE '/liveness'"
}

# 
# Team names
#
variable "team_names" {
    description = "team names to use in tags"
    type = list(string)
    default = ["SRE"]
}

#
# Tenant - Use nomenclature in https://onenr.io/0oQDz8G84Ry
#
variable "tenant" {
    description = "Tenant to create service levels for. Example: ml100"
    type = string
    default = "ml100"
}

#
# The list of services comes from this dashboard: https://onenr.io/0VjYqNebvj0
# Make sure to filter for the intended client
#

variable "tenant_map" {
    type = map(object({
       app_string = string
       latency = number
    })) 
    default = {
       key1 = {
         app_string = "3pi-tracking-fourkites" 
         latency = 0.193
       }
       key2 = {
         app_string = "clientexceptions"
         latency = 0.00208
       }
       key3 = {
         app_string = "driver-microservices" 
         latency = 0.303
       }
       key4 = {
         app_string = "incidents"
         latency = 0.148
       }
       key5 = {
         app_string = "linkedroutes" 
         latency = 0.0208
       }
       key6 = {
         app_string = "macropoint"
         latency = 2.688
       }
       key7 = {
         app_string = "power-microservices" 
         latency = 0.42
       }
       key8 = {
         app_string = "saved-filters"
         latency = 0.0664
       }
       key9 = {
         app_string = "seer" 
         latency = 0.042
       }
       key10 = {
         app_string = "service-tolerance"
         latency = 0.00806
       }
       key11 = {
         app_string = "stopevents" 
         latency = 0.289
       }
       key12 = {
         app_string = "tasks"
         latency = 0.00186
       }
       key13 = {
         app_string = "timelineevents" 
         latency = 0.839
       }
       key14 = {
         app_string = "tracking"
         latency = 0.207
       }
       key15 = {
         app_string = "trackingeta (.NET)" 
         latency = 0.246
       }
       key16 = {
         app_string = "trailer-microservices"
         latency = 0.195
       }
       key17 = {
         app_string = "truckertools" 
         latency = 0.258
       }

    } /* End of default */
} 


