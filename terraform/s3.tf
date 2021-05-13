resource "aws_s3_bucket" "website" {
  bucket = "my-terraform-demo-bucket"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

data "aws_iam_policy_document" "website" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.website.json
}

output "s3_bucket_id" {
  value = aws_s3_bucket.website.id
}
output "s3_website_endpoint" {
  value = aws_s3_bucket.website.website_endpoint
}
