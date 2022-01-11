  properties([
            parameters([
                choice(
                    choices: ['initialize', 'create-plan', 'create', 'destroy'],
                    description: 'Please select the terraform operation type',
                    name: 'operation'),
                choice(
                    choices: ['prod', 'test'],
                    description: 'Select the environment',
                    name: 'env')
            ])
     ])

    node {
        stage('code checkout'){
                    git branch: "master",
                    credentialsId: 'jenkins-github',
                    url: 'https://github.com/bmonisha14/deployment.git'
        }
        stage('deployment'){
                sh('''
                    echo "deploy started"
                    ansible-playbook ${WORKSPACE}/deploy.yaml --extra-vars "env=${env} operation=${operation}" -vvv
                ''')
        }        
    }
