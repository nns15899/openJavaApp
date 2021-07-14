pipeline {
    agent any
    environment{
        registry = "986413879559.dkr.ecr.ap-south-1.amazonaws.com/pipeline-predators"
    }
        stages {
            stage('Checkout'){
                steps{
                    checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/nns15899/openJavaApp.git']]])

                }
            }
            stage('Building'){
                steps{
                    script{
                        dockerImage = docker.build registry
                    }
                }
            }
            stage('Pushing to ECR') {
                steps{  
                    script {

                        sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 986413879559.dkr.ecr.ap-south-1.amazonaws.com'
                        sh 'docker push 986413879559.dkr.ecr.ap-south-1.amazonaws.com/pipeline-predators:v1'
                    }
                }
            }
            // Stopping Docker containers for cleaner Docker run
            stage('stop previous containers') {
                steps {
                    sh 'docker ps -f name=myContainer -q | xargs --no-run-if-empty docker container stop'
                    sh 'docker container ls -a -fname=myContainer -q | xargs -r docker container rm'
                }
            }
            stage('Docker Run') {
                steps{
                    script{
                        sh 'docker run -d -p 8096:5000 --rm --name myContainer 986413879559.dkr.ecr.ap-south-1.amazonaws.com/pipeline-predators:v1'
                    }
                }
            }
            
        }

    
        post{
            always{
                cleanWs()
            }
        }

}