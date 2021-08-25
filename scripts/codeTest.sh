#!/usr/bin/env bash
#
mydir=`pwd`;
#######################################################
# Utility called when user aborts ( reset )
#
#######################################################
function shutdown() {
  tput cnorm # reset cursor
  cd ${mydir}
}
#reset console
trap shutdown EXIT

cd /c/salesforce/workspace/sf_rules/
sfdx force:apex:test:run -c  -r json -w 300 > ./outputs/apex_test_results.txt
cd ${mydir}
