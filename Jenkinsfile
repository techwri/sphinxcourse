pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        sh 'docker run --rm -v $PWD:/docs -w /docs python:3 pip install --upgrade pip'
        sh 'docker run --rm -v $PWD:/docs -w /docs python:3 pip install sphinx sphinx_rtd_theme'
        sh 'docker run --rm -v $PWD:/docs -w /docs python:3 make html -C build'
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
