#!/usr/bin/env bash
#
#
orgName=;
# Test and Validate Apex

#######################################################
# Utility for help
#
#######################################################
function localhelp() {

    echo "${green}${bold}"
    echo ""
    echo "Usage: $shellLocation -u <username|targetOrg> | -d | -h ]"
    printf "\n\t -u <username|targetOrg> [required]"
    printf "\n\t -d turn on debug"
    printf "\n\t -h the help\n"
    resetCursor;
    exit 0
}

#######################################################
# soure common functions
#
#######################################################
function sourceFunctions() {
    if [[ -f "funcs.sh" ]]; then
        source funcs.sh
    else
        if [[ -f "./scripts/funcs.sh" ]]; then
            source ./scripts/funcs.sh
        else
            if [[ -f "../funcs.sh" ]]; then
                source ../funcs.sh
            fi
        fi
    fi
}
# source functions
sourceFunctions
#reset console
trap shutdown EXIT

while getopts u:dh option
do
    case "${option}"
    in
        d) set -x;;
        u) orgName=${OPTARG};;
        h) localhelp;;
    esac
done

print "Running ..."
if [ ! -z ${orgName} ]; then
    sfdx sfpowerscripts:apextests:trigger -u ${orgName} -l RunLocalTests
    if [ $? -eq 0 ]; then
        print "Validating code coverage is at least 85%"
        sfdx sfpowerscripts:apextests:validate -u ${orgName} -t 85
    fi
    if [ $? -eq 0 ]; then
        print "Running PMD - output file: 'pmd_issues.html' "
        sfdx sfpowerscripts:analyze:pmd --format=summaryhtml --sourcedir=src/ --threshold=2 -o pmd_issues.html 
    fi
else
    localhelp;
fi