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
  }))
}