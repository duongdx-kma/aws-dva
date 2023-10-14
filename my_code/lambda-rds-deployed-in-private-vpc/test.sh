# 1 create data RDS postgres

# 2. create lambda function

# 3. edit lambda function role
- add role: AWSLambdaENIManagementAccess: create ethernet interface
- add role: AmazonRDSReadOnlyAccess

# 4. add lambda function to vpc and grant SG for lamdba

# 5. create ec2 to connect RDS database

# 6. connect ec2-> connect RDS: 

psql --host=endpoint --port=5432 --username=root --dbname=postgres

CREATE DATABASE test_db;

psql --host=database-test.ci0bwbkmi7tv.ap-southeast-1.rds.amazonaws.com --port=5432 --username=root --dbname=test_db

