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
COPY RTViewSolaceMonitor_5.0.0.0.zip .
RUN unzip RTViewSolaceMonitor_5.0.0.0.zip

#Shorthand, so we don't have to keep specifying the whole path
WORKDIR /usr/RTViewSolaceMonitor

#Copy over the files we need into the container
COPY soleventmodule_docker.properties *.sh ./

#Run dos2unix to fix Windows/Unix line endings
#Move the alerting script to the appropriate subdirectory
#Execute the script to update our syslog entries
RUN dos2unix setup_syslog.sh && dos2unix entrypoint.sh && dos2unix my_alert_actions.sh && mv my_alert_actions.sh projects/rtview-server && ./setup_syslog.sh

#PS+ Mon listens on 8068
#Syslog events come in on 10601 & 10602
EXPOSE 8068
EXPOSE 10601
EXPOSE 10602

#What to exec when our container starts
ENTRYPOINT ["./entrypoint.sh"]