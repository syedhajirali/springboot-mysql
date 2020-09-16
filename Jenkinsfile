pipeline {
  environment {
    registry = "10.128.0.17:5000/syedhajirali/employee"
    registry_mysql = "10.128.0.17:5000/syedhajirali/mysql"
     dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
       git 'https://github.com/syedhajirali/employee.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( "" ) {
            dockerImage.push()
          }
        }
      }
    }
   
    stage('current') {
      steps{
        dir("${env.WORKSPACE}/mysql"){
          sh "pwd"
          }
      }
   }
   stage('Build mysql image') {
     steps{
        sh 'docker build -t "10.128.0.17:5000/syedhajirali/mysql:$BUILD_NUMBER"  "$WORKSPACE"/mysql'
        sh 'docker push "10.128.0.17:5000/syedhajirali/mysql:$BUILD_NUMBER"'
        }
      }
    stage('Deploy App to Kubernetes Cluster') {
      steps {
        script {
          kubernetesDeploy(configs: "employee.yaml", kubeconfigId: "mykubeconfig")
        }
      }
    }
	stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}
