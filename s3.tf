resource "aws_s3_bucket" "bucket" {
  bucket = "test-infracloud-mtardio"
} 

resource "aws_s3_bucket_policy" "name" {
  depends_on = [aws_s3_bucket_public_access_block.name]
  bucket = aws_s3_bucket.bucket.id
  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": 
  {
    "Sid": "test",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": [
              "arn:aws:s3:::test-infracloud-mtardio/*",
              "arn:aws:s3:::test-infracloud-mtardio"
          ]
  }
}
EOT
}


resource "aws_s3_bucket_public_access_block" "name" {
  bucket = "test-infracloud-mtardio"

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_object" "s3_upload_image" {
  depends_on = [aws_s3_bucket_public_access_block.name]
  bucket = "test-infracloud-mtardio"
  key    = "assets/puppy.jpg"
  source = "assets/puppy.jpg"
}