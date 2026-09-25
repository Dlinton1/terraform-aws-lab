# API Fleet ASG Scaling Policy Findings

## Incident

The production API fleet was observed running near its maximum Auto Scaling Group capacity for most of the measured period.

The investigation identified a scaling-policy dead band rather than a simple lack of fleet capacity.

## Existing Production Behavior

The production configuration described in the RFC uses two legacy SimpleScaling policies:

- Scale out when average CPU is greater than 60%.
- Scale in when average CPU is less than 30%.

Observed fleet-average CPU operated primarily between approximately 31% and 63%.

This creates a dead band between the scale-in and scale-out thresholds.

When utilization remains between those thresholds, neither policy provides a mechanism for returning the fleet toward an appropriate capacity.

The fleet can therefore scale upward during periods of high utilization and remain elevated when utilization later decreases but does not fall below the scale-in threshold.

## Approved Scaling Design

The approved design replaces the two SimpleScaling policies with one target-tracking policy.

Target metric:

`ASGAverageCPUUtilization`

Target:

`55%`

The implementation must also define instance warmup explicitly so newly launched instances are not immediately treated as fully representative of steady-state utilization.

## Load Balancing

The production target group currently uses:

`round_robin`

The approved design changes this to:

`least_outstanding_requests`

Least-outstanding-requests routing is intended to better distribute traffic when requests differ in processing cost.

ALB slow start is not part of the implementation because it cannot be used with the least-outstanding-requests algorithm.

## ASG Observability

Auto Scaling group metrics should be enabled so CloudWatch directly records fleet-size information including desired and in-service capacity.

This provides historical fleet-size telemetry without deriving capacity from unrelated metrics.

## Instance Sizing

The RFC narrowed the candidate instance types to:

- `m8i.large`
- `c8i.xlarge`

The smaller-memory `c8i.large` option was rejected based on verified production memory headroom.

Instance sizing remains a canary decision rather than something that should be changed simultaneously without measurement.

## Infrastructure Ownership

The production API ASG, launch template, and scaling policies are currently described as unmanaged by Terraform.

Infrastructure ownership must be resolved before or alongside the production implementation.

The local portfolio implementation uses Terraform intentionally so the desired configuration is reproducible and reviewable.

## Lab Boundary

This lab reproduces the infrastructure design and scaling-policy behavior in infrastructure owned by the lab.

It does not modify or claim to validate the RentVine production Auto Scaling Group.

Production blue/green behavior, production traffic characteristics, and final instance sizing require verification in the production environment.

## Terraform Ownership Decision

The local implementation intentionally manages the complete Incident #005 fleet configuration through Terraform.

This demonstrates the desired ownership model:

Terraform
→ Launch Template
→ Auto Scaling Group
→ Target Group
→ Scaling Policy
→ Group Metrics

The production RFC identifies that the existing production ASG, launch template, and scaling policies are currently unmanaged by Terraform.

The production team must therefore choose between:

1. importing/adopting the existing infrastructure into Terraform before changing it, or
2. performing the approved production change out-of-band and backporting the resulting configuration into Terraform afterward.

The local lab does not make that organizational ownership decision.

It demonstrates that the approved configuration can be represented declaratively in Terraform and kept under version control.
