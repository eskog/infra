terraform {
  backend "s3" {
    bucket         = "infraterraform"
    key            = "terraform.tfstate"
    region         = "us-east-1"                   # Dummy value, terraform requires it but it is not in used by local S3
    endpoints      = {
        s3 = "http://10.0.24.101:9000"
    }
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id = true
    use_path_style = true
  }
}
