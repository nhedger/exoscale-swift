import Foundation

enum APIUpdateFixtures {
    static let cluster = Data(#"""
    {
      "nodepools" : [
        {
          "nvidia-mig-profiles" : {
            "b300.269gb" : "7g.269gb"
          }
        }
      ],
      "oidc" : {
        "issuer-url" : "https://issuer.example"
      }
    }
    """#.utf8)

    static let snapshot = Data(#"""
    {
      "instance" : {
        "disk-encrypted" : true,
        "id" : "vm",
        "instance-type" : {
          "id" : "type"
        },
        "name" : "test",
        "ssh-key" : {
          "name" : "key"
        },
        "template" : {
          "id" : "template"
        }
      }
    }
    """#.utf8)

    static let deployment = Data(#"""
    {
      "deployment-url" : "https://example.com",
      "model" : {
        "id" : "model"
      },
      "name" : "shared",
      "state" : "ready",
      "visibility" : "public"
    }
    """#.utf8)
}
