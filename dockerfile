#Use Alpine Linux to keep container size down, but make sure we have Java
FROM openjdk:8-alpine

LABEL author="Ush Shukla"
LABEL date="2019-05-01"
LABEL description="Dockerfile to build a PubSub+ Monitor container"  

#Refresh the base image & install bash - PS+ Mon uses bash scripting
RUN apk update
RUN apk add bash

WORKDIR /usr

#Copy over our unzipped RTViewSolaceMonitor directory
COPY RTViewSolaceMonitor*.zip .
RUN unzip RTViewSolaceMonitor*.zip

#Shorthand, so we don't have to keep specifying the whole path
WORKDIR /usr/RTViewSolaceMonitor

#Copy over the files we need into the container
#COPY soleventmodule_docker.properties *.sh KEYS ./
COPY my_alert_actions.sh entrypoint.sh ./

#Temporary Fix
#Copy over the schemas necessary to support SolOS 9.2+
COPY *.xsd rtvapm/solmon/resources/9_2VMR/
COPY *.xsd rtvapm/solmon/resources/9_2Appliance/
COPY *.xsd rtvapm/solmon/resources/9_3VMR/
COPY *.xsd rtvapm/solmon/resources/9_3Appliance/


#Run dos2unix to fix Windows/Unix line endings
#Move the alerting script to the appropriate subdirectory
RUN dos2unix entrypoint.sh && dos2unix my_alert_actions.sh && mv my_alert_actions.sh projects/rtview-server

#PS+ Mon listens on 8068
EXPOSE 8068

#What to exec when our container starts
ENTRYPOINT ["./entrypoint.sh"]