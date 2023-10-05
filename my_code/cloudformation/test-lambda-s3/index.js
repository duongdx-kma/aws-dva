const AWS = require('aws-sdk');
const s3 = new AWS.S3({apiVersion: '2006-03-01'});

const params = {
    Bucket: process.env.S3_BUCKET_NAME
}

exports.handler = async (event, context) => {

    console.log('Received event:', JSON.stringify(event, null, 2));
    console.log('Received event:', params);

    console.log("Checkpoint 1");

    let s3Objects

    try {
        s3Objects = await s3.listObjectsV2(params).promise();
        console.log(s3Objects)
    } catch (e) {
        console.log(e)
    }

    console.log("Checkpoint 2");

    // Assuming you're using API Gateway
    return {
        statusCode: 200,
        body: JSON.stringify(s3Objects || {message: 'No objects found in s3 bucket'})
    }
};