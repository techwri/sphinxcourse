pipeline {
    agent any

    options {
        skipDefaultCheckout()
    }

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

        stage('Run Docker Container') {
            steps {
                script {
                    docker.image('nginx').run('-p', '8000:80', '-d').inside {
                        sh 'cp -r /var/jenkins_home/workspace/docsbuild/build/html/* /var/jenkins_data/html'
                    }
                }
            }
        }
    }
}
