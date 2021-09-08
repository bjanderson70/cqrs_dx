#!/usr/bin/env bash

orgName=

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
        fi
    fi
}

function Help() {
    echo "${green}${bold}"
    echo ""
    echo "Usage: $shellLocation  -u <username|targetOrg> | [  -d | -h ]"
	printf "\n\t -u <username|scratch-Org>   [REQUIRED]"
    printf "\n\t -d debugging"
    printf "\n\t -h help\n"
    printf "\n\\n"
    printf "\n\t Ensure you run the script from the toplevel directory such that"
    printf "\n\t 'scripts' directory is visible via 'ls'. Then execute from the command line:"
    printf "\n "
    printf "\n\t\t $ ./scripts/setupOrg.sh -u <scratch-org-name> \n"
    resetCursor;
	exit 0
}

function setPermAndInstall() {
    echo "${green}${bold}"
    # add account records
    echo "   Installing Accounts & Contacts for review scenario"
    ./scripts/genRecords.sh -u "$orgName" -i
}

# source functions
sourceFunctions
#reset console
trap shutdown EXIT


while getopts dhu: option
do
    case "${option}"
    in
        u) orgName=${OPTARG};;
        d) set -xv;;
        h) Help;;
    esac
done

checkForSFDX ;
runFromRoot;

if [ -z ${orgName} ];
then    
    echo "Need -u <scratch-org-name>"
    exit -1;
fi

setPermAndInstall;
complete;
