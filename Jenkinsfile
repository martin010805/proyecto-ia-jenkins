pipeline {
    agent any 

    environment {
        DOCKER_USER = 'martin010805' // Pon tu usuario de Docker Hub aquí
        IMAGE_NAME  = 'agente-ia-entrega'
    }

    stages {
        stage('Install dependencies') {
            steps {
                echo 'Instalando herramientas de prueba...'
                // Instalamos pytest y flake8 antes de usarlos
                sh 'pip install flake8 pytest'
            }
        }

        stage('Linting & Testing') {
            steps {
                echo 'Validando código...'
                sh 'flake8 app/ --count --select=E9,F63,F7,F82 --show-source --statistics'
                sh 'pytest tests/'
            }
        }

        stage('Build Image') {
            steps {
                echo 'Construyendo imagen Docker...'
                // Nota: Esto requiere que el plugin Docker Pipeline esté instalado
                script {
                    docker.build("${DOCKER_USER}/${IMAGE_NAME}:latest")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub-credentials') {
                        docker.image("${DOCKER_USER}/${IMAGE_NAME}:latest").push()
                    }
                }
            }
        }
    }
}