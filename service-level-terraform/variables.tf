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
    default = "AND request.uri NOT LIKE '/health%'"
}

# 
# Team names
#
variable "team_names" {
    description = "team names to use in tags"
    type = list(string)
    default = ["SRE"]
}


variable "service_level_param_map" {
    type = map(object({
       app_string = string
       latency = number
    })) 
    default = {
       key1 = {
         app_string = "service_1" 
         latency = 1.0
       }
       key2 = {
         app_string = "service_2"
         latency = 1.0
       }

    } 
}


