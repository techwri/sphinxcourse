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

        stage('Build Html') {
            steps {
                sh 'make html'
            }
        }

        stage('Generate Documentation') {
            steps {
                sh 'make html'  // замените на команду генерации документации
            }
        }
    }

    post {
        always {
            script {
                docker.image('nginx').inside {
                    sh 'cp -r /jenkins_data/workspace/docsbuild/build/html/* /usr/share/nginx/html'
                    sh 'ls -al /usr/share/nginx/html'
                }
            }
        }
    }
}
