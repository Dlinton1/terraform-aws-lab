# Incident #005 — API Fleet ASG Scaling Policy

## Scenario

This lab is based on RFC #30: API Fleet Scaling Policy Fix + Instance Sizing.

The production API Auto Scaling Group was observed operating near maximum capacity for most of the measured period.

Investigation identified a scaling-policy dead band.

The legacy configuration used separate SimpleScaling policies:

- scale out above 60% average CPU
- scale in below 30% average CPU

Normal CPU frequently operated between those thresholds, allowing the fleet to scale upward while making scale-in difficult.

## Objective

Reproduce the infrastructure design safely and implement the approved scaling architecture using Terraform.

No RentVine production infrastructure is modified by this lab.

## Architecture

Application Load Balancer
→ Target Group
→ Auto Scaling Group
→ Launch Template
→ EC2 instances

Scaling:

ASGAverageCPUUtilization
→ TargetTrackingScaling
→ 55% target
→ explicit instance warmup

Observability:

Auto Scaling Group
→ AWS/AutoScaling
→ GroupDesiredCapacity
→ GroupInServiceInstances

## Changes Implemented

### Target Tracking

The lab uses one TargetTrackingScaling policy instead of separate SimpleScaling scale-up and scale-down policies.

Predefined metric:

`ASGAverageCPUUtilization`

Target:

`55%`

Instance warmup is explicitly configured.

### Load Balancing

The target group uses:

`least_outstanding_requests`

rather than:

`round_robin`

Slow start is not enabled.

### Auto Scaling Metrics

Native Auto Scaling group metrics are enabled at one-minute granularity.

This includes fleet-size metrics such as:

- GroupDesiredCapacity
- GroupInServiceInstances
- GroupPendingInstances
- GroupTotalInstances

### Infrastructure as Code

The complete lab configuration is Terraform-managed.

This demonstrates the desired ownership model while acknowledging that the production ASG currently requires a separate Terraform adoption/backport decision.

## Instance Sizing

The production candidates remain:

- `m8i.large`
- `c8i.xlarge`

The local lab intentionally uses an inexpensive instance type and does not attempt to select the production winner.

The production decision requires representative canary traffic and production CPU, memory, response-time, and fleet-size measurements.

See:

`instance-sizing.md`

## Blue/Green Verification

The production fleet uses CodeDeploy blue/green deployments with Auto Scaling Group copying.

The local lab does not claim to verify that production behavior.

The first production release after the policy change must confirm that the target-tracking policy is copied to the green ASG and does not cause premature scale-in.

See:

`rollout-checklist.md`

## Ticket Mapping

| Scope | Local Result |
|---|---|
| Replace SimpleScaling with ~55% target tracking | Implemented and locally verifiable |
| Explicit EstimatedInstanceWarmup | Implemented and locally verifiable |
| least_outstanding_requests | Implemented and locally verifiable |
| ASG group metrics | Implemented and locally verifiable |
| Blue/green policy-copy behavior | Requires production verification |
| m8i.large vs c8i.xlarge | Requires production canary |
| Terraform ownership | Local model implemented; production decision required |

## Key Lesson

The original problem was not simply that the fleet needed more instances.

Scaling policy thresholds must match real workload behavior.

A fleet can have functioning alarms and still behave poorly when its scaling rules create a utilization range where neither scale-in nor scale-out behavior produces the desired capacity.

Target tracking replaces that manually maintained threshold gap with a policy designed to keep the selected metric near an explicit utilization target.
