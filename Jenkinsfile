@Library('jenkins-shared-library') _

pipeline {
    agent any
    environment {
        // Get the workspace path where your shared library is stored
        customPoliciesPath = "/var/jenkins_home/workspace/test-shared-libraries@2/jenkins-shared-library/custom_policies"
    }
    stages {
        stage('Install Checkov') {
            steps {
                script {
                    echo "Starting Install Checkov Stage..."
                    checkovAndTerraform.installCheckov()
                }
            }
        }

        stage('Run Checkov and Terraform Plan') {
            steps {
                script {
                    echo "Starting Terraform Plan and Checkov..."
                    checkovAndTerraform.runCheckovAndTerraformPlan()
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
                    echo "Applying Terraform..."
                    sh '''
                    export TERRAFORM_BIN=/var/jenkins_home/bin/terraform
                    $TERRAFORM_BIN apply -auto-approve plan.out
                    '''
                }
            }
        }
    }
post {
    always {
        cleanWs()  // Cleans up workspace at the end of every build
    }
}

}
