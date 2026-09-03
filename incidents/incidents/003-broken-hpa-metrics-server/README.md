# Incident Lab 003 — Broken Kubernetes HPA / Missing Metrics Server

## Scenario

This lab reproduces a Kubernetes HorizontalPodAutoscaler that is configured correctly but cannot make scaling decisions because the Kubernetes Resource Metrics API is unavailable.

The scenario was modeled after an EKS environment where resource-based HPAs reported `<unknown>` CPU and memory targets because Metrics Server was not installed.

## Architecture

Pod
↓
Kubelet
↓
Metrics Server
↓
metrics.k8s.io
↓
HorizontalPodAutoscaler
↓
Deployment replica count

## Failure Reproduction

A Deployment and HorizontalPodAutoscaler were created before Metrics Server was installed.

The HPA was configured with CPU and memory resource targets.

While the application itself remained healthy, the HPA could not retrieve resource metrics.

Observed symptoms included:

- CPU target reported as `<unknown>`
- Memory target reported as `<unknown>`
- Resource metrics unavailable
- `kubectl top pods` failed
- `kubectl top nodes` failed
- HPA could not make resource-based scaling decisions

## Root Cause

Resource-based HorizontalPodAutoscalers rely on the Kubernetes `metrics.k8s.io` API.

That API is provided by Metrics Server.

Without Metrics Server, an HPA may exist and appear correctly configured while being unable to calculate desired replica counts from CPU or memory usage.

## Fix

Metrics Server was installed into the `kube-system` namespace using the upstream Helm chart.

For the local Kind environment, the following test-specific option was required:

`--kubelet-insecure-tls`

This option should not automatically be copied to production. Production kubelet certificate and networking configuration should be validated before changing Metrics Server TLS or address-selection behavior.

## Verification

After installing Metrics Server:

- `v1beta1.metrics.k8s.io` registered successfully
- Metrics APIService reported Available
- `kubectl top nodes` returned CPU and memory values
- `kubectl top pods` returned CPU and memory values
- HPA targets changed from `<unknown>` to actual utilization percentages
- HPA ScalingActive became true

## Autoscaling Test

Continuous requests were generated against the test application.

CPU usage increased above the configured HPA target.

The HPA increased the Deployment replica count from its configured minimum toward the configured maximum.

This demonstrated the complete resource autoscaling pipeline:

Traffic
→ CPU utilization
→ kubelet
→ Metrics Server
→ metrics.k8s.io
→ HPA
→ Deployment scaling

## Operational Risk

Installing Metrics Server can immediately activate previously non-functional HPAs.

Existing HPA configuration should therefore be reviewed before enabling resource metrics in an established production cluster.

Important configuration to audit includes:

- minReplicas
- maxReplicas
- CPU utilization targets
- memory utilization targets
- resource requests
- cluster scheduling capacity

Thresholds that have existed for a long time without functional metrics may never have been tested against real production traffic.

## Metrics Server vs Monitoring Platform

Metrics Server supplies current Kubernetes resource metrics used by autoscaling and commands such as `kubectl top`.

A monitoring platform such as Datadog provides historical observability, dashboards, and alerting.

Having CPU and memory metrics in a monitoring platform does not automatically provide the `metrics.k8s.io` API required by Kubernetes resource-based HPAs.

## Production Follow-Up

The local lab demonstrates the failure mechanism but does not confirm production EKS configuration.

Production work would still require:

- selecting the Metrics Server deployment method
- confirming compatibility with the EKS Kubernetes version
- validating kubelet certificate/network configuration
- checking whether additional Metrics Server flags are actually required
- auditing every existing HPA
- validating resource requests
- reviewing maxReplicas values
- testing autoscaling safely after Metrics Server deployment
