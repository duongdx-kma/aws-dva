# create s3 bucket
aws s3 mb s3://duongdx-code-sam

# package cloudformation
##### two way to package cloudformation
# the first way
aws cloudformation package --s3-bucket duongdx-code-sam --template-file template.yaml --output-template-file generation/template-generated.yaml

# the second way
sam package --s3-bucket duongdx-code-sam --template-file template.yaml --output-template-file generation/template-generated.yaml

##### two way to deploy cloudformation
# the first way
aws cloudformation deploy --template-file generation/template-generated.yaml --stack-name test-stack-with-sam --capabilities CAPABILITY_IAM --parameter-overrides  MyEmail=duong120798@gmail.com

# the second way
sam deploy --template-file generation/template-generated.yaml --stack-name test-stack-with-sam --capabilities CAPABILITY_IAM --parameter-overrides  MyEmail=duong120798@gmail.com


##### invoke lambda asynchronously
aws lambda invoke --cli-binary-format raw-in-base64-out --function-name TestLambda --invocation-type Event --payload '{ "name": "Bob" }' response.json
aws lambda invoke --cli-binary-format raw-in-base64-out --function-name lambdaWithDynamoDBStream --invocation-type Event --payload '{ "name": "Bob" }' response.json