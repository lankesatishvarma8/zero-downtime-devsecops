# Compliance Mapping for FinTech Application

| Compliance Standard | Requirement | Implementation in Pipeline |
| ------------------- | ----------- | -------------------------- |
| **PCI-DSS v4.0**    | 6.2 - Secure Software Development | Implemented SAST (SonarQube) and DAST in CI/CD pipeline. |
| **PCI-DSS v4.0**    | 6.3 - Vulnerability Management | Automated scanning with Trivy (Containers) and OWASP Dependency Check. |
| **RBI Guidelines**  | Access Control & Least Privilege | Non-root users enforced in Dockerfile (`USER spring:spring`). |
| **SoD**             | Separation of Duties | CI/CD pipeline automates deployment to production (No manual access). |
| **Audit Logging**   | Log aggregation | All Jenkins executions and Kubernetes audit logs are collected centrally. |
| **Data Protection** | Encryption in Transit | Nginx Ingress enforces HTTPS (TLS termination). |
