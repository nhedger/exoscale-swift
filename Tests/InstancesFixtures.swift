import Foundation

enum InstancesFixtures {
    static let console = Data(#"""
    {
      "host" : "console.example.com",
      "path" : "/session",
      "url" : "wss://console.example.com/session"
    }
    """#.utf8)

    static let data = Data(#"""
    {
      "instances" : [
        {
          "anti-affinity-groups" : [
            {
              "id" : "22222222-2222-2222-2222-222222222222"
            }
          ],
          "application-consistent-snapshot-enabled" : true,
          "created-at" : "2026-04-27T10:00:00Z",
          "deploy-target" : {
            "id" : "77777777-7777-7777-7777-777777777777"
          },
          "disk-size" : 50,
          "id" : "11111111-1111-1111-1111-111111111111",
          "instance-type" : {
            "authorized" : false,
            "cpus" : 2,
            "family" : "standard",
            "gpus" : 0,
            "id" : "33333333-3333-3333-3333-333333333333",
            "memory" : 4096,
            "size" : "medium",
            "zones" : [
              "ch-gva-2"
            ]
          },
          "ipv6-address" : "2001:db8::10",
          "labels" : {
            "env" : "prod"
          },
          "mac-address" : "02:00:00:00:00:10",
          "manager" : {
            "id" : "66666666-6666-6666-6666-666666666666",
            "type" : "instance-pool"
          },
          "name" : "web-1",
          "private-networks" : [
            {
              "id" : "44444444-4444-4444-4444-444444444444",
              "mac-address" : "02:00:00:00:00:20"
            }
          ],
          "public-ip" : "203.0.113.10",
          "public-ip-assignment" : "dual",
          "secureboot-enabled" : true,
          "snapshots" : [
            {
              "id" : "88888888-8888-8888-8888-888888888888"
            }
          ],
          "ssh-key" : {
            "fingerprint" : "aa:bb:cc",
            "name" : "main-key"
          },
          "ssh-keys" : [
            {
              "fingerprint" : "aa:bb:cc",
              "name" : "main-key"
            }
          ],
          "state" : "running",
          "template" : {
            "boot-mode" : "uefi",
            "id" : "55555555-5555-5555-5555-555555555555",
            "name" : "Linux template",
            "visibility" : "public"
          },
          "tpm-enabled" : true,
          "user-data" : "dXNlci1kYXRh"
        }
      ]
    }
    """#.utf8)

    static let data2 = Data(#"""
    {
      "instances" : [
        {
          "id" : "11111111-1111-1111-1111-111111111111",
          "instance-type" : {
            "family" : "future-family",
            "size" : "future-size"
          },
          "name" : "web-1"
        }
      ]
    }
    """#.utf8)
}
