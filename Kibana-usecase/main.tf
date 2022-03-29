provider "kibana" {
  url      = "https://tmcompeto-66a1eb.kb.us-central1.gcp.cloud.es.io:9243"
  username = "elastic"
  password = "iJW5deqSSBWyIiJ3EsiZzt9N"
  insecure = true
}

resource "kibana_user_space" "test-space" {
  uid               = "1230862250"
  name              = "Group_Name Space" #Name of the space seen in kibana
  description       = "This is test space"
  initials          = "TT"
  disabled_features = ["canvas", "maps", "advancedSettings", "indexPatterns", "graph", "monitoring", "ml", "apm", "infrastructure", "logs", "siem"]
}

#acess control for Kibana space
resource "kibana_role" "test-roll" {
  name = "terraform-test-roll"
  elasticsearch {
    indices {
      names      = ["vfnz-app_env-logs-Application_Name-*", "vfnz-app_env-metrics-Application_Name-*"]
      privileges = ["read", "create_index", "indices:admin/auto_create"]
    }
    indices {
      names      = ["vfnz-app_env-admin-Application_Name-*"]
      privileges = ["all"]
    }
    cluster = ["all"]
  }
  kibana {
    features {
      name        = "discover"
      permissions = ["read"]
    }
    features {
      name        = "dashboard"
      permissions = ["read"]
    }
    features {
      name        = "maps"
      permissions = ["read"]
    }
    features {
      name        = "canvas"
      permissions = ["read"]
    }
    spaces = ["default"]
  }
}
