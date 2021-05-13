locals {
  dir = "${path.root}/../public/"
  mime_types = {
    html = "text/html"
  }
}

resource "aws_s3_bucket_object" "website-files" {
  for_each = fileset(local.dir, "**/*.*")

  bucket = aws_s3_bucket.website.bucket
  key    = replace(each.value, local.dir, "")
  source = "${local.dir}${each.value}"
  etag   = filemd5("${local.dir}${each.value}")
  content_type = lookup(
    local.mime_types,
    split(".", each.value)[
      length(split(".", each.value)) - 1
    ],
    null
  )
}
