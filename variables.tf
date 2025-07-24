variable "organization" {
  type = list(object({
    analytics_region                      = optional(string)
    api_consumer_data_encryption_key_name = optional(string)
    api_consumer_data_location            = optional(string)
    authorized_network                    = optional(string)
    billing_type                          = optional(string)
    control_plane_encryption_key_name     = optional(string)
    description                           = optional(string)
    disable_vpc_peering                   = optional(bool)
    display_name                          = optional(string)
    retention                             = optional(string)
    runtime_database_encryption_key_name  = optional(string)
    runtime_type                          = optional(string)
    properties = optional(list(object({
      name  = optional(string)
      value = optional(string)
    })))
    addons = optional(list(object({
      advanced_api_ops_config    = optional(bool)
      api_security_config        = optional(bool)
      connectors_platform_config = optional(bool)
      integration_config         = optional(bool)
      monetization_config        = optional(bool)
    })))
    api = optional(list(object({
      config_bundle = string
      name          = string
    })))
    app_group = optional(list(object({
      name         = string
      channel_uri  = optional(string)
      channel_id   = optional(string)
      display_name = optional(string)
      status       = optional(string)
      attributes = optional(list(object({
        name  = optional(string)
        value = optional(string)
      })))
    })))
    developper = optional(list(object({
      email      = string
      first_name = string
      last_name  = string
      user_name  = string
    })))
    endpoint_attachment = optional(list(object({
      endpoint_attachment_id = string
      location               = string
      service_attachment     = string
    })))
  }))
}

variable "environment" {
  type = list(object({
    name              = string
    display_name      = optional(string)
    deployment_type   = optional(string)
    api_proxy_type    = optional(string)
    type              = optional(string)
    forward_proxy_uri = optional(string)
    min_node_count    = optional(string)
    max_node_count    = optional(string)
    env_keystore = optional(list(object({
      name = optional(string)
    })))
    env_references = optional(list(object({
      name          = string
      refers        = string
      resource_type = string
      description   = optional(string)
    })))
    envgroup = optional(list(object({
      name      = string
      hostnames = optional(list(string))
    })))
    keyvaluemaps = optional(list(object({
      name = string
      entries = optional(list(object({
        name  = string
        value = string
      })))
    })))
  }))
}

variable "iam_members" {
  type = object({
    role   = string
    member = string
  })
}