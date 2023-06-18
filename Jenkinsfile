pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                git 'https://github.com/techwri/sphinxcourse.git'
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
            sh 'cp -r build/html/* /var/www/html'
        }
    }
}
