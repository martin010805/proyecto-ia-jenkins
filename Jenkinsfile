pipeline {
 
 environment {
    DOCKER_USER = 'tzuxsy' 
    IMAGE_NAME  = 'agente-ia-entrega'
}

    stages {
        stage('Limpieza') {
            steps {
                // Esto limpia intentos fallidos anteriores
                sh 'echo "Iniciando limpieza..."'
            }
        }

        stage('Build Image') {
            steps {
                echo 'Construyendo la imagen Docker directamente...'
                // Usamos comandos simples de shell
                sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Aquí usamos las credenciales que creaste en Jenkins
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USER')]) {
                        sh "echo \$DOCKER_HUB_PASSWORD | docker login -u \$DOCKER_HUB_USER --password-stdin"
                        sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }
    }
}