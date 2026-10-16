import Foundation

enum DeploymentsFixtures {
    static let data = Data(#"""
    {
      "deployments" : [
        {
          "created-at" : "2026-04-27T09:00:00Z",
          "deployment-url" : "https://chat.example.com",
          "gpu-count" : 2,
          "gpu-type" : "gpua5000",
          "id" : "22222222-2222-2222-2222-222222222222",
          "inference-engine-parameters" : [
            "--max-model-len",
            "4096"
          ],
          "inference-engine-version" : "0.19.0",
          "model" : {
            "id" : "11111111-1111-1111-1111-111111111111",
            "name" : "openai/gpt-oss-120b"
          },
          "name" : "chat-prod",
          "replicas" : 3,
          "service-level" : "standard",
          "state" : "ready",
          "state-details" : "healthy",
          "updated-at" : "2026-04-27T10:00:00Z"
        }
      ]
    }
    """#.utf8)

    static let helpResponse = Data(#"""
    {
      "parameters" : [
        {
          "allowed-values" : [
            "4096"
          ],
          "default" : "2048",
          "description" : "Maximum length",
          "flags" : [
            "--max-model-len"
          ],
          "name" : "max-model-len",
          "section" : "engine",
          "type" : "integer"
        }
      ]
    }
    """#.utf8)
}
