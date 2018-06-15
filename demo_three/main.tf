data "terraform_remote_state" "website" {
  backend = "s3"

  config {
    bucket = "${var.state_bucket}"
    key    = "${var.website_key}"
    region = "${var.state_region}"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = "${data.terraform_remote_state.website.bucket_name}"
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
  etag         = "${md5(file("${path.module}/index.html"))}"
}

resource "aws_s3_bucket_object" "error" {
  bucket       = "${data.terraform_remote_state.website.bucket_name}"
  key          = "error.html"
  source       = "${path.module}/error.html"
  content_type = "text/html"
  etag         = "${md5(file("${path.module}/error.html"))}"
}

output "bucket_name" {
  value = "${data.terraform_remote_state.website.bucket_name}"
}

output "url" {
  value = "${data.terraform_remote_state.website.url}"
}

output "regional_bucket_name" {
  value = "${data.terraform_remote_state.website.regional_bucket_name}"
}
