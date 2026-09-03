# Incident Lab 002 — API Scale-Out 502 / Shallow Health Check

## Scenario

This lab reproduces an API readiness failure where a web server can pass a shallow health check before the PHP application behind it is ready to serve traffic.

The scenario was modeled after an investigation into 5XX spikes occurring during API fleet scale-out events.

## Architecture

Production architecture being modeled:

CloudFront → ALB → NGINX → PHP-FPM → Application

Local lab:

curl → NGINX → PHP-FPM → PHP application

Docker is used only to reproduce the service boundaries locally.

## Failure Condition

The intentionally broken health endpoint was implemented directly in NGINX:

`/api/check.html`

NGINX returned HTTP 200 without contacting PHP-FPM.

This created the following state:

- NGINX running
- Health check returning 200
- PHP-FPM unavailable
- Real API requests returning 502

This demonstrates that a shallow NGINX health check can report a server as healthy even though the application cannot serve requests.

## Reproduction

With PHP-FPM stopped:

`/api/check.html`

returned:

HTTP 200

while:

`/api/`

returned:

HTTP 502 Bad Gateway

NGINX logs showed an upstream connection failure when attempting to reach PHP-FPM.

## Root Cause Pattern

Three readiness gaps were investigated:

1. Health check only validates NGINX
2. NGINX can become available before PHP-FPM/application readiness
3. Deployment completion can occur without validating a real application request

Together these can create a window where a new server appears healthy before the application is capable of serving traffic.

## Fix 1 — Application-Aware Health Check

The health endpoint was changed to execute a real PHP request.

After the change:

PHP available → health endpoint returns 200

PHP unavailable → health endpoint fails

This prevents NGINX availability from being mistaken for application readiness.

## Fix 2 — ValidateService

A validation script was created that repeatedly requests the PHP health endpoint.

The script:

- retries while the application is unavailable
- succeeds only after receiving HTTP 200
- exits non-zero if the application never becomes ready

This models a CodeDeploy ValidateService lifecycle hook.

## Fix 3 — Startup / Readiness

Starting PHP-FPM before NGINX reduces the readiness gap, but service startup alone does not guarantee application readiness.

A stronger pattern is:

1. Start PHP-FPM
2. Verify PHP-FPM/application readiness
3. Start or expose NGINX
4. Validate a real application request
5. Allow traffic

## Fix 4 — ALB Slow Start

AWS ALB target-group slow start can gradually increase traffic to newly healthy targets.

Slow start should be considered an additional safety mechanism rather than a replacement for accurate application health checks.

## HTTP Status Findings

The lab demonstrates why HTTP status code distribution is useful during investigation.

500 generally indicates that the application executed but encountered an internal error.

502 indicates that the gateway/proxy could not successfully communicate with its upstream application service.

During the simulated PHP-FPM outage, NGINX returned 502 because PHP-FPM could not serve the request.

## Key Lesson

A health check is a readiness promise.

Checking only whether NGINX is running does not prove that PHP-FPM or the application behind NGINX can serve customer traffic.

Health checks used for load-balancer routing should exercise enough of the application path to accurately represent whether a target is ready to receive traffic.

## Production Follow-Up

This local POC does not confirm production AWS configuration.

Production validation would still require checking:

- ALB HealthCheckPath
- target registration timing
- ALB access logs
- Auto Scaling HealthCheckGracePeriod
- target group slow_start configuration
- behavior of other application bundles sharing the same deployment pattern
