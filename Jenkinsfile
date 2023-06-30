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

        stage('Build HTML') {
            steps {
                sh 'make html'
            }
        }

        stage('Generate Documentation') {
            steps {
                sh 'make html'
            }
        }
    }

    post {
        always {
            script {
                docker.image('nginx').inside('-v /usr/share/nginx/html:/usr/share/nginx/html') {
                    sh 'chmod -R 777 /usr/share/nginx/html'
                    sh 'cp -r ./jenkins_data/workspace/docsbuild/build/html/* /usr/share/nginx/html'
                    sh 'ls -al /usr/share/nginx/html'
                }
            }
        }
    }
}
