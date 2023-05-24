resource "azurerm_cdn_frontdoor_firewall_policy" "fd_waf_policy" {
  name                              = "azurefdwafpolicy"
  resource_group_name               = azurerm_resource_group.rg.name
  sku_name                          = azurerm_cdn_frontdoor_profile.my_front_door.sku_name
  enabled                           = true
  mode                              = "Prevention"
  custom_block_response_status_code = 403
  custom_block_response_body        = "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=="

  custom_rule {
    name                           = "Rule1"
    enabled                        = true
    priority                       = 1
    rate_limit_duration_in_minutes = 1
    rate_limit_threshold           = 10
    type                           = "MatchRule"
    action                         = "Block"

    match_condition {
      match_variable     = "SocketAddr"
      operator           = "IPMatch"
      negation_condition = true
      match_values       = ["10.0.1.0/24", "10.0.0.0/24"]
    }
  }
  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"
    action  = "Block"
  }
  managed_rule {
    type    = "Microsoft_BotManagerRuleSet"
    version = "1.0"
    action  = "Block"
  }

}


resource "azurerm_cdn_frontdoor_security_policy" "fd_secuirty_policy" {
  name                     = "fd-waf-Security-Policy"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.my_front_door.id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.fd_waf_policy.id

      association {
        domain {
          cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_endpoint.my_endpoint.id
        }
        patterns_to_match = ["/*"]
      }
    }
  }
}