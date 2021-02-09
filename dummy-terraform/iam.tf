resource "aws_iam_role" "task_role" {
  name = var.service_name  

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0", 
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
  tags = {
  }
}

resource "aws_iam_policy" "task_policy" {
  name        = var.service_name
  path        = "/"
  description = "IAM policy for newman task"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor1",
      "Effect": "Allow",
      "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
      ],
      "Resource": [
          "arn:aws:logs:*:*:*"
      ]
    },
    {
      "Sid": "BucketRW",
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:Put*",
        "s3:DeleteObject",
        "s3:AbortMultipartUpload"
      ],
      "Resource": [
          "arn:aws:s3:::dummy-newman*"
      ]
    },
    {
      "Sid": "ListAll",
      "Effect": "Allow",
      "Action": [
        "s3:List*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "sqs:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.task_policy.arn
}

