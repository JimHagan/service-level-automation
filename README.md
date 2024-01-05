# mastery-service-levels
Service level automation terraform and dashboard for Mastery

This repository contains the following: 

An export of the dashboard we set up in Mastery's account. 
Using the tenant filter, a user can see the boundary services. 
On the second tab they can see the 95th percentile response time of boundary services across multiple tenants. The baseline is calculated using:
* The 95th percentile
* The last 2 weeks of data
* A filter that excludes health checks
* A formula that approximates the best compliance for 2 hour window evaluations

Terraform scripts that can be used to create latency and success service levels for each boundary service for a tenant. 
