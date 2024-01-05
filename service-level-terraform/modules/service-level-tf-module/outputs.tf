output "latency_service_level_guid" {
   value = newrelic_service_level.latencyServiceLevel.sli_guid
}

output "success_service_level_guid" {
   value = newrelic_service_level.successServiceLevel.sli_guid
}

