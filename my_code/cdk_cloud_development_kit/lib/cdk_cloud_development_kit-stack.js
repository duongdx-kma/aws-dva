const {
    Stack,
} = require('aws-cdk-lib');
const sns = require('aws-cdk-lib/aws-sns');
const s3 = require("aws-cdk-lib/aws-s3");
const destinations = require("aws-cdk-lib/aws-lambda-destinations");
const iam = require("aws-cdk-lib/aws-iam");
const subscriptions = require("aws-cdk-lib/aws-sns-subscriptions");
const lambda = require("aws-cdk-lib/aws-lambda");
const lambdaEventSource = require("aws-cdk-lib/aws-lambda-event-sources");
const dynamodb = require("aws-cdk-lib/aws-dynamodb");
const cdk = require("aws-cdk-lib");

// const sqs = require('aws-cdk-lib/aws-sqs');

const imageBucket = 'duongdx-test-cdk'

class CdkCloudDevelopmentKitStack extends Stack {
    /**
     *
     * @param {Construct} scope
     * @param {string} id
     * @param {StackProps=} props
     */
    constructor(scope, id, props) {
        super(scope, id, props);

        // 👇 parameter of type String
        const emailSubscription = new cdk.CfnParameter(this, 'emailSubscription', {
            type: 'String',
            description: 'email subscription',
        });
        console.log('email 👉 ', emailSubscription.valueAsString);

        //===========================================
        // defined S3 bucket
        //===========================================
        const bucket = new s3.Bucket(this, imageBucket, {
            removalPolicy: cdk.RemovalPolicy.DESTROY,
            autoDeleteObjects: true,
        });

        new cdk.CfnOutput(this, "Bucket", {value: bucket.bucketName});

        //===========================================
        // defined Role for Lambda
        // cdk-lambda-role: lambda role name
        //===========================================
        const lambdaRole = new iam.Role(this, 'cdk-lambda-role', {
            assumedBy: new iam.ServicePrincipal('lambda.amazonaws.com')
        });
        // define lambda role policy
        lambdaRole.addToPolicy(
            new iam.PolicyStatement({
                effect: iam.Effect.ALLOW,
                actions: [
                    "rekognition:*",
                    "logs:CreateLogGroup",
                    "logs:CreateLogStream",
                    "logs:PutLogEvents",
                ],
                resources: ["*"],
            })
        );

        //===========================================
        // defined Role for Lambda
        // cdk-image-table: lambda role name
        //===========================================
        const imageTable = new dynamodb.Table(this, 'cdk-image-table', {
            partitionKey: {
                name: 'image_id',
                type: dynamodb.AttributeType.STRING,
            }
        });
        new cdk.CfnOutput(this, "Table", {value: imageTable.tableName});

        //===========================================
        // defined SNS topic is Lambda destination
        // cdk-topic: topic name
        //===========================================
        const myTopic = new sns.Topic(this, 'cdk-topic');
        myTopic.addSubscription(new subscriptions.EmailSubscription(emailSubscription))

        //===========================================
        // defined Lambda fuction
        // cdk-lambda-funtion: lambda fuction name
        //===========================================
        const lambdaFunction = new lambda.Function(this, 'cdk-lambda-funtion', {
            code: lambda.AssetCode.fromAsset('lambda'),
            runtime: lambda.Runtime.PYTHON_3_9,
            handler: 'app.lambda_handler',
            role: lambdaRole,
            environment: {
                TABLE: imageTable.tableName,
                BUCKET: bucket.bucketName,
            },
            // on success trigger destination (sns topic)
            onSuccess: new destinations.SnsDestination(myTopic),
        });
        lambdaFunction.addEventSource(
            new lambdaEventSource.S3EventSource(bucket, {
                events: [ s3.EventType.OBJECT_CREATED, s3.EventType.OBJECT_REMOVED],
                // filters: [ { prefix: 'subdir/' } ] // optional
            })
        )

        bucket.grantReadWrite(lambdaFunction);
        imageTable.grantFullAccess(lambdaFunction);
    }
}

module.exports = {CdkCloudDevelopmentKitStack}
