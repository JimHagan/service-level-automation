# 
# Variables required for running this module
#
# m_nr_account_id
# m_app_latency
# m_app_string
# m_service_level_filter
# m_team_names
# m_tenant

/*
variable "m_nr_api_key" {
    description = "New Relic user api key"
    type = string
    sensitive = true
}
*/

#
# New Relic account id to assign the service level to
#
variable "m_nr_account_id" {
    description = "New Relic account id to invoke terraform against"
    type = number 
    default = 0
}

#
# App Latency Threshold
#
variable "m_app_latency" {
    description = "Application latency threshold in seconds"
    type = number
}

#
# Application root
# Specific to Mastery, this is the string that can be combined with the tenant string to identify the app. 
# Examples are "3pi-tracking-fourkites" and "macropoint"
# 
variable "m_app_string" {
    description = "String that identifies app function"
    type = string
}

#
# Service Level Transaction Filter
#
variable "m_service_level_filter" {
    description = "Filters specific transactions associated with an app. Use this to include or exclude transactions"
    type = string
    default = "AND name NOT LIKE '%ping%'"
}

#
# Team names
#
variable "m_team_names" {
    description = "Team name(s) to use in tagging"
    type = list(string)
}

#
# Tenant - Use nomenclature in https://onenr.io/0oQDz8G84Ry
#
variable "m_tenant" {
    description = "Tenant to create service levels for. Example: ml100"
    type = string
}

