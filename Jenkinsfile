pipeline {
    
    parameters{
        booleanParam(name: 'autoApprove', defaultValue:false, description:'Automatically run after generating the plan?')
    }

    environment{
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    agent any

    stages{
        stage('Checkout'){

            steps{

                script{
                    dir('Terraform') {
                        git "https://github.com/Vishnuvardhan88/Terraform-Jenkins.git"
                    }
                }
            }
        }

        stage('Plan'){

            steps{

                sh 'pwd; cd Terraform/ ;terraform init;'
                sh 'pwd; terraform plan -out plan.tf'
                sh 'pwd; terraform show no-color plan.tf > plan.txt'
            }
        }

        stage('Approve'){
            when{
                not{

                    equals expected:true , actual: params.autoApprove
                }
            }

            steps{
                script{

                    def plan = readFile 'Terraform/tfplan.txt'
                    input message : "Do you want to apply this plan"
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]

                }
            }  
        }

        stage('Apply'){

            steps{

                sh 'pwd; cd Terraform/; terraform apply -input=false tfplan'
            }
        }

    }
}
