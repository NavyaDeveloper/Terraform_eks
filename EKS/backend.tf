terraform {
	backend "s3" {
		bucket = "terraform-eks-s3-backend"
		key    = "eks/terraform.tfstate"
		region = "us-east-1"
	}
}