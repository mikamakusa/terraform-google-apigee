resource "google_apigee_organization" "this" {
  for_each                              = { for idx, organization in var.organization : organization.display_name => organization }
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
}

resource "google_apigee_addons_config" "this" {
  for_each = { for idx, organization in var.organization : organization.display_name => organization }
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
  for_each      = { for idx, organization in var.organization : organization.display_name => organization if contains(keys(organization), "api") && organization.api != null }
  config_bundle = lookup(each.value, "config_bundle")
  name          = lookup(each.value, "name")
  org_id        = google_apigee_organization.this[each.key].name
}

resource "google_apigee_app_group" "this" {
  for_each     = { for idx, organization in var.organization : organization.display_name => organization if contains(keys(organization), "app_group") && organization.app_group != null }
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

resource "google_apigee_endpoint_attachment" "this" {
  for_each               = { for f in var.organization : f.display_name => f if contains(keys(f), "endpoint_attachment") && f.endpoint_attachment != null }
  endpoint_attachment_id = lookup(each.value, "endpoint_attachment_id")
  location               = lookup(each.value, "location")
  org_id                 = google_apigee_organization.this[each.key].id
  service_attachment     = lookup(each.value, "service_attachment")
}

resource "google_apigee_environment" "this" {
  for_each          = { for g in var.environment : g.name => g }
  name              = join("-", [each.value.name, "environment"])
  org_id            = google_apigee_organization.this[join("-", [each.value.name, "organization"])].id
  display_name      = each.value.display_name
  deployment_type   = each.value.deployment_type
  api_proxy_type    = each.value.api_proxy_type
  type              = each.value.type
  forward_proxy_uri = each.value.forward_proxy_uri
  node_config {
    min_node_count = each.value.min_node_count
    max_node_count = each.value.max_node_count
  }
}

resource "google_apigee_env_keystore" "this" {
  for_each = { for g in var.environment : g.name => g if contains(keys(g), "env_keystore") && g.env_keystore != null }
  env_id   = google_apigee_environment.this[each.key].id
  name     = lookup(each.value, "name")
}

resource "google_apigee_env_references" "this" {
  for_each      = { for g in var.environment : g.name => g if contains(keys(g), "env_references") && g.env_references != null }
  env_id        = google_apigee_environment.this[each.key].id
  name          = lookup(each.value, "name")
  refers        = lookup(each.value, "refers")
  resource_type = lookup(each.value, "resource_type")
  description   = lookup(each.value, "description")
}

resource "google_apigee_envgroup" "this" {
  for_each  = { for g, group in var.environment_group : group.name => group }
  name      = each.value.name
  org_id    = google_apigee_environment.this[0].id
  hostnames = each.value.hostnames
}

resource "google_apigee_envgroup_attachment" "this" {
  for_each    = { for i, env in var.environment : env.name => env if contains([for group in var.environment_group : group.name], "default") }
  envgroup_id = google_apigee_envgroup.this["default"].id
  environment = google_apigee_environment.this[each.key].name
}

resource "google_apigee_environment_iam_member" "this" {
  env_id = google_apigee_environment.this[0].id
  member = var.iam_members.member
  org_id = google_apigee_organization.this[0].id
  role   = var.iam_members.role
}

resource "google_apigee_environment_keyvaluemaps" "this" {
  for_each   = { for g in var.environment : g.name => g if contains(keys(g), "keyvaluemaps") && g.keyvaluemaps != null }
  env_id     = google_apigee_environment.this[each.key].id
  name       = lookup(each.value, "name")
  depends_on = [google_apigee_organization.this, google_apigee_environment.this, google_apigee_instance.this, google_apigee_instance_attachment.this]
}

resource "google_apigee_environment_keyvaluemaps_entries" "this" {
  for_each           = { for g in var.environment.*.keyvaluemaps : g.name => g if contains(keys(g), "entries") && g.entries != null }
  env_keyvaluemap_id = google_apigee_environment_keyvaluemaps.this[each.key].id
  name               = lookup(each.value, "name")
  value              = lookup(each.value, "value")
}

resource "google_apigee_flowhook" "this" {
  for_each          = { for f in var.flowhook : f.flow_hook_point => f }
  environment       = google_apigee_environment.this[0].id
  flow_hook_point   = each.value.flow_hook_point
  org_id            = google_apigee_organization.this[0].id
  sharedflow        = each.value.sharedflow
  description       = each.value.description
  continue_on_error = each.value.continue_on_error
}

resource "google_apigee_instance" "this" {
  for_each                 = { for g in var.instance : g.name => g }
  location                 = each.value.location
  name                     = each.value.name
  org_id                   = google_apigee_organization.this[0].id
  peering_cidr_range       = each.value.peering_cidr_range
  ip_range                 = each.value.ip_range
  description              = each.value.description
  disk_encryption_key_name = each.value.disk_encryption_key_name
  consumer_accept_list     = each.value.consumer_accept_list

  dynamic "access_logging_config" {
    for_each = { for g in var.instance : g.name => g if contains(keys(g), "access_logging_config") && g.access_logging_config != null }
    content {
      enabled = true
      filter  = lookup(each.value, "filter")
    }
  }
}

resource "google_apigee_instance_attachment" "this" {
  for_each    = { for i, env in var.environment : env.name => env if contains([for instance in var.instance : instance.name], "default") }
  environment = google_apigee_environment.this[0].name
  instance_id = google_apigee_instance.this["default"].id
}

/*resource "google_apigee_keystores_aliases_key_cert_file" "this" {
  alias       = ""
  cert        = ""
  environment = ""
  keystore    = ""
  org_id      = ""
  key = ""
  password = ""
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
}*/

resource "google_apigee_nat_address" "this" {
  for_each    = { for g in var.instance : g.name => g if contains(keys(g), "nat_address") && g.nat_address != null }
  instance_id = google_apigee_instance.this[each.key].id
  name        = lookup(each.value, "name")
  activate    = lookup(each.value, "activate")
}

resource "google_apigee_sharedflow" "this" {
  for_each      = { for g in var.organization : g.display_name => g if contains(keys(g), "sharedflow") && g.sharedflow != null }
  config_bundle = lookup(each.value, "config_bundle")
  name          = lookup(each.value, "name")
  org_id        = google_apigee_organization.this[each.key].id
}

resource "google_apigee_sharedflow_deployment" "this" {
  for_each      = { for g in var.organization : g.display_name => g if contains(keys(g), "sharedflow") && g.sharedflow != null && g.sharedflow.*.revision != null }
  environment   = google_apigee_environment.this[0].id
  org_id        = google_apigee_organization.this[0].id
  revision      = lookup(each.value, "revision")
  sharedflow_id = google_apigee_sharedflow.this[0].id
}

resource "google_apigee_sync_authorization" "this" {
  for_each   = { for g in var.organization : g.display_name => g if contains(keys(g), "identities") && g.identities != null }
  identities = lookup(each.value, "identities")
  name       = google_apigee_organization.this[0].name
}

resource "google_apigee_target_server" "this" {
  for_each    = { for g in var.environment : g.name => g if contains(keys(g), "target") && g.target != null }
  env_id      = google_apigee_environment.this[each.key].id
  host        = lookup(each.value, "host")
  name        = lookup(each.value, "name")
  port        = lookup(each.value, "port")
  description = lookup(each.value, "description")
  is_enabled  = lookup(each.value, "is_enabled")
  protocol    = lookup(each.value, "protocol")

  dynamic "s_sl_info" {
    for_each = { for g in var.environment.*.target : g.name => g if contains(keys(g), "ssl") && g.ssl != null }
    content {

      enabled                  = lookup(each.value, "enabled")
      client_auth_enabled      = lookup(each.value, "client_auth_enabled")
      key_store                = lookup(each.value, "key_store")
      key_alias                = lookup(each.value, "key_alias")
      trust_store              = lookup(each.value, "trust_store")
      ignore_validation_errors = lookup(each.value, "ignore_validation_errors")
      protocols                = lookup(each.value, "protocols")
      ciphers                  = lookup(each.value, "ciphers")
    }
  }
}