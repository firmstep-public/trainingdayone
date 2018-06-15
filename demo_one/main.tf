resource "aws_s3_bucket" "b" {
  bucket_prefix = "${var.bucket_name}"
  force_destroy = true                 // Allows us to remove the bucket easily at the end of the tutorial
}
