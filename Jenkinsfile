// @Library('jenkins-shared-library@main') _

// pipeline {
//     agent any

//     stages {
//         stage('Checkout') {
//             steps {
//                 checkout scm
//             }
//         }
//         stage('Run Checkov and Terraform') {
//             steps {
//                 script {
//                     def checkovPassed = checkovAndTerraform.runCheckovAndTerraform()
//                     if (!checkovPassed) {
//                         error('Checkov issues found. Stopping the pipeline.')
//                     }
//                 }
//             }
//         }
//     }

//     post {
//         failure {
//             script {
//                 echo 'Pipeline failed. Checkov issues found or other errors occurred.'
//             }
//         }
//         success {
//             script {
//                 echo 'Pipeline succeeded. Checkov passed. Team members can apply the Terraform plan manually.'
//             }
//         }
//     }
// }

@Library('jenkins-shared-library@main') _

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Install Checkov and Terraform') {
            steps {
                script {
                    checkovAndTerraform.installCheckovAndTerraform()
                }
            }
        }
        stage('Run Checkov and Terraform Plan') {
            steps {
                script {
                    def checkovPassed = false
                    try {
                        checkovAndTerraform.runCheckovAndTerraformPlan()
                        checkovPassed = true
                    } catch (Exception e) {
                        echo "Checkov failed: ${e.message}"
                    }
                    if (!checkovPassed) {
                        error('Checkov issues found. Stopping the pipeline.')
                    }
                }
            }
        }
        stage('Apply Terraform Plan') {
            when {
                expression {
                    return currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                script {
                    sh '''
                    echo "Applying Terraform plan"
                    terraform apply -auto-approve plan.out
                    '''
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
                echo 'Pipeline succeeded. Checkov passed. Terraform plan applied successfully.'
            }
        }
    }
}
