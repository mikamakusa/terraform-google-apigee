provider "google" {}
provider "google-beta" {}

module "apigee" {
  source = "../../"
  organization = [
    {
      description         = "Terraform-provisioned basic Apigee Org without VPC Peering."
      analytics_region    = "us-central1"
      disable_vpc_peering = true
      addons = [
        {
          advanced_api_ops_config = true
          api_security_config     = true
        }
      ]
    }
  ]
  environment = [
    {
      name         = "my-environment"
      description  = "Apigee Environment"
      display_name = "environment-1"
      env_keystore = [
        {
          name = "keystore-1"
        }
      ]
      keyvaluemaps = [
        {
          name = "tf-test-env-kvms"
        }
      ]
    }
  ]
}