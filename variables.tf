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
    advanced_api_ops_config               = optional(bool)
    api_security_config                   = optional(bool)
    connectors_platform_config            = optional(bool)
    integration_config                    = optional(bool)
    monetization_config                   = optional(bool)
    identities                            = optional(list(string))
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
    sharedflow = optional(list(object({
      config_bundle = string
      name          = string
      revision      = optional(string)
    })))
  }))
  default = []

  validation {
    condition     = alltrue([for org in var.organization : true if contains(["CLOUD", "HYBRID"], org.runtime_type)])
    error_message = "Runtime type must be either 'CLOUD' or 'HYBRID'."
  }

  validation {
    condition     = alltrue([for org in var.organization : true if contains(["PAYG", "SUBSCRIPTION"], org.billing_type)])
    error_message = "Billing type must be either 'PAYG' or 'SUBSCRIPTION'."
  }
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
    target = optional(list(object({
      host        = string
      name        = string
      port        = number
      description = optional(string)
      is_enabled  = optional(bool)
      protocol    = optional(string)
      ssl = optional(list(object({
        enabled                  = bool
        client_auth_enabled      = optional(bool)
        key_store                = optional(string)
        key_alias                = optional(string)
        trust_store              = optional(string)
        ignore_validation_errors = optional(bool)
        protocols                = optional(list(string))
        ciphers                  = optional(list(string))
      })))
    })))
  }))
  default = []

  validation {
    condition     = alltrue([for env in var.environment : true if can(regex("^[a-z0-9-]+$", env.name))])
    error_message = "Environment names must contain only lowercase letters, numbers, and hyphens."
  }

  validation {
    condition     = alltrue([for env in var.environment : true if contains(["PROGRAMMABLE", "CONFIGURABLE"], env.api_proxy_type)])
    error_message = "API proxy type must be either 'PROGRAMMABLE' or 'CONFIGURABLE'."
  }

  validation {
    condition     = alltrue([for env in var.environment : true if contains(["PROXY", "ARCHIVE"], env.deployment_type)])
    error_message = "Deployment type must be either 'PROXY' or 'ARCHIVE'."
  }

  validation {
    condition     = alltrue([for target in var.environment.*.target : true if contains(["HTTP", "HTTP2", "GRPC_TARGET", "GRPC", "EXTERNAL_CALLOUT"], target.protocol)])
    error_message = "Valid values are : HTTP, HTTP2, GRPC_TARGET, GRPC, EXTERNAL_CALLOUT."
  }
}

variable "environment_group" {
  description = "List of Apigee environment groups to create"
  type = list(object({
    name         = string
    hostnames    = list(string)
    display_name = optional(string)
    description  = optional(string)
  }))
  default = []

  validation {
    condition     = alltrue([for group in var.environment_group : true if can(regex("^[a-z0-9-]+$", group.name))])
    error_message = "Environment group names must contain only lowercase letters, numbers, and hyphens."
  }

  validation {
    condition     = alltrue([for group in var.environment_group : true if length(group.hostnames) > 0])
    error_message = "Environment groups must have at least one hostname."
  }
}

variable "iam_members" {
  type = object({
    role   = string
    member = string
  })
  default = null
}

variable "flowhook" {
  type = list(object({
    flow_hook_point   = string
    sharedflow        = string
    description       = optional(string)
    continue_on_error = optional(bool)
  }))
  default = []
}

variable "instance" {
  type = list(object({
    location                 = string
    name                     = string
    peering_cidr_range       = optional(string)
    ip_range                 = optional(string)
    description              = optional(string)
    disk_encryption_key_name = optional(string)
    consumer_accept_list     = optional(list(string))
    access_logging_config = optional(list(object({
      filter = optional(map(string))
    })))
    nat_address = optional(list(object({
      name     = string
      activate = optional(bool)
    })))
  }))
  default = []

  validation {
    condition     = alltrue([for instance in var.instance : true if can(regex("^[a-z0-9-]+$", instance.name))])
    error_message = "Instance names must contain only lowercase letters, numbers, and hyphens."
  }

  validation {
    condition     = alltrue([for instance in var.instance : true if can(regex("^[a-z0-9-]+$", instance.location))])
    error_message = "Instance locations must contain only lowercase letters, numbers, and hyphens."
  }
}