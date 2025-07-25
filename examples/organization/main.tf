provider "google" {}
provider "google-beta" {}

/*data "archive_file" "bundle" {
  type             = "zip"
  source_dir       = "${path.cwd}/bundle"
  output_path      = "${path.cwd}/bundle.zip"
  output_file_mode = "0644"
}*/

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
      /*api = [
        {
          name          = "proxy1"
          config_bundle = data.archive_file.bundle.output_path
        }
      ]*/
    }
  ]
}