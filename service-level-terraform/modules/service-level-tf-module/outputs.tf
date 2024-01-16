output "latency_service_level_id" {
   value = newrelic_service_level.latencyServiceLevel.sli_id
}

output "success_service_level_id" {
   value = newrelic_service_level.successServiceLevel.sli_id
}

output "latency_service_level_guid" {
   value = newrelic_service_level.latencyServiceLevel.sli_guid
}

output "success_service_level_guid" {
   value = newrelic_service_level.successServiceLevel.sli_guid
}

