import Foundation

enum KMSKeysFixtures {
    static let data = Data(#"""
    {
      "kms-keys" : [
        {
          "created-at" : "2026-04-27T09:00:00Z",
          "description" : "Encrypt payment records",
          "id" : "11111111-1111-1111-1111-111111111111",
          "material" : {
            "automatic" : false,
            "created-at" : "2026-04-27T09:00:00Z",
            "version" : 2
          },
          "multi-zone" : true,
          "name" : "payments-key",
          "origin-zone" : "ch-gva-2",
          "replicas" : [
            "de-fra-1"
          ],
          "replicas-status" : [
            {
              "last-applied-watermark" : 42,
              "last-failure" : {
                "attempted-watermark" : 41,
                "error" : "temporary failure",
                "failed-at" : "2026-04-27T08:00:00Z"
              },
              "zone" : "de-fra-1"
            }
          ],
          "revision" : {
            "at" : "2026-04-27T10:00:00Z",
            "seq" : 3
          },
          "rotation" : {
            "automatic" : true,
            "manual-count" : 1,
            "next-at" : "2027-04-27T09:00:00Z",
            "rotation-period" : 365
          },
          "source" : "exoscale-kms",
          "status" : "enabled",
          "status-since" : "2026-04-27T10:00:00Z",
          "usage" : "encrypt-decrypt",
          "zone" : "ch-gva-2"
        }
      ]
    }
    """#.utf8)

    static let rotationResponse = Data(#"""
    {
      "rotation" : {
        "automatic" : true,
        "manual-count" : 2,
        "next-at" : "2026-10-27T09:00:00Z",
        "rotation-period" : 180
      }
    }
    """#.utf8)
}
