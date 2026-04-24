pipeline {
    agent any 

    environment {
        DOCKER_USER = 'tzuxsy'
        IMAGE_NAME  = 'agente-ia-entrega'
    }

    stages {
        stage('Build Image') {
            steps {
                echo 'Construyendo la imagen...'
                sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Usamos las credenciales ID 'docker-hub-credentials'
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USER')]) {
                        sh "echo \$DOCKER_HUB_PASSWORD | docker login -u \$DOCKER_HUB_USER --password-stdin"
                        sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }
    }
}