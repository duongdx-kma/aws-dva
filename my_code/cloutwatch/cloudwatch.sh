# 0 add permissions for ec2:
"cloudwatch:PutMetricData",
"cloudwatch:GetMetricStatistics"

# 1 call API put-metric-data:  send 
# 1.1 nornmal way
aws cloudwatch put-metric-data --metric-name "metricName" --namespace "MyService" --dimensions "data"="key" --value "value"
aws cloudwatch put-metric-data --metric-name PageViewCount --namespace MyService --dimensions InstanceGroup=instanceOnProd --value 11

# 1.2 multi dimentions:
aws cloudwatch put-metric-data --metric-name PageViewCount --namespace MyService --unit Bytes --value 231434333 --dimensions InstanceGroup=instanceOnProd,InstanceType=m1.small

# 1.3 with json: https://docs.aws.amazon.com/cli/latest/reference/cloudwatch/put-metric-data.html
aws cloudwatch put-metric-data --namespace "MyService" --metric-data file://metric.json --dimensions InstanceGroup=instanceOnProd

# 2 call API get-metric-statistics: get data 
aws cloudwatch get-metric-statistics --namespace MyService --metric-name PageViewCount \
--statistics "Sum" "Maximum" "Minimum" "Average" "SampleCount" \
--start-time "time" --end-time "time" --period "senconds"

aws cloudwatch get-metric-statistics --namespace MyService --metric-name PageViewCount \
--statistics "Sum" "Maximum" "Minimum" "Average" "SampleCount" \
--start-time 2023-10-17T12:00:00.000Z --end-time 2023-10-19T12:05:00.000Z --period 3600 # 1hour