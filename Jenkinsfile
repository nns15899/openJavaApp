pipeline {
    agent "any"{

        stages {
            stage('Checkout'){
                steps{
                    checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/nns15899/openJavaApp.git']]])

                }
            }
            stage('Building'){
                steps{
                    script{
                        sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 986413879559.dkr.ecr.ap-south-1.amazonaws.com'
                        sh 'docker build -t pipeline-predators .'
                        sh 'Docker images built success !'
                    }
                }
            }
            stage('logging and tagging'){
                steps{
                    script{
                        sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 986413879559.dkr.ecr.ap-south-1.amazonaws.com'
                        echo 'login to aws success !' 
                        echo 'tagging my image'
                        sh 'docker tag pipeline-predators:latest 986413879559.dkr.ecr.ap-south-1.amazonaws.com/pipeline-predators:latest'                      
                    }
                }
            }
            stage('Pushing to ECR'){
                steps{
                    echo 'Now it is getting pushed'
                    sh 'docker push 986413879559.dkr.ecr.ap-south-1.amazonaws.com/pipeline-predators:latest'
                }
            }
            stage('Docker Run'){
                steps{
                    sh 'docker run -d -p 8096:5000 986413879559.dkr.ecr.ap-south-1.amazonaws.com/pipeline-predators:latest'
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