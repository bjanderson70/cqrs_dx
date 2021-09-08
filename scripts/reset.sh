#!/usr/bin/env bash
# reset the source tracking (hard-way)
sfdx force:source:tracking:clear -p
sfdx force:source:tracking:reset -p
