#!/usr/bin/env bash
############################################################################
# Copyright (c) 2020-2021-2021, Salesforce.  All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#   + Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#
#   + Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in
#     the documentation and/or other materials provided with the
#     distribution.
#
#   + Neither the name of Salesforce nor the names of its
#     contributors may be used to endorse or promote products derived
#     from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
############################################################################

orgName=
inputTo=
exportFrom=

#######################################################
# soure common functions
#
#######################################################
function sourceFunctions() {
    if [[ -f "funcs.sh" ]]; then
        source funcs.sh
    elif  [[ -f "./scripts/funcs.sh" ]]; then
            source ./scripts/funcs.sh
    elif  [[ -f "../../funcs.sh" ]]; then
            source ../../funcs.sh
    elif  [[ -f "../../../funcs.sh" ]]; then
            source ../../../funcs.sh
    fi
}

function Help() {
    echo "${green}${bold}"
    echo ""
    echo "Usage: $shellLocation  -u <username|targetOrg> | [ -e | -i | -h ]"
	printf "\n\t -u <username|targetOrg>"
	printf "\n\t -i import data"
	printf "\n\t -e export data"
    printf "\n\t -h help\n"
    resetCursor;
	exit 0
}
function exportFromOrg() {
    echo "${green}${bold}"
    echo
    echo "Exporting files to ./scripts/sfdx-out"
    $SFDX_CLI_EXEC  force:data:tree:export --query "select name,AccountSource,Annual_Income__c,AnnualRevenue,type,industry,BillingAddress,ShippingAddress from account" --prefix export-sample --outputdir ./scripts/sfdx-out --plan -u "$orgName"
    $SFDX_CLI_EXEC  force:data:tree:export --query 'select Birthdate,description,email,department,HomePhone,firstname,lastname,phone,title from contact' --prefix export-sample --outputdir ./scripts/sfdx-out --plan -u "$orgName"
}

function insertIntoOrg() {
    echo "${green}${bold}"
    echo
    echo "Importing files from './scripts/sfdx-out'"

    [ ! -d "./scripts/sfdx-out" ] && echo "Directory './scripts/sfdx-out' DOES NOT exists."
    $SFDX_CLI_EXEC  force:data:tree:import --targetusername "$orgName" --plan ./scripts/sfdx-out/export-sample-Account-plan.json 
    $SFDX_CLI_EXEC  force:data:tree:import --targetusername "$orgName" --plan ./scripts/sfdx-out/export-sample-Contact-plan.json 
}

# source functions
sourceFunctions
#reset console
trap shutdown EXIT


while getopts iehu: option
do
    case "${option}"
    in
        i) inputTo=1;;
        e) exportFrom=1;;
        u) orgName=${OPTARG};;
        h) Help;;
    esac
done

checkForSFDX ;
runFromRoot;

if [ -z ${orgName} ];
then    
    echo "Need -u <org-name>"
    exit -1;
fi

if [ ! -z ${inputTo} ];
then    
    insertIntoOrg;
fi
if [ ! -z ${exportFrom} ];
then    
    exportFromOrg;
fi
 