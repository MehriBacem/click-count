def staging = [:]
staging.name = "vagrant"
staging.host = "10.0.0.4"
staging.allowAnyHosts = true

def production = [:]
production.name = "vagrant"
production.host = "10.0.0.5"
production.allowAnyHosts = true

node{


    stage('update'){
        git url: 'https://github.com/MehriBacem/click-count.git'    
    }

    stage('Package application'){
        docker.image('maven:3-jdk-8').inside(){
            sh 'mvn clean package -DskipTests'
        }
    }

    stage('build/push docker image'){
        def tag = "latest" 
        def image = docker.build("bacemmehri1/test_technique")
        image.push(tag)
    }

   
withCredentials([usernamePassword(credentialsId: 'staging', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {

  echo "username is $USERNAME"
  staging.user= USERNAME
  staging.password=  PASSWORD
     stage('staging'){

     sshCommand remote: staging, command: 'hostname;'
     sshPut remote: staging, from: 'docker-compose.yml', into: '.'
     sshCommand remote: staging, command: 'docker-compose down; docker rmi -f bacemmehri1/test_technique:latest || True;  docker-compose up -d;'

     sh 'bash smoke-test.sh'

    }
}

        stage('Sanity check') {

                input "Does the staging environment look ok?"

        }

withCredentials([usernamePassword(credentialsId: 'staging', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {

  echo "username is $USERNAME"
  production.user= USERNAME
  production.password=  PASSWORD
     stage('production'){

     sshCommand remote: production, command: 'hostname;'
     sshPut remote: production, from: 'docker-compose.yml', into: '.'
     sshCommand remote: production, command: 'docker-compose down; docker rmi -f bacemmehri1/test_technique:latest || True;  docker-compose up -d;'

    }
}



}
