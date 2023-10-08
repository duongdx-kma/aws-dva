{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::duongdx-test-dynamic-variable",
            "Condition": {
                "StringLike": {
                    "s3:prefix": ""
                }
            }
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::duongdx-test-dynamic-variable",
            "Condition": {
                "StringLike": {
                    "s3:prefix": "home/"
                }
            }
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketPolicyStatus",
                "s3:GetAccountPublicAccessBlock",
                "s3:ListAllMyBuckets",
                "s3:ListAccessPoints",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor4",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::duongdx-test-dynamic-variable",
            "Condition": {
                "StringLike": {
                    "s3:prefix": "home/${aws:username}/*"
                }
            }
        },
        {
            "Sid": "VisualEditor5",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::duongdx-test-dynamic-variable/home/${aws:username}/*"
        }
    ]
}