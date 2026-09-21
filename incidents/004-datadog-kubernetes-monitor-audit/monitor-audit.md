# Kubernetes Monitor Pack Audit

| ID | Monitor | Metric/Data Verified | Notification Verified | default_zero | Status |
|---|---|---|---|---|---|
| 263485473 | Pod is OOMKilled | No | No | Yes | Confirmed broken |
| 263485475 | Kubernetes Pods Restarting | TBD | TBD | TBD | Audit required |
| 263485471 | Pod is CrashLoopBackOff | TBD | TBD | TBD | Audit required |
| 263485472 | Pod is ImagePullBackOff | TBD | TBD | TBD | Audit required |
| 263485474 | Kubernetes Failed Pods in Namespaces | TBD | TBD | TBD | Audit required |
| 263485467 | Kubernetes Deployments Replica Pods | TBD | TBD | TBD | Audit required |
| 263485470 | Unschedulable Kubernetes Nodes | TBD | TBD | TBD | Audit required |
| 263485476 | Kubernetes StatefulSet Replicas | TBD | TBD | TBD | Audit required |

## Audit Requirements

For every monitor:

1. Record the monitor query.
2. Identify every underlying metric.
3. Query that metric independently.
4. Confirm data exists over an appropriate time range.
5. Confirm expected tags exist.
6. Review missing-data behavior.
7. Review use of default_zero().
8. Confirm the notification message contains a real destination.
9. Confirm the destination is monitored by humans.
10. Record recommended remediation.
