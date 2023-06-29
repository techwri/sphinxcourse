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

        stage('Build HTML') {
            steps {
                sh 'make html'
            }
        }

        stage('Run Docker Container') {
            steps {
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                    script {
                        def dockerImage = docker.image('nginx')
                        def container = dockerImage.run('-p', '8000:80', '-d')
                        container.inside {
                            sh 'cp -r /var/jenkins_home/workspace/docsbuild/build/html/* /var/jenkins_data/html'
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
