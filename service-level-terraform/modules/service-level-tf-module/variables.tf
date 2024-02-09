# 
# Variables required for running this module. 
# Module variables are prefixed with 'm_' for 'module_'. 
#
# m_nr_account_id
# m_app_latency
# m_app_string
# m_service_level_filter
# m_team_names

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

# Application root
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


