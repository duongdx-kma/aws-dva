step.sh

# 1. install the cdk

sudo npm install -g aws-cdk

# 2. initialize the application

cdk init app --language javascript


# 3. setup the lambda function code
mkdir lambda && cd lambda
touch app.py

# 4. bootstrap the CDK application
cdk bootstrap

# 5. cdk synth to get CloudFormation template
cdk synth


# 6. deploy CDK stack
cdk deploy --parameters emailSubscription=duong120798@gmail.com

# 7. let's empty s3 bucket
# 8. destroy CDK stack
cdk destroy