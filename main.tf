# It will be create a Resource Group #
resource "azurerm_resource_group" "rg" {
  name = "${var.resorce_group_name}"
  location = "Central US"
}

# Creating Storage Account #
resource "azurerm_storage_account" "functionstorage_2023" {
    name                         = "functionapptest2023"
    resource_group_name          = azurerm_resource_group.rg
    location                     = azurerm_resource_group.rg.location
    account_tier =               = "Standard"
    account_replication_type     = "GRS"
    account_kind                 =  "StorageV2"
    min_tls_version              = "TLS1_2"
    enable_https_traffic_only    = true

    static_website {
      index_document = "index.html"
    }
}

# Creating Storage Container #
resource "azurerm_storage_container" "storage_container" {
    name = "storage-container"
    storage_account_name = azurerm_storage_account.functionstorage_2023.name
    container_access_type = "private"
}

# Creating Blob Storage #
resource "azurerm_storage_blob" "storage_blob" {
    name = "functions.zip"
    storage_account_name = azurerm_storage_account.functionstorage_2023.name
    storage_container_name = azurerm_storage_container.storage_container.name
    type = "Block"
    # You will need to put the  zip file name of functions #
    source = "./function.zip" 
}

# data sourcing Storage sas account #
data "azurerm_storage_account_sas" "storage_account_sas" {
    connection_string = azurerm_storage_account.functionstorage_2023.primary_connection_string
    https_only = true
    signed_version = "2017-07-29" 

resource_types {
 service = false
 container = false
 object = true
 }
services {
 blob = true
 queue = false
 table = false
 file = false
 }
start   = "2023-03-21T00:00:00Z"
 expiry = "2024-03-21T00:00:00Z"
permissions {
 read    = true
 write   = true
 delete  = false
 list    = false
 add     = true
 create  = false
 update  = false
 process = false
 }
}

# creating Functions App Plan #
resource "azurerm_service_plan" "function_app_plan" {
  name = "azure-function-service-plan"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type = "Windows"
  sku_name = "Y1"
}

# Creating Application Insights #
resource "azurerm_application_insights" "myappinsights" {
  name                  = "myappinsights"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  application_type      = "java"
}

# Creating  Windows based Functions App #
resource "azurerm_windows_function_app" "windows_function_app {
  name                       = "windows-func-app"
  resource_group_name        = azurerm_resorce_group.rg.name
  location                   = azurerm_resource_group_rg.location
  storage_account_name       = azurerm_storage_account.functionstorage_2023.name
  storage_account_access_key = azurerm_storage_account.functionstorage_2023.primary_access_key
  service_plan_id            = azurerm_service_paln.function_app_plan.id

  app_setting = {
    FUNCTION_EXTENSION_VERSION  = "~4"
    FUNCTION_WORKER_RUNTIME     = "java"
    https_only                  =  true
    WEBSITE_RUN_FROM_PACKAGE    = "https://${azurerm_storage_account.functionstorage_2023.name}.blob.core.windows.net/${azurerm_storage_container.storage_container.name}/${azurerm_storage_blob.storage_blob.name}${data.azurerm_storage_account_sas.storage_account_sas.sas}"
  }

  site_config {
    always_on      = false
    https2_enabled = true
    ftps_state     = "FtpsOnly"
  }
}