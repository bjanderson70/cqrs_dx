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
echo "Running PMD... out pushed to '.outputs/out.hml'"
run.sh pmd -dir force-app/ -f html  -rulesets  resources/rulesets/apex/security.xml,resources/rulesets/apex/performance.xml,resources/rulesets/apex/metrics.xml  > ./outputs/pmd_scan.html
cd ${mydir}
