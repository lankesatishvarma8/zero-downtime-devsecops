# Deployment Strategy

To achieve **Zero Downtime**, we implement Blue-Green and Canary deployment strategies in Kubernetes.

## 1. Rolling Update (Default)
Our standard `deployment.yaml` utilizes Kubernetes' native `RollingUpdate` strategy:
- `maxSurge`: 1
- `maxUnavailable`: 0
This guarantees that an old pod is not terminated until a new pod is ready to accept traffic, verified via `readinessProbe`.

## 2. Blue-Green Deployment
For major releases, we use a Blue-Green deployment to minimize risk.
- **Blue Environment**: Currently running production version.
- **Green Environment**: New version deployed alongside Blue.
- **Traffic Switch**: Once Green is tested and validated, the `service.yaml` is updated to point to the Green deployment's label (`version: green`).
- **Rollback**: If issues occur, traffic is instantly reverted to Blue.

## 3. Canary Deployment
For gradual rollouts, a Canary deployment is used.
- A small percentage of traffic (e.g., 5-10%) is routed to the new version (`track: canary`).
- We monitor metrics via Prometheus/Grafana.
- If error rates remain low, the new version is fully rolled out.

## 4. Zero Downtime Database Migration (Expand-Contract)
Database updates are backward-compatible:
- Phase 1 (Expand): Add new columns/tables. Old application ignores them.
- Phase 2 (Migrate): Code is updated to read/write to the new columns/tables.
- Phase 3 (Contract): After full deployment, drop the old columns.
