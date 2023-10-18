I. Option 1:

## https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-on-EC2-Instance.html
## https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Install-CloudWatch-Agent.html
# 1. install in ec2:
sudo yum install amazon-cloudwatch-agent


# 2.Create the CloudWatch agent configuration file
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/create-cloudwatch-agent-configuration-file.html
vim  /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json


# 3. check CloudWatch agent

amazon-cloudwatch-agent-ctl -help

amazon-cloudwatch-agent-ctl -a status

amazon-cloudwatch-agent-ctl -a start


II. Option 2:

# https://www.youtube.com/watch?v=U7X3ehGZYwQ

# 1. install in ec2:
sudo yum install amazon-cloudwatch-agent

# 2. config cloudwatch agent:
