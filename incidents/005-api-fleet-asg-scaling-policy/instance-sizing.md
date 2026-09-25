# API Fleet Instance Sizing Evaluation

## Purpose

RFC #30 separates the scaling-policy fix from the final instance-size decision.

The policy defect should be corrected first.

Instance sizing should then be selected using measured canary behavior rather than changing both scaling behavior and fleet shape without evidence.

## Current Production Type

`m5.large`

- 2 vCPU
- 8 GB RAM

## Candidate 1 — m8i.large

Characteristics:

- 2 vCPU
- 8 GB RAM
- newer generation than m5
- like-for-like memory capacity
- lower migration risk

Advantages:

- preserves the current memory envelope
- simple comparison against m5.large
- newer CPU generation
- avoids reducing RAM

Tradeoff:

- retains roughly the same per-instance fleet model

## Candidate 2 — c8i.xlarge

Characteristics:

- 4 vCPU
- 8 GB RAM
- compute-optimized
- preserves the current 8 GB memory capacity

Advantages:

- additional CPU capacity per instance
- potential reduction in total instance count
- fewer instances may reduce fixed per-host agent overhead

Tradeoffs:

- larger change to fleet shape
- higher per-instance capacity
- requires careful canary measurement before rollout

## Rejected Candidate — c8i.large

`c8i.large` is not a current candidate.

The production memory investigation found that the existing 8 GB hosts reached a worst-case usable-memory floor of approximately 2.08 GB.

Reducing total RAM to 4 GB would therefore remove too much verified memory headroom.

## Canary Plan

Do not select a production winner based on the local Incident #005 workload.

Canary the approved candidate against the existing production fleet.

Compare:

- CPU utilization
- usable memory
- swap usage
- TargetResponseTime
- request throughput
- error rate
- instance count
- scaling activity
- fixed per-instance monitoring/security overhead

The canary should run through representative traffic, including peak traffic.

## Decision Rule

Prefer `m8i.large` when the priority is a lower-risk, like-for-like modernization with the existing 8 GB memory envelope.

Evaluate `c8i.xlarge` when production canary data demonstrates that fewer larger instances provide better CPU headroom and operational efficiency without degrading response time or scaling behavior.

## Current Status

`m8i.large` and `c8i.xlarge` remain production canary candidates.

The local lab does not select a winner because it does not reproduce production traffic or per-host agent overhead.
