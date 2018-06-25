resource "aws_s3_bucket" "b" {
  bucket_prefix = "${var.bucket_prefix}"
  force_destroy = true                   // Allows us to remove the bucket easily at the end of the tutorial
}

output "bucket_name" {
  description = "The bucket name"
  value       = "${aws_s3_bucket.b.id}"
}
