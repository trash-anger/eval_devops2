import jenkins.model.*
jenkins = Jenkins.instance
node {
   stage('Preparation') {
      checkout scm
   }
   stage('docker build/push') {
      docker.withRegistry('https://index.docker.io/v1/', 'docker-hub') {
         def app = docker.build("trashanger/devops2:${BRANCH_NAME}", '.').push()
      }
   }
}
