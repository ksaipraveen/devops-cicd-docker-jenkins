node{
    
   def buildNumber = BUILD_NUMBER
   
    stage("Git CheckOut"){
        git url: 'https://github.com/devops-training445/devops-cicd-docker-jenkins.git',branch: 'master'
    }
    
    stage(" Maven Clean Package"){
      def mavenHome =  tool name: "Maven", type: "maven"
       sh "${mavenHome}/bin/mvn clean package"
    } 
    
     stage("Build Docker Image") {
         sh "docker build -t skandikatta/saiwebapplication:${buildNumber} ."
    }
    
      stage("Docker Push"){
        
       withCredentials([string(credentialsId: 'Docker_Repo_Pwd', variable: 'Docker_Repo_Pwd')]) {
          sh "docker login -u skandikatta -p ${Docker_Repo_Pwd}"   
       }
       
        sh "docker push skandikatta/saiwebapplication:${buildNumber}"
    }
    stage("Deploy application as a Docker Container in Docker Deployment server"){
        
        sshagent(['Docker_Deploy_Server']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@deploymentserverip docker rm -f mavenwebappcontainer || true'
            sh "ssh ubuntu@deploymentserverIP docker run -d --name mavenwebapp -p 8080:8080 skandikatta/saiwebapplication:${buildNumber}"
    }
  }
    
}
