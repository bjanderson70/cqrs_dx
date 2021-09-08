#!/usr/bin/env bash
#
mydir=`pwd`;
toDir=${mydir};
CMD_RUN='sfdx';

######################################################
# For UI (curses)
#######################################################

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
bold=`tput bold`

reset=`tput sgr0`
#######################################################
# Utility called when user aborts ( reset )
#
#######################################################
function shutdown() {
  tput cnorm # reset cursor
  resetCursor
  cd ${mydir}
}
#######################################################
# Utility to  reset cursor
#
#######################################################
function resetCursor() {
    echo "${reset}" 
}
#######################################################
# Utility print out error
#
#######################################################
function handleError() {
	echo "${red}${bold}"
	printf >&2 "\n\tERROR: $1"" Aborted\n"; 
	resetCursor;
	exit -1; 
}
#######################################################
# PMD present
#
#######################################################
function checkForCMD(){
	type $CMD_RUN >/dev/null 2>&1 || { handleError " requires 'sfdx' but it's not installed or found in PATH."; }
}
#######################################################
# Utility find root and ensure output dir
#
#######################################################
function findRootAndEnsureOutputDir() {

    if [[ -d "scripts" ]]; then
        cd .
    elif  [[ -d "../scripts" ]]; then
      cd ../
    elif  [[ -d "../../scripts" ]]; then
      cd ../../
    elif  [[ -d "../../../scripts" ]]; then
      cd ../../../
    fi
    if [[ -d "outputs" ]]; then
      echo " ... 'outputs' directory is created"
    else
      mkdir outputs
    fi
    toDir=`pwd`;
}
#reset console
trap shutdown EXIT
checkForCMD
findRootAndEnsureOutputDir

cd ${toDir}
sfdx force:apex:test:run -c  -r json -w 300 > ./outputs/apex_test_results.txt
cd ${mydir}
