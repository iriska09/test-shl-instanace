@Library('jenkins-shared-library@main') _

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Run Checkov and Terraform') {
            steps {
                script {
                    def checkovPassed = checkovAndTerraform.runCheckovAndTerraform()
                    if (!checkovPassed) {
                        error('Checkov issues found. Stopping the pipeline.')
                    }
                }
            }
        }
    }

    post {
        failure {
            script {
                echo 'Pipeline failed. Checkov issues found or other errors occurred.'
            }
        }
        success {
            script {
                echo 'Pipeline succeeded. Checkov passed. Team members can apply the Terraform plan manually.'
            }
        }
    }
}

