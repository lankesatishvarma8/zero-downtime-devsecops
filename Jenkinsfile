pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "fintech-app"
        DOCKER_TAG = "${env.BUILD_NUMBER}"
        REGISTRY = "my-docker-registry"
        SONAR_PROJECT = "fintech-app"
        KUBECONFIG_CRED_ID = "k8s-kubeconfig"
    }

    tools {
        maven 'Maven 3.9'
        jdk 'JDK 17'
    }

    stages {
        stage('Source Code Checkout') {
            steps {
                checkout scm
                echo "Source code checked out successfully."
            }
        }

        stage('Build Stage') {
            steps {
                dir('app') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Unit Testing') {
            steps {
                dir('app') {
                    sh 'mvn test'
                }
            }
            post {
                always {
                    junit 'app/target/surefire-reports/*.xml'
                }
            }
        }

        stage('Static Code Analysis (SAST)') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=${SONAR_PROJECT}'
                }
            }
        }

        stage('Dependency Vulnerability Scanning') {
            steps {
                dir('app') {
                    sh 'mvn org.owasp:dependency-check-maven:check'
                }
            }
        }

        stage('Docker Image Build') {
            steps {
                script {
                    dockerImage = docker.build("${REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}", "-f Dockerfile .")
                }
            }
        }

        stage('Container Vulnerability Scanning') {
            steps {
                sh "trivy image --severity HIGH,CRITICAL --format table -o trivy-report.txt ${REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}"
                archiveArtifacts artifacts: 'trivy-report.txt', allowEmptyArchive: true
            }
        }

        stage('Push to Registry') {
            steps {
                script {
                    docker.withRegistry('https://my-docker-registry', 'docker-credentials-id') {
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Kubernetes Deployment (Blue/Green)') {
            steps {
                withCredentials([file(credentialsId: "${KUBECONFIG_CRED_ID}", variable: 'KUBECONFIG')]) {
                    sh '''
                        export KUBECONFIG=$KUBECONFIG
                        ./scripts/deploy.sh ${REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}
                    '''
                }
            }
        }

        stage('Smoke Testing') {
            steps {
                sh './scripts/health-check.sh http://fintech-app.local/api/health'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Triggering automated rollback...'
            withCredentials([file(credentialsId: "${KUBECONFIG_CRED_ID}", variable: 'KUBECONFIG')]) {
                sh '''
                    export KUBECONFIG=$KUBECONFIG
                    ./scripts/rollback.sh
                '''
            }
        }
    }
}
