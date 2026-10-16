import Foundation

enum ClustersFixtures {
    static let data = Data(#"""
    {
      "sks-clusters" : [
        {
          "addons" : [
            "metrics-server",
            "karpenter"
          ],
          "audit" : {
            "enabled" : true,
            "endpoint" : "https://audit.example.com",
            "initial-backoff" : "10s"
          },
          "auto-upgrade" : true,
          "cni" : "cilium",
          "created-at" : "2026-04-27T10:00:00Z",
          "default-security-group-id" : "11111111-1111-1111-1111-111111111111",
          "description" : "production cluster",
          "enable-kube-proxy" : false,
          "enable-operators-ca" : true,
          "endpoint" : "https://api.prod-sks.example.com",
          "feature-gates" : [
            "ExampleFeature"
          ],
          "id" : "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
          "labels" : {
            "env" : "prod"
          },
          "level" : "pro",
          "name" : "prod-sks",
          "nodepools" : [
            {
              "addons" : [
                "storage-lvm"
              ],
              "anti-affinity-groups" : [
                {
                  "id" : "22222222-2222-2222-2222-222222222222"
                }
              ],
              "created-at" : "2026-04-27T10:00:00Z",
              "deploy-target" : {
                "id" : "88888888-8888-8888-8888-888888888888"
              },
              "description" : "workers",
              "disk-size" : 50,
              "id" : "99999999-9999-9999-9999-999999999999",
              "instance-pool" : {
                "id" : "77777777-7777-7777-7777-777777777777"
              },
              "instance-prefix" : "worker",
              "instance-type" : {
                "id" : "44444444-4444-4444-4444-444444444444"
              },
              "kubelet-image-gc" : {
                "high-threshold" : 85,
                "low-threshold" : 80,
                "min-age" : "2m"
              },
              "labels" : {
                "pool" : "workers"
              },
              "name" : "workers",
              "private-networks" : [
                {
                  "id" : "55555555-5555-5555-5555-555555555555"
                }
              ],
              "public-ip-assignment" : "dual",
              "security-groups" : [
                {
                  "id" : "33333333-3333-3333-3333-333333333333"
                }
              ],
              "size" : 3,
              "state" : "running",
              "taints" : {
                "dedicated" : {
                  "effect" : "NoSchedule",
                  "value" : "gpu"
                }
              },
              "template" : {
                "id" : "66666666-6666-6666-6666-666666666666"
              },
              "version" : "1.31.1"
            }
          ],
          "state" : "running",
          "version" : "1.31.1"
        }
      ]
    }
    """#.utf8)

    static let deprecatedResources = Data(#"""
    [
      {
        "group" : "apps",
        "removed-release" : "1.16",
        "resource" : "deployments",
        "subresource" : "scale",
        "version" : "v1beta1"
      }
    ]
    """#.utf8)

    static let data2 = Data(#"""
    {
      "checks" : {
        "dns" : {
          "ok" : true,
          "retries" : 2
        }
      },
      "empty" : null,
      "messages" : [
        "ok"
      ],
      "score" : 0.5
    }
    """#.utf8)
}
