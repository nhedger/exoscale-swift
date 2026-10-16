import Foundation

enum LoadBalancersFixtures {
    static let data = Data(#"""
    {
      "load-balancers" : [
        {
          "created-at" : "2026-04-27T10:00:00Z",
          "description" : "Public web traffic",
          "id" : "22222222-2222-2222-2222-222222222222",
          "ip" : "203.0.113.20",
          "labels" : {
            "env" : "prod"
          },
          "name" : "public-web",
          "services" : [
            {
              "description" : "HTTPS traffic",
              "healthcheck" : {
                "interval" : 10,
                "mode" : "https",
                "port" : 8443,
                "retries" : 3,
                "timeout" : 2,
                "tls-sni" : "example.com",
                "uri" : "/health"
              },
              "healthcheck-status" : [
                {
                  "public-ip" : "198.51.100.10",
                  "status" : "success"
                }
              ],
              "id" : "33333333-3333-3333-3333-333333333333",
              "instance-pool" : {
                "id" : "44444444-4444-4444-4444-444444444444"
              },
              "name" : "https",
              "port" : 443,
              "protocol" : "tcp",
              "state" : "running",
              "strategy" : "source-hash",
              "target-port" : 8443
            }
          ],
          "state" : "running"
        }
      ]
    }
    """#.utf8)
}
