#!/usr/bin/env bash
#
mydir=$(pwd);
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
function findPackageDirectory() {

    if [[ -d "metadata" ]]; then
        cd .
    elif  [[ -d "../metadata" ]]; then
      cd ../
    elif  [[ -d "../../metadata" ]]; then
      cd ../../
    elif  [[ -d "../../../metadata" ]]; then
      cd ../../../
    fi
 
    toDir=$(pwd)
}
#reset console
trap shutdown EXIT
checkForCMD
findPackageDirectory
 
cd ${toDir}
sfdx force:mdapi:deploy  -d metadata/unpackaged -w 30
cd ${mydir}
