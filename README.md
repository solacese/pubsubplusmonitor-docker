# Introduction
This project dockerizes PubSub+ Monitor in an effort to simplify demos. Once launched, the container provides a minimal, operational product with various PubSub+ Monitor capabilities enabled.

## Features
+ Syslog integration 
+ Alerting integration with Slack
 
## Prerequisites
+ Docker
+ git
+ The Latest PubSub+ Monitor zipfile downloaded from RTView (Ask Darryl Mcgee for credentials)
+ A valid PubSub+ Monitor trail Key

## Usage

### Build the Image

1. Checkout the project from git
2. Copy the PubSub+ Monitor zip file to the project directory
3. While in the project directory, execute `docker build . --tag=solace/pspmon:demo`. The `--tag` can be anything you want.

### Launch the Container
```
docker run -p 8086:8086 -p 10601:10601 -p 10602:10602 --name=pspmon solace/pspmon:demo
```

Follow the PubSub+ Monitor documentation to begin monitoring your instance of PubSub+.

## Receiving Alerts on Slack
The basic workflow for subscribing to Slack alerts is as follows:
1. Select your desired alert in PubSub+ Monitor.
2. Install the **PubSub+ Monitor Slack Alerts (TEST)** Slack App in a Slack channel of your choice.
  * The `Slackbot` channel is a good option since it is private to you.
3. Trigger the alert you setup in 1 & watch as a message appears in the Slack channel.

> :warning: Keep in mind that **everyone** who has the App installed will receive alerts. Please be considerate, avoid flooding the app.

## Notes
### Monitoring PubSub+ on Localhost
If you have PubSub+ running locally (e.g. on http://localhost:8080), configure Monitor to 
point to your machine's `IP` i.e. http://&lt;IP&gt;:8080, not `localhost`. This is because of how Docker does networking.

### Syslog
+ Although Syslog is setup in the Docker container, you still need to enable it on your PubSub+ instance(s).
+ The default container exposes ports `10601` & `10602` for Syslog System & Event events, respectively.
+ Keep in mind that you need to use *your computers* IP when setting up Syslog on the brokers