pipeline {
    agent any
    environment{
        registry = "986413879559.dkr.ecr.us-east-1.amazonaws.com/pipeline-predators"
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
            stage('logging and tagging'){
                steps{
                    script{
                        sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 986413879559.dkr.ecr.ap-south-1.amazonaws.com'
                        echo 'login to aws success !' 
                        echo 'Pushing my image'
                        sh 'docker tag pipeline-predators:latest 986413879559.dkr.ecr.ap-south-1.amazonaws.com/pipeline-predators'
                        sh 'docker push 986413879559.dkr.ecr.ap-south-1.amazonaws.com/pipeline-predators'
                                              
                    }
                }
            }
            stage('Docker Run'){
                steps{
                    sh 'docker run -d -p 8096:5000 986413879559.dkr.ecr.ap-south-1.amazonaws.com/pipeline-predators'
                }
            }
            
        }

    
        post{
            always{
                cleanWs()
            }
        }

}