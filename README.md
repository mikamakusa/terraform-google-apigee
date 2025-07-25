## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 6.44.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 6.44.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.44.0 |

## Modules

No modules.

## Utilisation
```hcl
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
  instance = [
    {
      name                     = "my-instance-name"
      location                 = "us-central1"
      description              = "Terraform-managed Apigee Runtime Instance"
      display_name             = "my-instance-name"
      nat_address = [
        {
          name        = "my-nat-address"
          activate    = "true"
        }
      ]
    }
  ]
}
```

## Resources

| Name | Type |
|------|------|
| [google_apigee_addons_config.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_addons_config) | resource |
| [google_apigee_api.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_api) | resource |
| [google_apigee_app_group.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_app_group) | resource |
| [google_apigee_developer.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_developer) | resource |
| [google_apigee_endpoint_attachment.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_endpoint_attachment) | resource |
| [google_apigee_env_keystore.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_env_keystore) | resource |
| [google_apigee_env_references.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_env_references) | resource |
| [google_apigee_envgroup.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_envgroup) | resource |
| [google_apigee_envgroup_attachment.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_envgroup_attachment) | resource |
| [google_apigee_environment.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_environment) | resource |
| [google_apigee_environment_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_environment_iam_member) | resource |
| [google_apigee_environment_keyvaluemaps.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_environment_keyvaluemaps) | resource |
| [google_apigee_environment_keyvaluemaps_entries.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_environment_keyvaluemaps_entries) | resource |
| [google_apigee_flowhook.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_flowhook) | resource |
| [google_apigee_instance.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_instance) | resource |
| [google_apigee_instance_attachment.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_instance_attachment) | resource |
| [google_apigee_nat_address.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_nat_address) | resource |
| [google_apigee_organization.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_organization) | resource |
| [google_apigee_sharedflow.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_sharedflow) | resource |
| [google_apigee_sharedflow_deployment.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_sharedflow_deployment) | resource |
| [google_apigee_sync_authorization.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_sync_authorization) | resource |
| [google_apigee_target_server.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/resources/apigee_target_server) | resource |
| [google_project.this](https://registry.terraform.io/providers/hashicorp/google/6.44.0/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | <pre>list(object({<br/>    name              = string<br/>    display_name      = optional(string)<br/>    deployment_type   = optional(string)<br/>    api_proxy_type    = optional(string)<br/>    type              = optional(string)<br/>    forward_proxy_uri = optional(string)<br/>    min_node_count    = optional(string)<br/>    max_node_count    = optional(string)<br/>    env_keystore = optional(list(object({<br/>      name = optional(string)<br/>    })))<br/>    env_references = optional(list(object({<br/>      name          = string<br/>      refers        = string<br/>      resource_type = string<br/>      description   = optional(string)<br/>    })))<br/>    envgroup = optional(list(object({<br/>      name      = string<br/>      hostnames = optional(list(string))<br/>    })))<br/>    keyvaluemaps = optional(list(object({<br/>      name = string<br/>      entries = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })))<br/>    })))<br/>    target = optional(list(object({<br/>      host        = string<br/>      name        = string<br/>      port        = number<br/>      description = optional(string)<br/>      is_enabled  = optional(bool)<br/>      protocol    = optional(string)<br/>      ssl = optional(list(object({<br/>        enabled                  = bool<br/>        client_auth_enabled      = optional(bool)<br/>        key_store                = optional(string)<br/>        key_alias                = optional(string)<br/>        trust_store              = optional(string)<br/>        ignore_validation_errors = optional(bool)<br/>        protocols                = optional(list(string))<br/>        ciphers                  = optional(list(string))<br/>      })))<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_environment_group"></a> [environment\_group](#input\_environment\_group) | List of Apigee environment groups to create | <pre>list(object({<br/>    name         = string<br/>    hostnames    = list(string)<br/>    display_name = optional(string)<br/>    description  = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_flowhook"></a> [flowhook](#input\_flowhook) | n/a | <pre>list(object({<br/>    flow_hook_point   = string<br/>    sharedflow        = string<br/>    description       = optional(string)<br/>    continue_on_error = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_iam_members"></a> [iam\_members](#input\_iam\_members) | n/a | <pre>object({<br/>    role   = string<br/>    member = string<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | n/a | <pre>list(object({<br/>    location                 = string<br/>    name                     = string<br/>    peering_cidr_range       = optional(string)<br/>    ip_range                 = optional(string)<br/>    description              = optional(string)<br/>    disk_encryption_key_name = optional(string)<br/>    consumer_accept_list     = optional(list(string))<br/>    access_logging_config = optional(list(object({<br/>      filter = optional(map(string))<br/>    })))<br/>    nat_address = optional(list(object({<br/>      name     = string<br/>      activate = optional(bool)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | n/a | <pre>list(object({<br/>    analytics_region                      = optional(string)<br/>    api_consumer_data_encryption_key_name = optional(string)<br/>    api_consumer_data_location            = optional(string)<br/>    authorized_network                    = optional(string)<br/>    billing_type                          = optional(string)<br/>    control_plane_encryption_key_name     = optional(string)<br/>    description                           = optional(string)<br/>    disable_vpc_peering                   = optional(bool)<br/>    display_name                          = optional(string)<br/>    retention                             = optional(string)<br/>    runtime_database_encryption_key_name  = optional(string)<br/>    runtime_type                          = optional(string)<br/>    advanced_api_ops_config               = optional(bool)<br/>    api_security_config                   = optional(bool)<br/>    connectors_platform_config            = optional(bool)<br/>    integration_config                    = optional(bool)<br/>    monetization_config                   = optional(bool)<br/>    identities                            = optional(list(string))<br/>    api = optional(list(object({<br/>      config_bundle = string<br/>      name          = string<br/>    })))<br/>    app_group = optional(list(object({<br/>      name         = string<br/>      channel_uri  = optional(string)<br/>      channel_id   = optional(string)<br/>      display_name = optional(string)<br/>      status       = optional(string)<br/>      attributes = optional(list(object({<br/>        name  = optional(string)<br/>        value = optional(string)<br/>      })))<br/>    })))<br/>    developper = optional(list(object({<br/>      email      = string<br/>      first_name = string<br/>      last_name  = string<br/>      user_name  = string<br/>    })))<br/>    endpoint_attachment = optional(list(object({<br/>      endpoint_attachment_id = string<br/>      location               = string<br/>      service_attachment     = string<br/>    })))<br/>    sharedflow = optional(list(object({<br/>      config_bundle = string<br/>      name          = string<br/>      revision      = optional(string)<br/>    })))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_developer"></a> [developer](#output\_developer) | n/a |
| <a name="output_environment"></a> [environment](#output\_environment) | n/a |
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
| <a name="output_organization"></a> [organization](#output\_organization) | n/a |
| <a name="output_target"></a> [target](#output\_target) | n/a |
