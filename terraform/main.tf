resource "azurerm_resource_group" "res-0" {
  location = "australiasoutheast"
  name = var.name
}
resource "azurerm_cdn_endpoint_custom_domain" "res-1" {
  cdn_endpoint_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Cdn/profiles/resume-cdn/endpoints/resume-cdn-endpoint105"
  host_name = var.name
  name = var.name
  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
  }
  depends_on = [
    azurerm_cdn_endpoint.res-60,
  ]
}
resource "azurerm_cosmosdb_account" "res-3" {
  automatic_failover_enabled = true
  free_tier_enabled          = true
  location                   = "australiasoutheast"
  name = var.name
  offer_type                 = "Standard"
  resource_group_name = var.resource_group_name
  tags = {
    defaultExperience       = "Core (SQL)"
    hidden-cosmos-mmspecial = ""
    hidden-workload-type    = "Learning"
  }
  consistency_policy {
    consistency_level = "Session"
  }
  geo_location {
    location = "australiasoutheast"
  }
  geo_location {
    failover_priority = 1
    location          = "australiaeast"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_cosmosdb_sql_database" "res-4" {
  account_name = var.name
  name = var.name
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_cosmosdb_account.res-3,
  ]
}
resource "azurerm_cosmosdb_sql_container" "res-5" {
  account_name = var.name
  database_name = var.name
  name = var.name
  partition_key_paths   = ["/part1"]
  partition_key_version = 2
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_cosmosdb_sql_database.res-4,
  ]
}
resource "azurerm_cosmosdb_sql_role_assignment" "res-7" {
  account_name = var.name
  principal_id        = "98bf1fb0-2277-4909-a34b-8aca9c4fb836"
  resource_group_name = var.resource_group_name
  role_definition_id  = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.DocumentDB/databaseAccounts/resume-cosmosdb/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  scope               = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.DocumentDB/databaseAccounts/resume-cosmosdb"
  depends_on = [
    azurerm_cosmosdb_sql_role_definition.res-9,
  ]
}
resource "azurerm_cosmosdb_sql_role_definition" "res-8" {
  account_name = var.name
  assignable_scopes   = ["/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.DocumentDB/databaseAccounts/resume-cosmosdb"]
  name = var.name
  resource_group_name = var.resource_group_name
  type                = "BuiltInRole"
  permissions {
    data_actions = ["Microsoft.DocumentDB/databaseAccounts/readMetadata", "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery", "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read", "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed"]
  }
  depends_on = [
    azurerm_cosmosdb_account.res-3,
  ]
}
resource "azurerm_cosmosdb_sql_role_definition" "res-9" {
  account_name = var.name
  assignable_scopes   = ["/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.DocumentDB/databaseAccounts/resume-cosmosdb"]
  name = var.name
  resource_group_name = var.resource_group_name
  type                = "BuiltInRole"
  permissions {
    data_actions = ["Microsoft.DocumentDB/databaseAccounts/readMetadata", "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*", "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*"]
  }
  depends_on = [
    azurerm_cosmosdb_account.res-3,
  ]
}
resource "azurerm_user_assigned_identity" "res-13" {
  location            = "australiasoutheast"
  name = var.name
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_federated_identity_credential" "res-14" {
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "var.endpoint_url"
  name = var.name
  parent_id           = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.ManagedIdentity/userAssignedIdentities/resume-function-id-9577"
  resource_group_name = var.resource_group_name
  subject             = "repo:Electr0105/resume-backend:ref:refs/heads/main"
  depends_on = [
    azurerm_user_assigned_identity.res-13,
  ]
}
resource "azurerm_storage_account" "res-15" {
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
  location                        = "australiasoutheast"
  name = var.name
  resource_group_name = var.resource_group_name
  custom_domain {
    name = var.name
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_storage_container" "res-17" {
  name = var.name
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumesitedeployment"
  depends_on = [
    # One of azurerm_storage_account.res-15,azurerm_storage_account_queue_properties.res-19 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_storage_account_queue_properties" "res-19" {
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumesitedeployment"
  hour_metrics {
    version = "1.0"
  }
  logging {
    version = "1.0"
  }
  minute_metrics {
    version = "1.0"
  }
  depends_on = [
    azurerm_storage_account.res-15,
  ]
}
resource "azurerm_storage_account" "res-21" {
  account_kind                    = "Storage"
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
  default_to_oauth_authentication = true
  location                        = "australiasoutheast"
  name = var.name
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_storage_container" "res-23" {
  name = var.name
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumewebsite91ce"
  depends_on = [
    # One of azurerm_storage_account.res-21,azurerm_storage_account_queue_properties.res-27 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_storage_container" "res-24" {
  name = var.name
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumewebsite91ce"
  depends_on = [
    # One of azurerm_storage_account.res-21,azurerm_storage_account_queue_properties.res-27 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_storage_container" "res-25" {
  name = var.name
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumewebsite91ce"
  depends_on = [
    # One of azurerm_storage_account.res-21,azurerm_storage_account_queue_properties.res-27 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_storage_account_queue_properties" "res-27" {
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumewebsite91ce"
  hour_metrics {
    version = "1.0"
  }
  logging {
    version = "1.0"
  }
  minute_metrics {
    version = "1.0"
  }
  depends_on = [
    azurerm_storage_account.res-21,
  ]
}
resource "azurerm_storage_table" "res-29" {
  name = var.name
  storage_account_name = var.name
}
resource "azurerm_storage_account" "res-30" {
  account_kind                    = "Storage"
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
  default_to_oauth_authentication = true
  location                        = "australiasoutheast"
  name = var.name
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_storage_container" "res-32" {
  name = var.name
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumewebsitea078"
  depends_on = [
    # One of azurerm_storage_account.res-30,azurerm_storage_account_queue_properties.res-36 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_storage_container" "res-33" {
  name = var.name
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumewebsitea078"
  depends_on = [
    # One of azurerm_storage_account.res-30,azurerm_storage_account_queue_properties.res-36 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_storage_container" "res-34" {
  name = var.name
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumewebsitea078"
  depends_on = [
    # One of azurerm_storage_account.res-30,azurerm_storage_account_queue_properties.res-36 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_storage_account_queue_properties" "res-36" {
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumewebsitea078"
  hour_metrics {
    version = "1.0"
  }
  logging {
    version = "1.0"
  }
  minute_metrics {
    version = "1.0"
  }
  depends_on = [
    azurerm_storage_account.res-30,
  ]
}
resource "azurerm_storage_table" "res-38" {
  name = var.name
  storage_account_name = var.name
}
resource "azurerm_storage_account" "res-39" {
  account_kind                    = "Storage"
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
  default_to_oauth_authentication = true
  location                        = "australiasoutheast"
  name = var.name
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_storage_container" "res-41" {
  name = var.name
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumewebsiteb7de"
  depends_on = [
    # One of azurerm_storage_account.res-39,azurerm_storage_account_queue_properties.res-45 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_storage_container" "res-42" {
  name = var.name
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumewebsiteb7de"
  depends_on = [
    # One of azurerm_storage_account.res-39,azurerm_storage_account_queue_properties.res-45 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_storage_container" "res-43" {
  name = var.name
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumewebsiteb7de"
  depends_on = [
    # One of azurerm_storage_account.res-39,azurerm_storage_account_queue_properties.res-45 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_storage_account_queue_properties" "res-45" {
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Storage/storageAccounts/resumewebsiteb7de"
  hour_metrics {
    version = "1.0"
  }
  logging {
    version = "1.0"
  }
  minute_metrics {
    version = "1.0"
  }
  depends_on = [
    azurerm_storage_account.res-39,
  ]
}
resource "azurerm_storage_table" "res-47" {
  name = var.name
  storage_account_name = var.name
}
resource "azurerm_service_plan" "res-48" {
  location            = "australiasoutheast"
  name = var.name
  os_type             = "Linux"
  resource_group_name = var.resource_group_name
  sku_name = var.name
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_linux_function_app" "res-49" {
  app_settings = {
    CosmosDBConnection                   = "AccountEndpoint=var.endpoint_url"
    DEPLOYMENT_STORAGE_CONNECTION_STRING = "DefaultEndpointsProtocol=https;AccountName=resumewebsiteb7de;AccountKey${var.connection_string};EndpointSuffix=core.windows.net"
  }
  builtin_logging_enabled                        = false
  client_certificate_mode                        = "Required"
  ftp_publish_basic_authentication_enabled       = false
  functions_extension_version                    = ""
  https_only                                     = true
  location                                       = "australiasoutheast"
  name = var.name
  resource_group_name = var.resource_group_name
  service_plan_id                                = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Web/serverFarms/ASP-resumewebsite-9851"
  storage_account_access_key                     = var.connection_string 
  storage_account_name = var.name
  webdeploy_publish_basic_authentication_enabled = false
  site_config {
    application_insights_connection_string = "InstrumentationKey=24f6faf9-d69b-46dc-a751-7953ff4c4748;IngestionEndpoint=var.endpoint_url"
    application_insights_key               = "24f6faf9-d69b-46dc-a751-7953ff4c4748"
    ftps_state                             = "FtpsOnly"
    ip_restriction_default_action          = ""
    scm_ip_restriction_default_action      = ""
    cors {
      allowed_origins = ["http://127.0.0.1:12333", "var.endpoint_url", "var.endpoint_url", "var.endpoint_url"]
    }
  }
  sticky_settings {
    app_setting_names = ["APPINSIGHTS_INSTRUMENTATIONKEY", "APPLICATIONINSIGHTS_CONNECTION_STRING ", "APPINSIGHTS_PROFILERFEATURE_VERSION", "APPINSIGHTS_SNAPSHOTFEATURE_VERSION", "ApplicationInsightsAgent_EXTENSION_VERSION", "XDT_MicrosoftApplicationInsights_BaseExtensions", "DiagnosticServices_EXTENSION_VERSION", "InstrumentationEngine_EXTENSION_VERSION", "SnapshotDebugger_EXTENSION_VERSION", "XDT_MicrosoftApplicationInsights_Mode", "XDT_MicrosoftApplicationInsights_PreemptSdk", "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT", "XDT_MicrosoftApplicationInsightsJava", "XDT_MicrosoftApplicationInsights_NodeJS"]
  }
  depends_on = [
    azurerm_service_plan.res-48,
  ]
}
resource "azurerm_function_app_function" "res-53" {
  config_json = jsonencode({
    bindings = [{
      connection    = "CosmosDBConnection"
      containerName = "resume-container"
      databaseName  = "resume-db"
      direction     = "OUT"
      name = var.name
      type          = "cosmosDB"
      }, {
      connection    = "CosmosDBConnection"
      containerName = "resume-container"
      databaseName  = "resume-db"
      direction     = "IN"
      name = var.name
      type          = "cosmosDB"
      }, {
      authLevel = "ANONYMOUS"
      direction = "IN"
      name = var.name
      route     = "visitorcount"
      type      = "httpTrigger"
      }, {
      direction = "OUT"
      name = var.name
      type      = "http"
    }]
    entryPoint        = "increment_visitor_count"
    functionDirectory = "/home/site/wwwroot"
    language          = "python"
    name = var.name
    scriptFile        = "function_app.py"
  })
  function_app_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Web/sites/resume-functions"
  name = var.name
  depends_on = [
    azurerm_linux_function_app.res-49,
  ]
}
resource "azurerm_app_service_custom_hostname_binding" "res-54" {
  app_service_name = var.name
  hostname = var.name
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_linux_function_app.res-49,
  ]
}
resource "azurerm_static_web_app" "res-55" {
  location            = "eastasia"
  name = var.name
  repository_branch   = "main"
  repository_url      = "var.endpoint_url"
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_static_web_app_custom_domain" "res-57" {
  domain_name = var.domain_name
  static_web_app_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Web/staticSites/resume-site"
  depends_on = [
    azurerm_static_web_app.res-55,
  ]
}
resource "azurerm_static_web_app_custom_domain" "res-58" {
  domain_name = var.domain_name
  static_web_app_id = "/subscriptions/${var.subscription_id}/resourceGroups/resume-website/providers/Microsoft.Web/staticSites/resume-site"
  depends_on = [
    azurerm_static_web_app.res-55,
  ]
}
resource "azurerm_cdn_profile" "res-59" {
  location            = "global"
  name = var.name
  resource_group_name = var.resource_group_name
  sku                 = "Standard_Microsoft"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_cdn_endpoint" "res-60" {
  content_types_to_compress = ["application/eot", "application/font", "application/font-sfnt", "application/javascript", "application/json", "application/opentype", "application/otf", "application/pkcs7-mime", "application/truetype", "application/ttf", "application/vnd.ms-fontobject", "application/x-font-opentype", "application/x-font-truetype", "application/x-font-ttf", "application/x-httpd-cgi", "application/x-javascript", "application/x-mpegurl", "application/x-opentype", "application/x-otf", "application/x-perl", "application/x-ttf", "application/xhtml+xml", "application/xml", "application/xml+rss", "font/eot", "font/opentype", "font/otf", "font/ttf", "image/svg+xml", "text/css", "text/csv", "text/html", "text/javascript", "text/js", "text/plain", "text/richtext", "text/tab-separated-values", "text/x-component", "text/x-java-source", "text/x-script", "text/xml"]
  is_compression_enabled    = true
  location                  = "global"
  name = var.name
  origin_host_header        = "resumesitedeployment.z26.web.core.windows.net"
  profile_name = var.name
  resource_group_name = var.resource_group_name
  origin {
    host_name = var.name
    name = var.name
  }
  depends_on = [
    azurerm_cdn_profile.res-59,
  ]
}
resource "azurerm_application_insights" "res-61" {
  application_type    = "web"
  location            = "australiasoutheast"
  name = var.name
  resource_group_name = var.resource_group_name
  sampling_percentage = 0
  workspace_id        = "/subscriptions/${var.subscription_id}/resourceGroups/DefaultResourceGroup-SEAU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-c4b54449-d7ba-4b28-b872-37d2da4cfdf2-SEAU"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}

