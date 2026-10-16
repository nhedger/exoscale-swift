import Foundation

enum DomainsFixtures {
    static let data = Data(#"""
    {
      "dns-domains" : [
        {
          "created-at" : "2026-04-27T10:00:00Z",
          "id" : "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
          "unicode-name" : "example.com"
        }
      ]
    }
    """#.utf8)

    static let data2 = Data(#"""
    {
      "zone-file" : "$ORIGIN example.com.\n@ 3600 IN SOA ns1.example.com. \#
    hostmaster.example.com. 1 3600 600 604800 3600"
    }
    """#.utf8)
}
