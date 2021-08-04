# Salesforce CQRS

Command-Query Responsibility Segregation, or CSRQ, provides the ability to separate Query from Commands responsibilities using SOLID Principles. Queries retrieve information from a sink (data store) for the user. A command performs a task, such as update a sink (data store). Commands mutate state, while a Query does not. Technically, a Command does not return a value; however, the example
which follows will return status. Each provides a single responsibility (Liskov principle in soLid).

## How to install

Download the directory. Assuming you have :

* SFDX installed 
* Dev Hub, 
* Bash or Git-Bash

you can install this offering by running the following script from the source root directory:

./scripts/inint/install.sh -v <YOU-DEV-HUB> -l <#-of-days-the-Scratch-Org-Is-Active>

for example:

./scripts/inint/install.sh -v MyDevHub -l 5

##  Working with Source

For details about developing against scratch orgs, see the [Package Development Model](https://trailhead.salesforce.com/en/content/learn/modules/sfdx_dev_model) module on Trailhead or [Package Development Model with VS Code](https://forcedotcom.github.io/salesforcedx-vscode/articles/user-guide/package-development-model).

For details about developing against orgs that don’t have source tracking, see the [Org Development Model](https://trailhead.salesforce.com/content/learn/modules/org-development-model) module on Trailhead or [Org Development Model with VS Code](https://forcedotcom.github.io/salesforcedx-vscode/articles/user-guide/org-development-model).
