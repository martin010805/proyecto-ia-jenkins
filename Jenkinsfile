pipeline {
    agent any

    environment {
        DOCKER_USER = 'tu_usuario_dockerhub' // Cambia esto por tu usuario real
        IMAGE_NAME  = 'agente-ia-entrega'
    }

    stages {
        stage('Linting & Testing') {
            steps {
                echo 'Validando código y ejecutando tests...'
                // Instalamos herramientas de prueba
                sh 'pip install flake8 pytest'
                // Revisión de errores de sintaxis
                sh 'flake8 app/ --count --select=E9,F63,F7,F82 --show-source --statistics'
                // Ejecución del test que creaste en la carpeta tests/
                sh 'pytest tests/'
            }
        }

        stage('Build Image') {
            steps {
                echo 'Construyendo imagen Docker...'
                sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Subiendo imagen...'
                script {
                    // Recuerda que en Jenkins crearás la credencial con este ID
                    docker.withRegistry('', 'docker-hub-credentials') {
                        sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Simulated Deploy') {
            steps {
                echo 'Desplegando contenedor de prueba...'
                // Borra el anterior si existe y corre el nuevo
                sh "docker rm -f test-container || true"
                sh "docker run -d --name test-container ${DOCKER_USER}/${IMAGE_NAME}:latest"
                sh "docker ps | grep test-container"
            }
        }
    }
}