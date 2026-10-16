import Foundation

enum InstancePoolsFixtures {
    static let data = Data(#"""
    {
      "instance-pools" : [
        {
          "anti-affinity-groups" : [
            {
              "id" : "22222222-2222-2222-2222-222222222222"
            }
          ],
          "application-consistent-snapshot-enabled" : true,
          "deploy-target" : {
            "id" : "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
          },
          "description" : "web workers",
          "disk-size" : 50,
          "elastic-ips" : [
            {
              "id" : "44444444-4444-4444-4444-444444444444"
            }
          ],
          "id" : "11111111-1111-1111-1111-111111111111",
          "instance-prefix" : "web",
          "instance-type" : {
            "id" : "55555555-5555-5555-5555-555555555555"
          },
          "instances" : [
            {
              "id" : "99999999-9999-9999-9999-999999999999"
            }
          ],
          "ipv6-enabled" : true,
          "labels" : {
            "env" : "prod"
          },
          "manager" : {
            "id" : "88888888-8888-8888-8888-888888888888",
            "type" : "instance-pool"
          },
          "min-available" : 2,
          "name" : "web-pool",
          "private-networks" : [
            {
              "id" : "66666666-6666-6666-6666-666666666666"
            }
          ],
          "public-ip-assignment" : "dual",
          "security-groups" : [
            {
              "id" : "33333333-3333-3333-3333-333333333333"
            }
          ],
          "size" : 3,
          "ssh-key" : {
            "name" : "legacy-key"
          },
          "ssh-keys" : [
            {
              "name" : "main-key"
            }
          ],
          "state" : "running",
          "template" : {
            "id" : "77777777-7777-7777-7777-777777777777"
          },
          "user-data" : "dXNlci1kYXRh"
        }
      ]
    }
    """#.utf8)
}
