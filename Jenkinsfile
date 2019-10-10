node {
   def sonarUrl = 'sonar.host.url=http://192.168.1.89:9000'
   def mvn = tool (name: 'maven3', type: 'maven') + '/bin/mvn'
   stage('SCM Checkout'){
    // Clone repo
	git branch: 'master', 
	credentialsId: 'github-cred', 
	url: 'https://github.com/joebibe/docker-cacti'
   } 
}
