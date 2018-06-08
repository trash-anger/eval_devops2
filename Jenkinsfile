pipeline {
   stages {
      stage('Preparation') {
         checkout scm
      }
      stage('docker build/push') {
         docker.withRegistry('https://index.docker.io/v1/', 'docker-hub') {
            def app = docker.build("trashanger/devops2:${env.GIT_BRANCH}", '.').push()
         }
      }
   }
}
