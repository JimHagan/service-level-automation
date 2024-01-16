# Service level and tag terraform module

This module creates a latency service level and a success rate service level for a service along with corresponding tags. 

New Relic resource definitions
* https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/service_level
* https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/entity_tags

Variables:
* m_nr_account_id - New Relic account id to invoke terraform against
* m_app_latency - Application latency threshold in seconds
* m_app_string - String that identifies app function
* m_service_level_filter - Filters specific transactions associated with an app. Use this to include or exclude transactions
* m_team_names - Team name(s) to use for service level tags. You can sort and filter by these tags in the New Relic UI
* m_tenant - Tenant to create service levels for. Example: ml100

Required: 
The [New Relic Provider Block](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/guides/provider_configuration) must be configured in the main module.

Outputs:
* latency_service_level_id
* success_service_level_id
* latency_service_level_guid
* success_service_level_guid
