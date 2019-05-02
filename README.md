# Introduction
This project dockerizes PubSub+ Monitor in an effort to simplify demos. Once launched, the container provides a minimal, operational product with various PubSub+ Monitor capabilities enabled.

## Features
+ Syslog integration 
+ Alerting integration with:
 + Slack (Coming soon...)
 + ServiceNow (Coming soon...)
 + Email (Coming soon...)

## Prerequisites
+ Docker
+ git
+ The Latest PubSub+ Monitor zipfile downloaded from RTView (Ask Darryl Mcgee for credentials)

## Usage

### Build the Image

1. Checkout the project from git
2. Download & **unzip** PubSub+ Monitor (RTView) into your git project directory 
3. Run 
```
docker build --tag=pspmon .
```
From the same directory. Keep in mind that the `tag` can be anything you want.

### Launch the Container
```
docker run -p 8086:8086 -p 10601:10601 -p 10602:10602 --name pubsubplusmonitor pspmon
```

From here on out, the PubSub+ Monitor documentation can be followed vis-&agrave;-vis setting it up to monitor your PubSub+ instance(s).

## Notes
### Syslog
+ Although Syslog is setup in the Docker container, you still need to enable it on your PubSub+ instance(s).
+ The default container exposes ports `10601` & `10602` for Syslog System & Event events, respectively.