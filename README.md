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

The PubSub+ Monitor documentation can now be followed as usual to monitor your instance of PubSub+.

## Notes
### Running PubSub+ On Localhost
Be mindful how you setup 
### Syslog
+ Although Syslog is setup in the Docker container, you still need to enable it on your PubSub+ instance(s).
+ The default container exposes ports `10601` & `10602` for Syslog System & Event events, respectively.
+ Keep in mind that you need to use *your computers* IP when setting up Syslog on the brokers