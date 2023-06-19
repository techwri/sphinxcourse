pipeline {
  agent {
    docker {
      image 'python:3'
      args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
  }

  stages {
    stage('Build') {
      steps {
        sh 'pip install --upgrade pip'
        sh 'pip install sphinx sphinx_rtd_theme'
        sh 'make html -C ./build'
      }
    }

    stage('Publish') {
      steps {
        sh 'docker-compose up -d site_documentation'
      }
    }
  }

  post {
    always {
      sh 'docker-compose down'
    }
  }
}
