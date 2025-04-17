pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'SonarQubeServer'  // The name of the SonarQube server configured in Jenkins
        SONAR_TOKEN = 'sqp_6b5434b57a577be89d2879a435a0e7917efea3d2' // Store the token securely
        IMAGE_NAME = 'villeaku/InclassSprint7'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/kurivill/Sprint7_1_inclass.git'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
                    steps {
                        bat 'docker build -t %IMAGE_NAME%:%IMAGE_TAG% .'
                    }
                }

        stage('Login to Docker') {
                steps {
                    withCredentials([usernamePassword(credentialsId: 'DOCKERHUB_CREDENTIALS', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        script {
                        bat 'echo %PASSWORD% | docker login --username %USERNAME% --password-stdin'
                        }
                        }
                    }
                }

        stage('Push Docker Image') {
            steps {
                            bat "docker push $IMAGE_NAME:$IMAGE_TAG"
                        }
                    }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQubeServer') {
                    bat """
                        sonar-scanner ^
                        -Dsonar.projectKey=InclassSprint7 ^
                        -Dsonar.sources=src ^
                        -Dsonar.projectName=InclassSprint7 ^
                        -Dsonar.host.url=http://localhost:9000 ^
                        -Dsonar.login=${env.SONAR_TOKEN} ^
                        -Dsonar.java.binaries=target/classes
                    """
                }
            }
        }

    }
}
