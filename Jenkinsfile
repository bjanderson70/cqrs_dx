#!groovy

import groovy.json.JsonSlurperClassic
import jenkins.model.Jenkins

node {

    def SF_CONSUMER_KEY=env.SF_CONSUMER_KEY
    def SF_USERNAME=env.SF_USERNAME
    def SERVER_KEY_CREDENTALS_ID=env.JWT_CRED_ID_DH
 
    def TEST_LEVEL='RunLocalTests'
    def PACKAGE_NAME
    def PACKAGE_VERSION
    def SF_INSTANCE_URL = env.SF_INSTANCE_URL ?: "https://test.salesforce.com"

    def toolbelt = env.TOOL_LOC


    // -------------------------------------------------------------------------
    // Check out code from source control.
    // -------------------------------------------------------------------------

    stage('checkout source') {
        echo "Checking out source"
        checkout scm
    }


    // -------------------------------------------------------------------------
    // Run all the enclosed stages with access to the Salesforce
    // JWT key credentials.
    // -------------------------------------------------------------------------
    
    withEnv(["HOME=${env.WORKSPACE}"]) {
        
        withCredentials([file(credentialsId: SERVER_KEY_CREDENTALS_ID, variable: 'server_key_file')]) {

            // -------------------------------------------------------------------------
            // Authorize the Dev Hub org with JWT key and give it an alias.
            // -------------------------------------------------------------------------

            stage('Step 1. Authorize DevHub') {
               rc = command "${toolbelt}sfdx force:auth:jwt:grant --instanceurl ${SF_INSTANCE_URL} --clientid ${SF_CONSUMER_KEY} --username ${SF_USERNAME} --jwtkeyfile ${server_key_file} --setdefaultdevhubusername --setalias HubOrg"
               
                if (rc != 0) {
                    error 'Salesforce dev hub org authorization failed.'
                }
            }


            // -------------------------------------------------------------------------
            // Create new scratch org to test your code.
            // -------------------------------------------------------------------------

            stage('Step 2. Create Test Scratch Org') {
                rc = command "${toolbelt}sfdx force:org:create --targetdevhubusername HubOrg --setdefaultusername --definitionfile config/project-scratch-def.json --setalias ciorg --wait 400 --durationdays 1"
                echo "Create Test Scratch Org :"
                if (rc != 0) {
                    error 'Salesforce test scratch org creation failed.'
                }
            }

            // -------------------------------------------------------------------------
            // Display test scratch org info.
            // -------------------------------------------------------------------------

            stage('Step 3. Display Test Scratch Org') {
                rc = command "${toolbelt}sfdx force:org:display --targetusername ciorg"
                
                if (rc != 0) {
                    error 'Salesforce test scratch org display failed.'
                }
            }


            // -------------------------------------------------------------------------
            // Push source to test scratch org.
            // -------------------------------------------------------------------------

            stage('Step 4. Push To Test Scratch Org') {
                rc = command "${toolbelt}sfdx force:source:push --targetusername ciorg"
                
                if (rc != 0) {
                    error 'Salesforce push to test scratch org failed.'
                }
            }


            // -------------------------------------------------------------------------
            // Run unit tests in test scratch org.
            // -------------------------------------------------------------------------

            stage('Step 5. Run Tests In Test Scratch Org') {
                rc = command "${toolbelt}sfdx force:apex:test:run --targetusername ciorg --wait 400 --resultformat tap --codecoverage --testlevel ${TEST_LEVEL}"
                if (rc != 0) {
                    error 'Salesforce unit test run in test scratch org failed.'
                }
            }


            // -------------------------------------------------------------------------
            // Delete test scratch org.
            // -------------------------------------------------------------------------

            stage('Step 6. Delete Test Scratch Org') {
                rc = command "${toolbelt}sfdx force:org:delete --targetusername ciorg --noprompt"
                if (rc != 0) {
                    error 'Salesforce test scratch org deletion failed.'
                }
            }
        }
    }
}

def command(script) {
    if (isUnix()) {
        return sh(returnStatus: true, script: script);
    } else {
        return bat(returnStatus: true, script: script);
    }
}