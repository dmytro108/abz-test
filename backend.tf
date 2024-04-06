terraform {
  backend "s3" {
    bucket         = "abz-tf-wp-01"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-locks-abz-test-wp-01"
  }
}
/*
aws s3  mb --region "us-east-2" s3://abz-tf-wp-01
aws dynamodb create-table --table-name terraform-locks-abz-test-wp-01 \
                          --attribute-definitions AttributeName=LockID,AttributeType=S \
                          --key-schema AttributeName=LockID,KeyType=HASH \
                          --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
                          --region "us-east-2"
*/
