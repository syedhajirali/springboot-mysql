pipeline {
  environment {
    registry = "10.128.0.17:5000/syedhajirali/springboot-mysql" 
     dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
       git 'https://github.com/syedhajirali/springboot-mysql.git'
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
   
    
    stage('Deploy App to Kubernetes Cluster') {
      steps {
        script {
          kubernetesDeploy(configs: "/src/main/resources/springboot-mysql.yaml", kubeconfigId: "mykubeconfig")
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
