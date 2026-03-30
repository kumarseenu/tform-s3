provider "aws" {
  region = "us-east-1"  # Default region, adjust as needed
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}