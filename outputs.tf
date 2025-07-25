output "organization" {
  value = {
    for a in google_apigee_organization.this : a => {
      id                                    = a.id
      name                                  = a.name
      display_name                          = a.display_name
      analytics_region                      = a.analytics_region
      api_consumer_data_encryption_key_name = a.api_consumer_data_encryption_key_name
      api_consumer_data_location            = a.api_consumer_data_location
      apigee_project_id                     = a.apigee_project_id
      authorized_network                    = a.authorized_network
      billing_type                          = a.billing_type
      ca_certificate                        = a.ca_certificate
      control_plane_encryption_key_name     = a.control_plane_encryption_key_name
      disable_vpc_peering                   = a.disable_vpc_peering
      retention                             = a.retention
      runtime_database_encryption_key_name  = a.runtime_database_encryption_key_name
      runtime_type                          = a.runtime_type
      subscription_type                     = a.subscription_type
    }
  }
}

output "developer" {
  value = {
    for a in google_apigee_developer.this : a => {
      id               = a.id
      attributes       = a.attributes
      status           = a.status
      created_at       = a.created_at
      user_name        = a.user_name
      email            = a.email
      first_name       = a.first_name
      last_name        = a.last_name
      last_modified_at = a.last_modified_at
    }
  }
}

output "environment" {
  value = {
    for a in google_apigee_environment.this : a => {
      id                = a.id
      name              = a.name
      display_name      = a.display_name
      type              = a.type
      description       = a.description
      api_proxy_type    = a.api_proxy_type
      deployment_type   = a.deployment_type
      forward_proxy_uri = a.forward_proxy_uri
      node_config       = a.node_config
      org_id            = a.org_id
    }
  }
}

output "instance" {
  value = {
    for a in google_apigee_instance.this : a => {
      id                       = a.id
      name                     = a.name
      display_name             = a.display_name
      description              = a.description
      org_id                   = a.org_id
      host                     = a.host
      ip_range                 = a.ip_range
      port                     = a.port
      consumer_accept_list     = a.consumer_accept_list
      disk_encryption_key_name = a.disk_encryption_key_name
      peering_cidr_range       = a.peering_cidr_range
      service_attachment       = a.service_attachment
    }
  }
}

output "target" {
  value = {
    for a in google_apigee_target_server.this : a => {
      id          = a.id
      name        = a.name
      description = a.description
      host        = a.host
      port        = a.port
      is_enabled  = a.is_enabled
      protocol    = a.protocol
      s_sl_info   = a.s_sl_info
    }
  }
}