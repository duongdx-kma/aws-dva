#1.aws configure
aws configure


#2. test list all object in bucket:
aws s3 ls s3://duongdx-test-cross-account


#3. get object:
aws s3api get-object --bucket duongdx-test-cross-account --key test.txt ouput