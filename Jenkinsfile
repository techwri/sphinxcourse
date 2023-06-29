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
                        def containerId = ''
                        def dockerImage = 'nginx'
                        def containerName = 'my-container'

                        try {
                            containerId = docker.image(dockerImage).run("-p", "8000:80", "-d", "--name", containerName)

                            sh 'docker cp /var/jenkins_home/workspace/docsbuild/build/html/. ${containerId}:/var/www/html'
                        } finally {
                            sh "docker stop ${containerId}"
                            sh "docker rm ${containerId}"
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
