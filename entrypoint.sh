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
 
echo "Executing start_servers.sh"
echo ""

#Start the actual PubSub+ Monitor Services
cd bin
./start_servers.sh -eval

#tail dev/null to keep the container up
echo "...tailing /dev/null to keep container alive..."
tail -f /dev/null
