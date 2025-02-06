// @Library('jenkins-shared-library@main') _

// pipeline {
//     agent any

//     stages {
//         stage('Checkout') {
//             steps {
//                 checkout scm
//             }
//         }
//         stage('Install Checkov') {
//             steps {
//                 script {
//                     checkovAndTerraform.installCheckov()
//                 }
//             }
//         }
//         stage('Run Checkov and Terraform Plan') {
//             steps {
//                 script {
//                     def checkovPassed = false
//                     try {
//                         checkovAndTerraform.runCheckovAndTerraformPlan()
//                         checkovPassed = true
//                     } catch (Exception e) {
//                         echo "Checkov failed: ${e.message}"
//                     }
//                     if (!checkovPassed) {
//                         error('Checkov issues found. Stopping the pipeline.')
//                     }
//                 }
//             }
//         }
//         stage('Apply Terraform Plan') {
//             when {
//                 expression {
//                     return currentBuild.result == 'SUCCESS'
//                 }
//             }
//             steps {
//                 script {
//                     sh '''
//                     # Set the Terraform binary path
//                     TERRAFORM_BIN=/var/jenkins_home/bin/terraform
                    
//                     # Apply the Terraform plan
//                     echo "Applying Terraform plan"
//                     $TERRAFORM_BIN apply -auto-approve plan.out
//                     '''
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
//                 echo 'Pipeline succeeded. Checkov passed. Terraform plan applied successfully.'
//             }
//         }
//     }
// }


////
@Library('jenkins-shared-library@main') _

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Install Checkov') {
            steps {
                script {
                    checkovAndTerraform.installCheckov()
                }
            }
        }
        stage('Run Checkov and Terraform Plan') {
            steps {
                script {
                    def checkovPassed = false
                    try {
                        timeout(time: 60, unit: 'MINUTES') {
                            sh 'sudo ls -la ${WORKSPACE}/jenkins-shared-library/custom_policies'
                            checkovAndTerraform.runCheckovAndTerraformPlan()
                            checkovPassed = true
                        }
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
                    # Set the Terraform binary path
                    TERRAFORM_BIN=/var/jenkins_home/bin/terraform
                    
                    # Apply the Terraform plan
                    echo "Applying Terraform plan"
                    $TERRAFORM_BIN apply -auto-approve plan.out
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
