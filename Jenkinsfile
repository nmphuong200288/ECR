pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="835776587202"
        AWS_DEFAULT_REGION="ap-southeast-2"
        IMAGE_REPO_NAME="jenkin-pipeline-build-demo"
        IMAGE_TAG="latest"
	    REMOTE_USER="ubuntu"
        REMOTE_HOST="13.239.140.156"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
   
    stages {
        
         stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
                 
            }
        }
        
        stage('Cloning Git') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '131bcdad-2847-47dc-ac4c-b1e3fc90b90b', url: 'https://github.com/nmphuong200288/ECR.git']])     
            }
        }
  
    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
                sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
         }
        }
      }
    stage ('Deploy') {
        steps {
            sh 'sudo chmod +x deploy.sh'
            sh 'sudo ./deploy.sh'
        }  
    }
  }
}
