pipeline {
    agent any
    stages {      
        stage ("terraform init") {
            steps {
                sh ('terraform init') 
            }
        }
        
        stage ("terraform Action") {
            steps {
                echo "Terraform action is --> ${action}"
                script {
                    if (action == "plan") {
                        sh ('terraform plan') 
                    } else {
                        sh ('terraform ${action} --auto-approve') 
                    }
                }
            }
        }
    }
}
