pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        BACKEND_IMAGE = "vedantchimote/studentsystembackend"
        FRONTEND_IMAGE = "vedantchimote/studentsystemfrontend"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Backend') {
            steps {
                dir('Backend') {
                    sh 'mvn clean package'
                }
            }
        }

        stage('Build Frontend') {
            steps {
                dir('Frontend') {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }

        stage('Build and Push Docker Images') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        def backendImage = docker.build("${BACKEND_IMAGE}:${env.BUILD_NUMBER}", "./Backend")
                        backendImage.push()
                        backendImage.push("latest")

                        def frontendImage = docker.build("${FRONTEND_IMAGE}:${env.BUILD_NUMBER}", "./Frontend")
                        frontendImage.push()
                        frontendImage.push("latest")
                    }
                }
            }
        }

        stage('Update Docker Compose') {
            steps {
                script {
                    sh """
                    sed -i 's|${BACKEND_IMAGE}:latest|${BACKEND_IMAGE}:${env.BUILD_NUMBER}|g' docker-compose.yml
                    sed -i 's|${FRONTEND_IMAGE}:latest|${FRONTEND_IMAGE}:${env.BUILD_NUMBER}|g' docker-compose.yml
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker stack deploy -c docker-compose.yml student-management-system'
            }
        }
    }

    post {
        always {
            sh 'docker system prune -af'
        }
    }
}