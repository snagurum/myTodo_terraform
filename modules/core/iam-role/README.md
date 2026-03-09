# Iam Roles

```code

module "iam_role" {
  source = "../../modules/core/iam-role"

  payload = <<EOT
{
  "role_name": "my-app-role",
  "trust_policy_statement":  [{
    "principals": [{ 
        "type" : "Service",
        "identifiers" : ["ec2.amazonaws.com"] 
      },{
        "type"        : "AWS",
        "identifiers" : ["arn:aws:iam::571510180357:root"]
      }]
  }],
  "inline_policies": {
    "s3_read": {
      "statements": [{
          "Effect": "Allow",
          "Action": ["s3:GetObject"],
          "Resource": ["arn:aws:s3:::mybucket/*"]
      }]
    },
    "s3_write": {
      "statements": [{
          "Action": ["s3:PutObject"],
          "Resource": ["arn:aws:s3:::mybucket/*"]
      }]
    }
  },
  "managed_policies": ["arn:aws:iam::aws:policy/AmazonSQSFullAccess"] 
}
EOT
}
```

``` terraform
module "iam_role" {
  source = "../../modules/core/iam-role"

  payload = <<EOT
{
  "role_name": "my-app-role",
  "trust_policy_statement":  [{
    "principals": [{ 
        "type" : "Service",
        "identifiers" : ["ec2.amazonaws.com"] 
      }]
  }],
  "inline_policies": {
    "s3_read": {
      "statements": [{
          "Effect": "Allow",
          "Action": ["s3:GetObject"],
          "Resource": ["arn:aws:s3:::mybucket/*"]
      }]
    }
  },
  "managed_policies": ["arn:aws:iam::aws:policy/AmazonSQSFullAccess"] 
}
EOT
}
```