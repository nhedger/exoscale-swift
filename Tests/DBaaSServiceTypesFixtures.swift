import Foundation

enum DBaaSServiceTypesFixtures {
    static let grafana = Data(#"""
    {
      "connection-info" : {
        "password" : "secret",
        "uri" : "https://grafana.example.com",
        "username" : "avnadmin"
      },
      "grafana-settings" : {
        "allow_embedding" : true
      },
      "name" : "grafana",
      "plan" : "startup-4",
      "state" : "running",
      "type" : "grafana"
    }
    """#.utf8)

    static let kafka = Data(#"""
    {
      "authentication-methods" : {
        "certificate" : true,
        "sasl" : true
      },
      "connection-info" : {
        "connect-uri" : "https://connect.example.com",
        "nodes" : [
          "kafka.example.com:9092"
        ]
      },
      "name" : "kafka",
      "plan" : "startup-4",
      "schema-registry-enabled" : true,
      "state" : "running",
      "type" : "kafka",
      "users" : [
        {
          "access-cert" : "cert",
          "username" : "app"
        }
      ]
    }
    """#.utf8)

    static let mysql = Data(#"""
    {
      "connection-info" : {
        "params" : [
          {
            "host" : "mysql.example.com"
          }
        ],
        "uri" : [
          "mysql://user:pass@mysql.example.com/defaultdb"
        ]
      },
      "databases" : [
        "defaultdb"
      ],
      "mysql-settings" : {
        "sql_require_primary_key" : true
      },
      "name" : "mysql",
      "plan" : "startup-4",
      "state" : "running",
      "type" : "mysql"
    }
    """#.utf8)

    static let opensearch = Data(#"""
    {
      "connection-info" : {
        "dashboard-uri" : "https://dash.example.com",
        "uri" : [
          "https://os.example.com"
        ]
      },
      "index-template" : {
        "number-of-shards" : 3
      },
      "name" : "os",
      "opensearch-dashboards" : {
        "enabled" : true
      },
      "plan" : "startup-4",
      "state" : "running",
      "type" : "opensearch"
    }
    """#.utf8)

    static let thanos = Data(#"""
    {
      "connection-info" : {
        "query-uri" : "https://query.example.com"
      },
      "name" : "thanos",
      "plan" : "startup-4",
      "state" : "running",
      "thanos-settings" : {
        "compactor" : {
          "retention.days" : 30
        }
      },
      "type" : "thanos"
    }
    """#.utf8)

    static let valkey = Data(#"""
    {
      "connection-info" : {
        "password" : "secret",
        "uri" : [
          "rediss://valkey.example.com"
        ]
      },
      "name" : "valkey",
      "plan" : "startup-4",
      "state" : "running",
      "type" : "valkey",
      "users" : [
        {
          "access-control" : {
            "keys" : [
              "app:*"
            ]
          },
          "username" : "app"
        }
      ]
    }
    """#.utf8)

    static let kafkaACL = Data(#"""
    {
      "schema-registry-acl" : [
        {
          "id" : "acl-2",
          "permission" : "schema_registry_read",
          "resource" : "subject",
          "username" : "app"
        }
      ],
      "topic-acl" : [
        {
          "id" : "acl-1",
          "permission" : "readwrite",
          "topic" : "events",
          "username" : "app"
        }
      ]
    }
    """#.utf8)

    static let openSearchACL = Data(#"""
    {
      "acl-enabled" : true,
      "acls" : [
        {
          "rules" : [
            {
              "index" : "logs-*",
              "permission" : "read"
            }
          ],
          "username" : "app"
        }
      ],
      "extended-acl-enabled" : false
    }
    """#.utf8)
}
