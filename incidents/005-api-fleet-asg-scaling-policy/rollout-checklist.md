# API Fleet Rollout Checklist

## Purpose

This checklist covers the production verification required after implementing RFC #30.

The local Incident #005 lab validates the target-tracking policy, target-group configuration, and Auto Scaling group metrics.

Production blue/green behavior cannot be proven by the local lab and must be verified during the first production release after the change.

## Before Release

Confirm the source Auto Scaling Group has:

- one TargetTrackingScaling policy
- ASGAverageCPUUtilization as the predefined metric
- target value of approximately 55%
- EstimatedInstanceWarmup explicitly configured
- no legacy SimpleScaling CPU policies
- Auto Scaling group metrics enabled

Confirm the target group uses:

`least_outstanding_requests`

## Blue/Green Release

During the first CodeDeploy blue/green deployment after the change:

1. Identify the existing blue Auto Scaling Group.
2. Identify the newly cloned green Auto Scaling Group.
3. Confirm the target-tracking policy was copied to the green ASG.
4. Confirm the green policy uses ASGAverageCPUUtilization.
5. Confirm the target value remains approximately 55%.
6. Confirm EstimatedInstanceWarmup is preserved.
7. Confirm no legacy SimpleScaling policies reappear.
8. Observe green desired capacity while the fleet is pre-traffic.
9. Confirm no premature scale-in interferes with deployment.
10. Complete traffic cutover only after the green fleet is healthy.

## After Cutover

Verify:

- green instances remain healthy
- desired capacity responds normally to CPU demand
- the fleet is no longer permanently pinned near maximum capacity
- scale-in occurs conservatively after demand falls
- no unexpected scaling activity occurred during deployment
- GroupDesiredCapacity is visible in CloudWatch
- GroupInServiceInstances is visible in CloudWatch

## Production Evidence Required

Capture:

- source ASG scaling policy configuration
- green ASG scaling policy configuration
- deployment timeline
- scaling activity during deployment
- desired-capacity history
- in-service-instance history

## Lab Boundary

The local lab does not claim that CodeDeploy COPY_AUTO_SCALING_GROUP behavior has been verified for the production target-tracking policy.

That verification remains a required production rollout step.
