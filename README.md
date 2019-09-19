# Introduction
This project provides the files necessary to build & run PubSub+ Monitor in a Docker container.

## Features
+ Alerting integration with Slack
 
## Prerequisites
+ Docker
+ git
+ The Latest PubSub+ Monitor zipfile downloaded from RTView
+ A valid PubSub+ Monitor trail Key

## Usage

### Build the Image

1. Checkout the project from git
2. Copy the PubSub+ Monitor zip file to the project directory & do `docker build . --tag=solace/pspmon:demo`

### Launch the Container

- **Basic Container**: `docker run -d -p 8068:8068 --name=pspmon solace/pspmon:demo`
- **Container with new KEY**: `docker run -d -p 8068:8068 -e "KEYS=<your key>" --name=pspmon solace/pspmon:demo`
- **Container with Slack integration**: `docker run -d -p 8068:8068 -e "SLACKWEBHOOKURL=<your URL>" --name=pspmon solace/pspmon:demo`

The PubSub+ Monitor container will start as a daemon on `http://localhost:8068`, after which you can
follow the standard product documentation to begin monitoring your instance of PubSub+.

## Receiving Alerts on Slack
> :note: Please setup your webhook URL _before_ creating the Docker container.

The basic workflow for receiving alerts in Slack is:
1. Enable an alert to monitor in PubSub+ Monitor.
2. Create a basic Slack application with a webhook URL & install it in a Slack channel of your choice (e.g. `Slackbot`).  
3. Trigger the alert you setup in 1 & watch as alert messages appear in the Slack channel.

> :warning: Keep in mind that **everyone** who has the App installed will receive alerts. Please be considerate, avoid flooding the app.

## Notes
### Monitoring PubSub+ on Localhost
If you have PubSub+ running locally (e.g. on http://localhost:8080), configure Monitor to point to your machine's `IP` & not `localhost`.

## Feature Suggestions
Feel free to open issues against the project if you find an error or would like to make a feature request.