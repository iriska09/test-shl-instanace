// @Library('jenkins-shared-library@main') _

// pipeline {
//     agent any

//     stages {
//         stage('Checkout') {
//             steps {
//                 // Checkout the main repository
//                 checkout scm
//             }
//         }
//         stage('Clean Workspace') {
//             steps {
//                 // Remove the existing shared library directory if it exists
//                 sh 'rm -rf jenkins-shared-library'
//             }
//         }
//         stage('Clone Shared Library') {
//             steps {
//                 // Clone the shared library repository
//                 sh 'git clone https://github.com/iriska09/jenkins-shared-library.git'
//             }
//         }
//         stage('Install Checkov') {
//             steps {
//                 script {
//                     try {
//                         // Call the installCheckov function from the shared library
//                         checkovAndTerraform.installCheckov()
//                     } catch (Exception e) {
//                         echo "Checkov installation failed: ${e.message}"
//                         sh 'pwd'
//                         sh 'ls -la ${WORKSPACE}'
//                         sh 'ls -la ${WORKSPACE}/jenkins-shared-library'
//                         error('Checkov installation failed. Stopping the pipeline.')
//                     }
//                 }
//             }
//         }
//         stage('Run Checkov and Terraform Plan') {
//             steps {
//                 script {
//                     def checkovPassed = false
//                     try {
//                         sh 'ls -la ${WORKSPACE}/jenkins-shared-library/custom_policies'
//                         // Call the runCheckovAndTerraformPlan function from the shared library
//                         checkovAndTerraform.runCheckovAndTerraformPlan()
//                         checkovPassed = true
//                     } catch (Exception e) {
//                         echo "Checkov failed: ${e.message}"
//                     }
//                     if (checkovPassed) {
//                         currentBuild.result = 'SUCCESS'
//                     } else {
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

//2 CP code 
// @Library('jenkins-shared-library@main') _

// pipeline {
//     agent any

//     stages {
//         stage('Checkout') {
//             steps {
//                 // Checkout the main repository
//                 checkout scm
//             }
//         }
//         stage('Clean Workspace') {
//             steps {
//                 // Remove the existing shared library directory if it exists
//                 sh 'rm -rf jenkins-shared-library'
//             }
//         }
//         stage('Clone Shared Library') {
//             steps {
//                 // Clone the shared library repository
//                 sh 'git clone https://github.com/iriska09/jenkins-shared-library.git'
//             }
//         }
//         stage('Install Checkov') {
//             steps {
//                 script {
//                     try {
//                         // Call the installCheckov function from the shared library
//                         checkovAndTerraform.installCheckov()
//                     } catch (Exception e) {
//                         echo "Checkov installation failed: ${e.message}"
//                         sh 'pwd'
//                         sh 'ls -la ${WORKSPACE}'
//                         sh 'ls -la ${WORKSPACE}/jenkins-shared-library'
//                         error('Checkov installation failed. Stopping the pipeline.')
//                     }
//                 }
//             }
//         }
//         stage('Run Checkov and Terraform Plan') {
//             steps {
//                 script {
//                     def checkovPassed = false
//                     try {
//                         sh 'ls -la ${WORKSPACE}/jenkins-shared-library/custom_policies'
//                         // Call the runCheckovAndTerraformPlan function from the shared library
//                         checkovAndTerraform.runCheckovAndTerraformPlan()
//                         checkovPassed = true
//                     } catch (Exception e) {
//                         echo "Checkov failed: ${e.message}"
//                     }
//                     if (checkovPassed) {
//                         currentBuild.result = 'SUCCESS'
//                     } else {
//                         currentBuild.result = 'FAILURE'
//                         echo 'Checkov issues found. Stopping the pipeline.'
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



/// CGP 
@Library('jenkins-shared-library') _  // Load the shared library

pipeline {
    agent any

    stages {
        stage('Install Checkov') {
            steps {
                script {
                    echo "Starting Install Checkov Stage..."
                    installCheckov()
                }
            }
        }

        stage('Run Checkov and Terraform Plan') {
            steps {
                script {
                    echo "Starting Run Checkov and Terraform Plan Stage..."
                    runCheckovAndTerraformPlan()
                }
            }
        }

        stage('Apply Terraform') {
            when {
                expression {
                    return fileExists('plan.out') && fileExists('plan.json')
                }
            }
            steps {
                script {
                    echo "Applying Terraform Plan..."
                    sh '''
                    TERRAFORM_BIN=/var/jenkins_home/bin/terraform
                    $TERRAFORM_BIN apply -auto-approve plan.out
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully.'
        }
        failure {
            echo 'Pipeline execution failed. Please check the logs for errors.'
        }
    }
}
