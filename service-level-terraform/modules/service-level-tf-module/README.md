# Service level Terraform module

Creates a latency service level and a success rate service level along with corresponding tags. 

Variables:
* m_nr_account_id - New Relic account id to invoke terraform against
* m_app_latency - Application latency threshold in seconds
* m_app_string - String that identifies app function
* m_service_level_filter - Filters specific transactions associated with an app. Use this to include or exclude transactions
* m_team_names - Team name(s) to use in tagging
* m_tenant - Tenant to create service levels for. Example: ml100
