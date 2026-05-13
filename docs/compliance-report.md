# Compliance & Governance Report

Our DevSecOps pipeline aligns with strict FinTech regulatory standards, including PCI-DSS v4.0 and RBI guidelines.

## Separation of Duties (SoD)
- Developers only have access to code repositories and development environments.
- CI/CD pipelines automate deployment to production; developers do not have direct access to K8s production clusters.

## Least Privilege
- Docker containers run as a non-root user (`USER spring:spring`).
- Kubernetes RBAC strictly limits the permissions of the Jenkins service account.

## Vulnerability Management (PCI-DSS Req 6.3)
- Automated scanning using Trivy for Docker containers and OWASP Dependency Check for libraries.
- Any Critical or High vulnerability automatically fails the CI/CD pipeline.

## Audit Logging
- All Jenkins pipeline runs are archived.
- Kubernetes audit logs are enabled to track API access.
- Application logs are aggregated and searchable.
