## Verified Local Metric

Metric:

`kube_pod_container_status_restarts_total`

The metric was verified in Grafana Explore before creating an alert.

A real namespace filter returned telemetry.

Example:

`namespace="kube-system"`

A deliberately nonexistent namespace returned No Data.

Example:

`namespace="this-namespace-does-not-exist"`

This demonstrated that:

`0 != No Data`

A zero value represents an observed metric with a zero value.

No Data represents the absence of a matching telemetry series.
