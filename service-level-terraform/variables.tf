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
# List of services comes from this dashboard: https://onenr.io/0VjYqNebvj0
# Make sure to filter for the intended client
#
variable "target_services" {
    type = list(string) 
    default = [
    "3pi-tracking-fourkites", 
    "clientexceptions",
    "driver-microservices",
    "incidents",
    "linkedroutes",
    "macropoint",
    "power-microservices", 
    "saved-filters",
    "seer",
    "service-tolerance",
    "stopevents",
    "tasks",
    "timelineevents",
    "tracking",
    "trackingeta (.NET)",
    "trailer-microservices", 
    "trucker-tools"]
}


# 
# Target SLO values come from https://onenr.io/0oQDz8G84Ry
# Make sure to put them in the same order as the services up above
#
# Probably need to turn this into a map ..
variable "target_latency_slos" {
     type = list(number)
     default = [ 
     0.561,
     0.00192,
     0.461,
     0.148,
     0.523,
     1.531,
     0.461,
     0.0645,
     0.0518,
     0.00745,
     0.516,
     0.00192,
     0.516,
     0.461,
     0.414, 
     0.516, 
     0.516]
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
