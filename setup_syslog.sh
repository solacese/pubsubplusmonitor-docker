#!/bin/bash

#modifies the files necessary for syslog to work
#Requires that we are running in the RTView root directory

#backup the RTView configuration file
cp projects/rtvservers.dat projects/rtvservers.dat.bak

#Activate the Events module
sed -i 's/\(solmon.*-propfilter.*\)/\1 -soleventmodule/g' projects/rtvservers.dat

#Get the container's IP and use it in configuring the event module properties
IP=`ifconfig eth0 | awk '/inet addr/ {gsub("addr:", "", $2); print $2}'`

#Fix the properties file, replace all IPs with the docker machine's IP
#Backup the original properties file before overlaying it
dos2unix soleventmodule_docker.properties
sed -i "s/{ip}/$IP/g" soleventmodule_docker.properties
mv rtvapm/solmon/soleventmodule/config/soleventmodule.properties rtvapm/solmon/soleventmodule/config/soleventmodule.properties.bak
mv soleventmodule_docker.properties rtvapm/solmon/soleventmodule/config/soleventmodule.properties