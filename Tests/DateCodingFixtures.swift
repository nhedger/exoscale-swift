import Foundation

enum DateCodingFixtures {
    static let data = Data(#"""
    {
      "backups" : [
        {
          "backup-time" : "2026-09-19T12:00:00Z"
        }
      ],
      "maintenance" : {
        "dow" : "monday",
        "time" : "12:00:00",
        "updates" : [
          {
            "deadline" : "2026-09-19T12:00:00Z",
            "start-after" : "2026-09-19T12:00:00.125Z",
            "start-at" : null
          }
        ]
      },
      "users" : [
        {
          "access-cert-expiry" : "2026-09-19T12:00:00Z"
        }
      ]
    }
    """#.utf8)
}
