#!/usr/bin/env groovy

properties([
    buildDiscarder(logRotator(numToKeepStr: '50', artifactNumToKeepStr: '5')),
    pipelineTriggers([cron('H H/6 * * *')]),
])

nodeWithTimeout('docker') {
    deleteDir()

    stage('Checkout') {
        checkout scm
    }

    if (!infra.isTrusted()) {

        stage('shellcheck') {
            // run shellcheck ignoring error SC1091
            // Not following: /usr/local/bin/jenkins-support was not specified as input
            sh 'make shellcheck'
        }

        /* Outside of the trusted.ci environment, we're building and testing
         * the Dockerfile in this repository, but not publishing to docker hub
         */
        stage('Build') {
            sh 'make build'
        }

        stage('Prepare Test') {
            sh "make prepare-test"
        }
    }
}
