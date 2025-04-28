// pipeline
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                git 'https://github.com/user/repo.git'
                sh 'mvn clean package'

            }
            
        }
    
        stage('Test') {
            steps {
            sh 'mvn test'
            sh 'mvn verify'
            }
        }
        stage('Run') {
            steps {
            sh 'java -jar target/my-app.jar'
            }
        }
        stage('Deploy') {
            steps {
            sh 'scp target/my-app.jar user@prod-server:/path/to/deploy'
            sh 'ssh user@prod-server "java -jar /path/to/deploy/my-app.jar"'
            }
        }
    }    
}