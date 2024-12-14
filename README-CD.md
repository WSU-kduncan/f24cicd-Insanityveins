# PROJECT 5 - CD README

### Overview
The purpose of this project is to demonstrate Continuous Integration using tagging and github actions to automatically deploy built docker images to a cloud service.

## Part 1 - Semantic Versioning
* Generate tags using the the `git tag <tag-name>` command
    * Semantic versioning is the suggested method of naming
* The github workflow was edited to trigger from pushes to tag instead of main
    * This workflow will build the image and prep to send to DockerHub as normal, but it will also tag the image with the provided data from the git tag pushed to the repo.
    * The images are then sent to this [DockerHub repo](https://hub.docker.com/repository/docker/insanityveins/ivery-ceg3120/general)

## Part 2
* Instance Information
    * t2.small: 
        * Ubuntu 24.04.1 LTS
        * 54.156.84.17
* Followed a series of steps I found [here](https://linux.how2shout.com/how-to-install-docker-on-aws-ec2-ubuntu-22-04-or-20-04-linux/) to add docker to the apt packages, installed it, and got it properly running for Ubuntu user
* Update script
    * The purpose of this script was to have a way to automatically update the container to the updated website.
    * The scipt pulls the latest image, kills and removes the container, then starts a new container with the new image.
    * The script is at `home/ubuntu/update.sh`
* The purpose of using adnanh's webhook was to have a way to trigger the script to execute after pushing new tags to the repo.
    * Runs on port 9000
* Webhook
    * The file defines what needs to be appended to the url to trigger the hook and what file is executed when it does so.
    * Stored at `/home/ubuntu/docker-hook.json`
* How to start webhook using command
    * `webhook -hooks docker-hook.json -verbose`
* How to test whether the hook works
    * Create and push a tag to github
    * Github pushed image to DockerHub
    * DockerHub sends payload to webhook
    * The webhook will be waiting for a payload to be sent to it. If successful, you will see docker outputs from the bash script.
    * DockerHub webhook setup
        * In repo webhook tab, provide a name and url for a webhook to send payload to
    * Modify webhook service file to run on boot
        * Update pathing to point to `docker-hook.json` and add `Restart=always` in the service section
        * `sudo systemctl daemon-reload` to update the service file 