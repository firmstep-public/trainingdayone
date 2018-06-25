resource "aws_s3_bucket" "web" {
  bucket_prefix = "${var.web_bucket_name_prefix}"
  acl           = "public-read"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetTestBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.web_bucket_name}/*"
        }
    ]
}
EOF
}

output "bucket_name" {
  value = "${aws_s3_bucket.web.id}"
}

output "url" {
  value = "${aws_s3_bucket.web.website_endpoint}"
}

output "regional_bucket_name" {
  value = "${aws_s3_bucket.web.bucket_regional_domain_name}"
}
