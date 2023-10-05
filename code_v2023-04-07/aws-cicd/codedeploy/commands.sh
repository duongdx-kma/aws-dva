#!/bin/bash

# Installing CodeDeploy Agent
sudo yum update
yes | sudo yum install ruby

# Download the agent (replace the region)
wget https://aws-codedeploy-ap-southeast-1.s3.ap-southeast-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent status