#!/bin/bash

#Author:  Ush Shukla
#Company: Solace Inc.
#Date:    2019-05-01
#Description: This script is intended to help with Dockerizing PubSub+ Monitor by
#             keeping a foreground thread running to keep the container up. Otherwise,
#             the docker instance exits immediately since PS+ Mon launches as a background
#             service.
              


echo "----------------------------------------------------------------"
echo "| Helper Script to start PubSub+ Monitor in a Docker container.|"
echo "| This is *not* a part of the original product.                |"
echo "----------------------------------------------------------------"

#If a KEY was provided during container creation, replace the old KEY with it.
if [[ -n "${KEYS}" ]] 
then
  echo -e "\nUsing KEY ${KEYS}"
  rm -rf rtvapm/rtview/lib/KEYS
  touch rtvapm/rtview/lib/KEYS
  echo ${KEYS} > rtvapm/rtview/lib/KEYS
else
  echo "\nNo external KEYS provided. Using the default KEY provided in the ZIP."
fi  

if [[ -n "${SLACKWEBHOOKURL}" ]]
then
  echo "Will send alerts to Slack using ${SLACKWEBHOOKURL}"
fi

##Temporary Fix
#Add support for SolOS 9.2+ by updating RTView's classpath to find the necessary SEMP schemas files
echo -e "Adding support for SolOS 9.2+"
sed -r -i.bak 's/solace-pwd-utility.*/&\ncollector.sl.rtview.cp=%RTVAPM_HOME%\/solmon\/resources/' rtvapm/solmon/conf/rtvapm.solmon.properties

echo -e "\nExecuting start_servers.sh"

#Start the actual PubSub+ Monitor Services
cd bin
./start_servers.sh -eval

#tail dev/null to keep the container up
echo -e "\n...tailing /dev/null to keep container alive..."
tail -f /dev/null