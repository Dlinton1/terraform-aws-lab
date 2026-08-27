# Incident Lab 001 — PHP-FPM Worker Saturation Observability

## Scenario

This lab reproduces a PHP-FPM worker saturation condition in which all available PHP-FPM workers become busy and incoming requests begin queueing.

The purpose of the lab was to understand how PHP-FPM worker exhaustion can create a customer-facing outage while traditional container/process monitoring still reports the application infrastructure as running.

The second goal was to implement Datadog observability capable of detecting capacity pressure before full worker exhaustion.

## Architecture

```text
Client
  |
  v
NGINX
  |
  v
PHP-FPM
  |
  +-- Worker Pool
  |
  v
PHP-FPM Status Endpoint
  |
  v
Datadog Agent
  |
  v
Datadog Metrics
  |
  +-- Monitors
  |
  +-- Dashboard
