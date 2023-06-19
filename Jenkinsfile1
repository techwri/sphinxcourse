pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                git branch: 'develop', url: 'https://github.com/techwri/sphinxcourse.git'
            }
        }

        stage('Install dependencies') {
            steps {
                sh 'pip3 install -r requirements.txt'
            }
        }

        stage('Build') {
            steps {
                sh 'make html'
            }
        }
    }

    post {
        always {
            script {
                docker.image('nginx').inside {
                    sh 'cp -r build/html/* /usr/share/nginx/html'
                }
            }
        }
    }
}
