# Grafana Dashboards Starters

## Node Exporter Full

Dashboard: [Node Exporter Full](https://grafana.com/dashboards/1860)
Requires node-exporter. Install using the following helm command.
```bash
helm install --namespace kube-system --name node-exporter stable/prometheus-node-exporter
```