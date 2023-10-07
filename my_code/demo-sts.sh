
------------ console step: https://www.youtube.com/watch?v=-JAg5A26gF0 ---------------------------

https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html


PRODUCT ACCOUNT

# 1 create lambda function (demoFunction)

# 2 create policy allow invoke lambda function (demoSTSInvokeLambdaPolicy)
- police
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "lambda:InvokeFunction",
            "Resource": "arn:aws:lambda:ap-southeast-1:11111111111:function:demoFunction"
        }
    ]
}


# 3 create role for assume role (demoSTSRole)

- permission: demoSTSInvokeLambdaPolicy
- Trust relationships 
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::11111111111:user/sts-user"
            },
            "Action": "sts:AssumeRole",
            "Condition": {}
        }
    ]
}


# 3 create policy allow user assume role (demoSTSAssumeRolePolicePolicy)
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "arn:aws:iam::11111111111:role/demoSTSRole"
        }
    ]
}


------------ CLI step ---------------------------
# 1. configure user profile
aws configure

# 2. call sts api - assume-role for user
aws sts assume-role --role-arn arn:aws:iam::"[account_id]":role/"[role_name]"  --role-session-name "name ...." --profile "aws cli profile"  > assume-role-output.txt
aws sts assume-role --role-arn arn:aws:iam::11111111111:role/demoSTSRole  --role-session-name "InvokeLambda" --profile default  > assume-role-output.txt

# 3. test invoke lambda asynchronous
aws lambda invoke --cli-binary-format raw-in-base64-out --function-name demoFunction --invocation-type Event --payload '{ "name": "Bob" }' response.json






------------------------------------------------

cross-account
------------------------------------------------

------------ console step: https://www.youtube.com/watch?v=-JAg5A26gF0 ---------------------------

DEV ACCOUNT

# 3 edit policy allow user assume role (StsAssumeRolePoliceToDuongDinhXuanAccount)
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "arn:aws:iam::11111111111:role/demoSTSRole"
        }
    ]
}


------------ CLI step cross account---------------------------
# 1. configure user profile cross-account

aws configure --profile cross-account

# 2. # 2. call sts api - assume-role for user
aws sts assume-role --role-arn arn:aws:iam::11111111111:role/demoSTSRole  --role-session-name "InvokeLambda" --profile default  > assume-role-output.txt


# 3. Let's edit ~/.aws/credentials:
vim ~/.aws/credentials

[cross-account]
aws_access_key_id = "aws_access_key_id is stored into assume-role-output.txt"
aws_secret_access_key = "aws_access_key_id is stored into assume-role-output.txt"
aws_session_token = "tokent is stored into assume-role-output.txt"

# 4. test invoke lambda asynchronous
aws lambda invoke --cli-binary-format raw-in-base64-out --function-name demoFunction --invocation-type Event --payload '{ "name": "Bob" }' response.json --profile cross-account
