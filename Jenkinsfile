node{
    stage 'Checkout'
        checkout scm
    stage 'Build & UnitTest'
        sh "docker build -t przemek-isc/docker-cacti:B${BUILD_NUMBER} -f Dockerfile ."
        sh "docker build -t przemek-isc/docker-cacti:test-B${BUILD_NUMBER} -f Dockerfile.Integration ."
    
    stage 'Checkout'
        checkout scm
    stage 'Build & UnitTest'
        sh "docker build -t przemek-isc/docker-cacti:B${BUILD_NUMBER} -f Dockerfile ."
        sh "docker build -t przemek-isc/docker-cacti:test-B${BUILD_NUMBER} -f Dockerfile.Integration ."
  
    stage 'Integration Test'
        sh "docker-compose -f docker-compose.integration.yml up --force-recreate --abort-on-container-exit"
        sh "docker-compose -f docker-compose.integration.yml down -v"
  
    stage 'Integration Test'
        sh "docker-compose -f docker-compose.integration.yml up --force-recreate --abort-on-container-exit"
        sh "docker-compose -f docker-compose.integration.yml down -v"
}
