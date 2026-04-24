pipeline {
    agent any 

    environment {
        DOCKER_USER = 'martin010805'
        IMAGE_NAME  = 'agente-ia-entrega'
    }

    stages {
        stage('Linting & Testing') {
            agent {
                // Esto descarga una imagen de Python limpia para los tests
                docker { image 'python:3.9-slim' }
            }
            steps {
                echo 'Validando código...'
                sh 'pip install flake8 pytest'
                sh 'flake8 app/ --count --select=E9,F63,F7,F82 --show-source --statistics'
                sh 'pytest tests/'
            }
        }

        stage('Build & Push') {
            steps {
                echo 'Construyendo imagen final...'
                script {
                    // Usamos el socket de Docker de tu Windows
                    docker.withRegistry('', 'docker-hub-credentials') {
                        def customImage = docker.build("${DOCKER_USER}/${IMAGE_NAME}:latest")
                        customImage.push()
                    }
                }
            }
        }
    }
}