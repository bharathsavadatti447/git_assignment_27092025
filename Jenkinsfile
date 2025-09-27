pipeline {
    agent { label 'Node-Linux' }

    tools {
        maven 'Maven-3.9.11'   // Name of Maven tool configured in Jenkins
        jdk 'Java-21'          // Name of JDK tool configured in Jenkins
    }

    environment {
        GIT_REPO = 'https://github.com/bharathsavadatti447/git_assignment_27092025.git'
        BRANCH   = 'main'
        EMAIL_RECIPIENTS = 'bharath.savadatti447@gmail.com'
    }

    stages {

        stage('Clean Workspace') {
            steps {
                echo "Cleaning workspace..."
                deleteDir()
            }
        }

        stage('Checkout') {
            steps {
                echo "Cloning the repository from GitHub..."
                git branch: "${BRANCH}",
                    url: "${GIT_REPO}",
                    credentialsId: 'github'
            }
        }

        stage('Build & Test') {
            steps {
                echo "Building the Maven project..."
                sh 'mvn clean package'
            }
        }

        stage('JaCoCo Coverage') {
            steps {
                echo "Generating JaCoCo code coverage report..."
                sh 'mvn jacoco:report'
                publishHTML([
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'target/site/jacoco',
                    reportFiles: 'index.html',
                    reportName: 'JaCoCo Coverage Report'
                ])
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo "Archiving JAR artifacts..."
                archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: false
            }
        }

        stage('Lint') {
            steps {
                echo "Running lint checks..."
                // Example: sh 'mvn checkstyle:check'
            }
        }
    }

    post {
        always {
            echo "Pipeline finished (success/failure/unstable)."
        }

        success {
            echo "Build succeeded!"
            emailext(
                subject: "Build Success: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                body: """<p>Build succeeded in job <b>${env.JOB_NAME}</b> [#${env.BUILD_NUMBER}]</p>""",
                to: "${EMAIL_RECIPIENTS}"
            )
        }

        unstable {
            echo "Build marked as UNSTABLE!"
            emailext(
                subject: "Build Unstable: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                body: """<p>Build became <b>UNSTABLE</b> in job <b>${env.JOB_NAME}</b> [#${env.BUILD_NUMBER}]</p>""",
                to: "${EMAIL_RECIPIENTS}"
            )
        }

        failure {
            echo "Build failed!"
            emailext(
                subject: "Build Failed: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                body: """<p>Build failed in job <b>${env.JOB_NAME}</b> [#${env.BUILD_NUMBER}]</p>""",
                to: "${EMAIL_RECIPIENTS}"
            )
        }
    }
}
