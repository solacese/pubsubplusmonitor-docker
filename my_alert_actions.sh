#!/bin/bash
# **************************************************************************
# my_alert_actions.sh: Alert Command Script for Unix/Linux
# Copyright (c) 2009 Sherrill-Lubinski Corporation. All Rights Reserved.
# **************************************************************************
#
DOMAINNAME=$1
shift

ALERTNAME=$1
shift
part1=`expr "$ALERTNAME" : "+*\(.*\)"`
ALERTNAME=`expr "$part1" : "\(.*\)*+"`

ALERTINDEX=$1
shift
part1=`expr "$ALERTINDEX" : "\"+*\(.*\)"`
while [ `expr "$part1" : ".*+"` -eq 0 ]
do
	part1="$part1 $1"
	shift
done
ALERTINDEX=`expr "$part1" : "\(.*\)*+"`

ALERTID=$1
shift
part1=`expr "$ALERTID" : "+*\(.*\)"`
ALERTID=`expr "$part1" : "\(.*\)*+"`

ALERTSEVERITY=$1
shift
part1=`expr "$ALERTSEVERITY" : "+*\(.*\)"`
ALERTSEVERITY=`expr "$part1" : "\(.*\)*+"`

ALERTTEXT=$1
shift
part1=`expr "$ALERTTEXT" : "+*\(.*\)"`
#ALERTTEXT=`expr "$part1" : "\(.*\)*+"`
ALERTTEXT=$part1

# Test for empty arguments
if [ "$DOMAINNAME" = "" ]
then
	DOMAINNAME="N/A"
fi
if [ "$ALERTNAME" = "" ]
then
	ALERTNAME="N/A"
fi
if [ "$ALERTINDEX" = "" ]
then
	ALERTINDEX="N/A"
fi
if [ "$ALERTID" = "" ]
then
	ALERTID="N/A"
fi
if [ "$ALERTSEVERITY" = "" ]
then
	ALERTSEVERITY="N/A"
fi


# The $alertText substitution will have spaces in it.
# Make it the last argument passed to the script.
# Then the 6th argument and beyond can be concatenated
# into the the alertText variable.
for arg
do
	ALERTTEXT="${ALERTTEXT} $arg"
done

# echo "----- Alert command script executed: DOMAINNAME=$DOMAINNAME, ALERTNAME=$ALERTNAME, ALERTINDEX=$ALERTINDEX, ALERTTEXT=$ALERTTEXT, ALERTID=$ALERTID, ALERTSEVERITY=$ALERTSEVERITY #####"

# To send an email, uncomment and modify the line below
# echo "DOMAINNAME=$DOMAINNAME, ALERTNAME=$ALERTNAME, ALERTINDEX=$ALERTINDEX, ALERTTEXT=$ALERTTEXT, ALERTID=$ALERTID, ALERTSEVERITY=$ALERTSEVERITY Thanks-SYSTEM ADMIN" | mail -s "RTV ALERT-$ALERTNAME" distributionlist@domain.com -c carboncopy@domain.com - -f from@domain.com

#POST our alert message to Slack using the webhook, if provided. Webhooks are setup on your organizations Slack account.
if [[ -n "${SLACKWEBHOOKURL}" ]]
then

# We need print_slack_alert() here to simplify generating the JSON for Slack.
# Otherwise, we'd have to end up dealing with trying to escape nested double-quotes

function print_slack_alert(){
  cat << EOF

  {
    "text":"$ALERTTEXT",
    "blocks":[
              {
                "type":"divider"
              }, 
              {
                 "type":"section",
                 "text":
                 {
                   "type":"mrkdwn",
                   "text": "*Domain Name:*\n$DOMAINNAME \n$ALERTINDEX" 
                 }
               },
               {
                   "type":"section",
                   "fields":[
                              {
                                "type":"mrkdwn",
                                "text":"*AlertID:*\n$ALERTID"
                              },
                              {
                                "type": "mrkdwn",
                                "text": "*Alert Name:*\n$ALERTNAME"
                              },
                              {
                                "type": "mrkdwn",
                                "text": "*Severity:*\n$ALERTSEVERITY"
                              },
                              {
                                "type": "mrkdwn",
                                "text": "*Alert Text:*\n$ALERTTEXT"
                              }
                 ]
               }
            ]
   }
EOF
}

  curl -H "Content-Type:application/json" -d "$(print_slack_alert)" ${SLACKWEBHOOKURL}
fi