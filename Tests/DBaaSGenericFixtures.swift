import Foundation

enum DBaaSGenericFixtures {
    static let services = Data(#"""
    {
      "dbaas-services" : [
        {
          "name" : "pg",
          "plan" : "startup-4",
          "state" : "running",
          "termination-protection" : true,
          "type" : "pg"
        }
      ]
    }
    """#.utf8)

    static let serviceTypes = Data(#"""
    {
      "dbaas-service-types" : [
        {
          "available-versions" : [
            "16"
          ],
          "default-version" : "16",
          "name" : "pg",
          "plans" : [
            {
              "name" : "startup-4",
              "node-count" : 2,
              "zones" : [
                "ch-gva-2"
              ]
            }
          ]
        }
      ]
    }
    """#.utf8)

    static let logs = Data(#"""
    {
      "first-log-offset" : "1",
      "logs" : [
        {
          "message" : "ready",
          "node" : "pg-1",
          "time" : "2026-04-27T10:00:00Z",
          "unit" : "pg"
        }
      ],
      "offset" : "2"
    }
    """#.utf8)

    static let endpoints = Data(#"""
    {
      "dbaas-endpoints" : [
        {
          "id" : "11111111-1111-1111-1111-111111111111",
          "name" : "logs",
          "type" : "opensearch"
        }
      ]
    }
    """#.utf8)

    static let externalIntegrations = Data(#"""
    {
      "external-integrations" : [
        {
          "description" : "metrics",
          "dest-endpoint-id" : "11111111-1111-1111-1111-111111111111",
          "dest-endpoint-name" : "dd",
          "integration-id" : "22222222-2222-2222-2222-222222222222",
          "source-service-name" : "pg",
          "source-service-type" : "pg",
          "status" : "active",
          "type" : "datadog"
        }
      ]
    }
    """#.utf8)

    static let integrationTypes = Data(#"""
    {
      "dbaas-integration-types" : [
        {
          "dest-service-types" : [
            "grafana"
          ],
          "settings" : {
            "type" : "object"
          },
          "source-service-types" : [
            "pg"
          ],
          "type" : "metrics"
        }
      ]
    }
    """#.utf8)
}
