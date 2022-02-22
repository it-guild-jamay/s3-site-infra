resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.site_bucket_name

  force_destroy = true

  tags = {
    Name        = "S3 Site"
    Environment = "demo"
  }
}

resource "aws_s3_bucket_website_configuration" "site_configuration" {
  bucket = aws_s3_bucket.s3_bucket.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.allow_website_access.json
}

data "aws_iam_policy_document" "allow_website_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.s3_bucket.arn,
      "${aws_s3_bucket.s3_bucket.arn}/*",
    ]
  }
}