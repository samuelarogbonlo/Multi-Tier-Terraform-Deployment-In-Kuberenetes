# TODO: please create an AWS S3 bucket and an object in it
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "my_object" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = var.object_name
  source = var.config_filename 
}