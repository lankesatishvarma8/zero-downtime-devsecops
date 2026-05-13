# DevSecOps: Zero Downtime CI/CD Pipeline for FinTech

A complete enterprise-grade DevSecOps CI/CD pipeline implementation showcasing zero-downtime deployments, automated security scanning, monitoring, and strict compliance governance.

## 🚀 Features
- **Zero Downtime Deployments**: Kubernetes Rolling Updates, Blue/Green, and Canary strategies.
- **Shift-Left Security**: SonarQube (SAST), OWASP Dependency Check, Trivy (Container Scanning).
- **Comprehensive Monitoring**: Prometheus & Grafana dashboards.
- **FinTech Compliance**: Mapped to PCI-DSS v4.0 and SoD requirements.
- **Automated Rollbacks**: Health check validation with automated Kubernetes rollbacks on failure.

## 📂 Project Structure
- `/app`: Spring Boot FinTech application source code and Dockerfile.
- `/kubernetes`: Kubernetes deployment, service, ingress, and deployment strategy manifests.
- `/scripts`: Automation scripts for deployment, rollback, and health checks.
- `/monitoring`: Prometheus configuration and Grafana dashboards.
- `/docs`: Detailed architecture, compliance, and deployment documentation.
- `Jenkinsfile`: Complete CI/CD pipeline definition.

## 🛠️ Architecture
![Architecture Diagram](architecture-diagram.png)

## 📖 Quick Start

### 1. Local Development
Run the application and monitoring stack locally:
```bash
docker-compose up -d
```

### 2. CI/CD Pipeline
Configure your Jenkins server to point to this repository and execute the `Jenkinsfile`.
Prerequisites for Jenkins:
- Maven & JDK 17 installed
- Docker installed and configured
- SonarQube plugin configured
- Kubernetes credentials (`k8s-kubeconfig`) securely stored in Jenkins

### 3. Kubernetes Deployment
To manually deploy to your cluster:
```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/ingress.yaml
```

## 📑 Documentation
- [Architecture Overview](docs/architecture.md)
- [Deployment Strategy](docs/deployment-strategy.md)
- [Compliance Mapping](docs/compliance-report.md)
- [Testing Report](docs/testing-report.md)

## 🔒 Security Posture
- Container runs as non-root user.
- Automated gates block High/Critical vulnerabilities.
- Liveness/Readiness probes ensure traffic is only routed to healthy pods.
