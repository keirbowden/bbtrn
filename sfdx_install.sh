#!/bin/bash
#set -x

# install configuration + demo config package
sfdx force:package:install -i 04t0O0000018QDM -u $1 -w 10

# install code package
sfdx force:package:install -i 04t0O0000018QUB -u $1 -w 10

echo "Activate the 'Training' flexipage to try out the training system."
