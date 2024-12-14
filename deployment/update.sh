#!/bin/bash

# pull container from registry
docker pull insanityveins/ivery-ceg3120:latest

# stop and remove previous running - container needs to be named for this to work
docker kill bird-app
docker rm bird-app

# start new container - dont forget to start it on reboot
docker run -d --restart always --name bird-app -p 80:4200 insanityveins/ivery-ceg3120