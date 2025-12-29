# Kubernetes-Based DevOps DBA Project

## Overview
This project demonstrates my transition from a traditional DBA role to a DevOps-oriented DBA by building and validating a complete database and application workflow on Kubernetes.

The setup includes a containerized application, PostgreSQL with persistent storage, database versioning, CI/CD pipelines, and disaster recovery testing.

## Architecture
- Kubernetes (k3d) cluster with 1 control plane and 2 worker nodes
- Dedicated namespace for isolation
- Flask (Python) application deployed as a container
- PostgreSQL with Persistent Volumes backed by NFS
- Kubernetes Services for app-to-database communication
- GitHub Actions for CI/CD workflows

## Key Features
- PostgreSQL deployment with persistent storage and health probes
- Database schema and data versioning using Liquibase
- Environment-specific CI/CD workflows (app / infra / db / tests)
- End-to-end testing (API → DB insert → SQL verification)
- Secrets management using GitHub Secrets
- Disaster recovery testing via node drain and pod rescheduling

## Repository Structure
```text
.
├── app/        # Flask application & Dockerfile
├── infra/      # Kubernetes manifests
├── db/         # Liquibase changelogs
├── tests/      # End-to-end test scripts
└── .github/    # GitHub Actions workflows
