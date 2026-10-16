import Foundation

enum SecurityGroupsFixtures {
    static let data = Data(#"""
    {
      "security-groups" : [
        {
          "description" : "Web access",
          "external-sources" : [
            "198.51.100.0/24"
          ],
          "id" : "11111111-1111-1111-1111-111111111111",
          "name" : "web-sg",
          "rules" : [
            {
              "description" : "HTTPS ingress",
              "end-port" : 443,
              "flow-direction" : "ingress",
              "icmp" : {
                "code" : -1,
                "type" : -1
              },
              "id" : "22222222-2222-2222-2222-222222222222",
              "network" : "203.0.113.0/24",
              "protocol" : "tcp",
              "security-group" : {
                "id" : "33333333-3333-3333-3333-333333333333",
                "name" : "public-lb",
                "visibility" : "public"
              },
              "start-port" : 443
            }
          ]
        }
      ]
    }
    """#.utf8)
}
