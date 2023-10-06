#!/usr/bin/env node

const cdk = require('aws-cdk-lib');
const { CdkCloudDevelopmentKitStack } = require('../lib/cdk_cloud_development_kit-stack');

const app = new cdk.App();

const stackProps = {
    env: { region: 'ap-southeast-1' },
    stackName: 'demoCDK',
};

new CdkCloudDevelopmentKitStack(app, 'CdkCloudDevelopmentKitStack', stackProps);
