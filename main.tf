resource "google_apigee_organization" "this" {
  for_each                              = { for a in var.organization : a.display_name => a }
  project_id                            = data.google_project.this.project_id
  analytics_region                      = each.value.analytics_region
  api_consumer_data_encryption_key_name = each.value.api_consumer_data_encryption_key_name
  api_consumer_data_location            = each.value.api_consumer_data_location
  authorized_network                    = each.value.authorized_network
  billing_type                          = each.value.billing_type
  control_plane_encryption_key_name     = each.value.control_plane_encryption_key_name
  description                           = each.value.description
  disable_vpc_peering                   = each.value.disable_vpc_peering
  display_name                          = each.value.display_name
  retention                             = each.value.retention
  runtime_database_encryption_key_name  = each.value.runtime_database_encryption_key_name
  runtime_type                          = each.value.runtime_type

  dynamic "properties" {
    for_each = { for a in var.organization : a.display_name => a if contains(keys(a), "properties") && a.properties != null }
    content {
      property {
        name  = lookup(each.value, "name")
        value = lookup(each.value, "value")
      }
    }
  }
}

resource "google_apigee_addons_config" "this" {
  for_each = { for b in var.organization : b.display_name => b if contains(keys(b), "addons") && b.addons != null }
  org      = google_apigee_organization.this[each.key].name
  addons_config {
    advanced_api_ops_config {
      enabled = lookup(each.value, "advanced_api_ops_config")
    }
    api_security_config {
      enabled = lookup(each.value, "api_security_config")
    }
    connectors_platform_config {
      enabled = lookup(each.value, "connectors_platform_config")
    }
    integration_config {
      enabled = lookup(each.value, "integration_config")
    }
    monetization_config {
      enabled = lookup(each.value, "monetization_config")
    }
  }
}

resource "google_apigee_api" "this" {
  for_each      = { for c in var.organization : c.display_name => c if contains(keys(c), "api") && c.api != null }
  config_bundle = lookup(each.value, "config_bundle")
  name          = lookup(each.value, "name")
  org_id        = google_apigee_organization.this[each.key].name
}

resource "google_apigee_app_group" "this" {
  for_each     = { for d in var.organization : d.display_name => d if contains(keys(d), "app_group") && d.app_group != null }
  name         = lookup(each.value, "name")
  org_id       = google_apigee_organization.this[each.key].name
  channel_uri  = lookup(each.value, "channel_uri")
  channel_id   = lookup(each.value, "channel_id")
  display_name = lookup(each.value, "display_name")
  status       = lookup(each.value, "status")

  dynamic "attributes" {
    for_each = { for d in var.organization.*.app_group : d.name => d if contains(keys(d), "attributes") && d.attributes != null }
    content {
      name  = lookup(attributes.value, "name")
      value = lookup(attributes.value, "value")
    }
  }
}

resource "google_apigee_developer" "this" {
  for_each   = { for e in var.organization : e.display_name => e if contains(keys(e), "developper") && e.developper != null }
  email      = lookup(each.value, "email")
  first_name = lookup(each.value, "first_name")
  last_name  = lookup(each.value, "last_name")
  org_id     = google_apigee_organization.this[each.key].id
  user_name  = lookup(each.value, "user_name")
}

resource "google_apigee_endpoint_attachment" "" {
  endpoint_attachment_id = ""
  location               = ""
  org_id                 = ""
  service_attachment     = ""
}

resource "google_apigee_env_keystore" "" {
  env_id = ""
}

resource "google_apigee_env_references" "" {
  env_id        = ""
  name          = ""
  refers        = ""
  resource_type = ""
}

resource "google_apigee_envgroup" "" {
  name   = ""
  org_id = ""
}

resource "google_apigee_envgroup_attachment" "" {
  envgroup_id = ""
  environment = ""
}

resource "google_apigee_environment" "" {
  name   = ""
  org_id = ""
}

resource "google_apigee_environment_iam_member" "" {
  env_id = ""
  member = ""
  org_id = ""
  role   = ""
}

resource "google_apigee_environment_keyvaluemaps" "" {
  env_id = ""
  name   = ""
}

resource "google_apigee_flowhook" "" {
  environment     = ""
  flow_hook_point = ""
  org_id          = ""
  sharedflow      = ""
}

resource "google_apigee_instance" "" {
  location = ""
  name     = ""
  org_id   = ""
}

resource "google_apigee_instance_attachment" "" {
  environment = ""
  instance_id = ""
}

resource "google_apigee_environment_keyvaluemaps_entries" "" {
  env_keyvaluemap_id = ""
  name               = ""
  value              = ""
}

resource "google_apigee_keystores_aliases_key_cert_file" "" {
  alias       = ""
  cert        = ""
  environment = ""
  keystore    = ""
  org_id      = ""
}

resource "google_apigee_keystores_aliases_pkcs12" "" {
  alias       = ""
  environment = ""
  file        = ""
  filehash    = ""
  keystore    = ""
  org_id      = ""
}

resource "google_apigee_keystores_aliases_self_signed_cert" "" {
  alias       = ""
  environment = ""
  keystore    = ""
  org_id      = ""
  sig_alg     = ""
}

resource "google_apigee_nat_address" "" {
  instance_id = ""
  name        = ""
}

resource "google_apigee_sharedflow" "" {
  config_bundle = ""
  name          = ""
  org_id        = ""
}

resource "google_apigee_sharedflow_deployment" "" {
  environment   = ""
  org_id        = ""
  revision      = ""
  sharedflow_id = ""
}

resource "google_apigee_sync_authorization" "" {
  identities = []
  name       = ""
}

resource "google_apigee_target_server" "" {
  env_id = ""
  host   = ""
  name   = ""
  port   = 0
}