## Kubernetes Project Test Cases

## Cluster Tests
| Test Case ID | Title | Steps | Expected Result |
|--------------|-------|-------|-----------------|
| CL-001 | Verify cluster nodes are healthy | Run `kubectl get nodes` | All nodes show status = Ready |
| CL-002 | Verify namespace exists | Run `kubectl get namespaces | grep db` | Namespace `db` is listed |
| CL-003 | Sanity check cluster access | Run `kubectl cluster-info` | Cluster info is displayed (API server and DNS reachable) |

## Storage Tests
| Test Case ID | Title | Steps | Expected Result |
|--------------|-------|-------|-----------------|
| ST-001 | Verify PersistentVolume is bound | Run `kubectl get pv | grep Bound` | PV shows status = Bound |
| ST-002 | Verify PVC is attached | Run `kubectl get pvc -n db | grep Bound` | PVC shows status = Bound |

## Database Tests
| Test Case ID | Title | Steps | Expected Result |
|--------------|-------|-------|-----------------|
| DB-001 | Verify PostgreSQL pod is running | Run `kubectl get pods -n db | grep postgres` | Pod status = Running |
| DB-002 | Verify DB connection | Run `kubectl -n db exec deploy/postgres -- psql -U Naga -c "SELECT 1"` | Query returns `1` |

## Application Tests
| Test Case ID | Title | Steps | Expected Result |
|--------------|-------|-------|-----------------|
| APP-001 | Verify service exposes app | Run `kubectl get svc -n db | grep python-app-service` | Service is listed |
| APP-002 | Verify app responds via port-forward | 1. Run `kubectl port-forward svc/python-app-service -n db 5000:5000` 2. Run `curl http://localhost:5000/` | App returns valid response |
| APP-003 | Verify app inserts data into DB | 1. Run `curl http://localhost:5000/add?record=test` 2. Run `kubectl -n db exec deploy/postgres -- psql -U Naga -d db -c "SELECT * FROM records WHERE name='test'"` | Record `test` is found in DB |

