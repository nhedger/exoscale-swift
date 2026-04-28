import Foundation
import Testing

@testable import Exoscale

@Test("CreateDeploymentRequest encodes request body")
func createDeploymentRequestEncodesRequestBody() throws {
    let request = CreateDeploymentRequest(
        gpuCount: 2,
        inferenceEngineVersion: "0.19.0",
        name: "chat-prod",
        gpuType: "gpua5000",
        replicas: 3,
        inferenceEngineParameters: ["--max-model-len", "4096"],
        model: .init(id: "11111111-1111-1111-1111-111111111111")
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
    let model = try #require(object["model"] as? [String: String])

    #expect(object["gpu-count"] as? Int == 2)
    #expect(object["inference-engine-version"] as? String == "0.19.0")
    #expect(object["name"] as? String == "chat-prod")
    #expect(object["gpu-type"] as? String == "gpua5000")
    #expect(object["replicas"] as? Int == 3)
    #expect(object["inference-engine-parameters"] as? [String] == ["--max-model-len", "4096"])
    #expect(model["id"] == "11111111-1111-1111-1111-111111111111")
}

@Test("UpdateDeploymentRequest encodes request body")
func updateDeploymentRequestEncodesRequestBody() throws {
    let request = UpdateDeploymentRequest(
        inferenceEngineVersion: "0.18.1",
        name: "chat-staging",
        inferenceEngineParameters: ["--tensor-parallel-size", "2"]
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["inference-engine-version"] as? String == "0.18.1")
    #expect(object["name"] as? String == "chat-staging")
    #expect(object["inference-engine-parameters"] as? [String] == ["--tensor-parallel-size", "2"])
}

@Test("ScaleDeploymentRequest encodes request body")
func scaleDeploymentRequestEncodesRequestBody() throws {
    let data = try JSONEncoder().encode(ScaleDeploymentRequest(replicas: 5))
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Int])

    #expect(object["replicas"] == 5)
}

@Test("ListDeploymentsResponse decodes deployments")
func listDeploymentsResponseDecodesDeployments() throws {
    let data = Data(
        """
        {
          "deployments": [
            {
              "gpu-count": 2,
              "updated-at": "2026-04-27T10:00:00Z",
              "deployment-url": "https://chat.example.com",
              "service-level": "standard",
              "inference-engine-version": "0.19.0",
              "name": "chat-prod",
              "state": "ready",
              "gpu-type": "gpua5000",
              "id": "22222222-2222-2222-2222-222222222222",
              "replicas": 3,
              "state-details": "healthy",
              "created-at": "2026-04-27T09:00:00Z",
              "inference-engine-parameters": ["--max-model-len", "4096"],
              "model": {
                "id": "11111111-1111-1111-1111-111111111111",
                "name": "openai/gpt-oss-120b"
              }
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListDeploymentsResponse.self, from: data)
    let deployment = try #require(response.deployments.first)

    #expect(deployment.gpuCount == 2)
    #expect(deployment.updatedAt == "2026-04-27T10:00:00Z")
    #expect(deployment.deploymentURL == "https://chat.example.com")
    #expect(deployment.serviceLevel == "standard")
    #expect(deployment.inferenceEngineVersion == "0.19.0")
    #expect(deployment.name == "chat-prod")
    #expect(deployment.state == .ready)
    #expect(deployment.gpuType == "gpua5000")
    #expect(deployment.id == "22222222-2222-2222-2222-222222222222")
    #expect(deployment.replicas == 3)
    #expect(deployment.stateDetails == "healthy")
    #expect(deployment.createdAt == "2026-04-27T09:00:00Z")
    #expect(deployment.inferenceEngineParameters == ["--max-model-len", "4096"])
    #expect(deployment.model?.id == "11111111-1111-1111-1111-111111111111")
    #expect(deployment.model?.name == "openai/gpt-oss-120b")
}

@Test("AI deployment helper responses decode values")
func aiDeploymentHelperResponsesDecodeValues() throws {
    let apiKeyResponse = try JSONDecoder().decode(
        RevealDeploymentAPIKeyResponse.self,
        from: Data(#"{"api-key":"deployment-key"}"#.utf8)
    )
    let logsResponse = try JSONDecoder().decode(
        GetDeploymentLogsResponse.self,
        from: Data(
            #"{"logs":[{"time":"2026-04-27T10:00:00Z","node":"node-1","message":"ready"}]}"#.utf8
        )
    )
    let helpResponse = try JSONDecoder().decode(
        GetInferenceEngineHelpResponse.self,
        from: Data(
            #"{"parameters":[{"description":"Maximum length","allowed-values":["4096"],"default":"2048","name":"max-model-len","section":"engine","type":"integer","flags":["--max-model-len"]}]}"#.utf8
        )
    )
    let instanceTypesResponse = try JSONDecoder().decode(
        ListAIInstanceTypesResponse.self,
        from: Data(#"{"instance-types":[{"family":"gpua5000","authorized":true}]}"#.utf8)
    )

    #expect(apiKeyResponse.apiKey == "deployment-key")
    #expect(logsResponse.logs.first?.time == "2026-04-27T10:00:00Z")
    #expect(logsResponse.logs.first?.node == "node-1")
    #expect(logsResponse.logs.first?.message == "ready")
    #expect(helpResponse.parameters.first?.allowedValues == ["4096"])
    #expect(helpResponse.parameters.first?.defaultValue == "2048")
    #expect(helpResponse.parameters.first?.flags == ["--max-model-len"])
    #expect(instanceTypesResponse.instanceTypes.first?.family == "gpua5000")
    #expect(instanceTypesResponse.instanceTypes.first?.authorized == true)
}

@Test("Client builds AI deployment query and action paths")
func clientBuildsAIDeploymentQueryAndActionPaths() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let listRequest = try client.http.makeRequest(
        "GET",
        path: "/ai/deployment",
        query: ["visibility": "public"]
    )
    let logsRequest = try client.http.makeRequest(
        "GET",
        path: "/ai/deployment/deployment-id/logs",
        query: ["stream": "false", "tail": "100"]
    )
    let scaleRequest = try client.http.makeRequest("POST", path: "/ai/deployment/deployment-id/scale")

    let listURL = try #require(listRequest.url)
    let logsURL = try #require(logsRequest.url)
    let listComponents = try #require(URLComponents(url: listURL, resolvingAgainstBaseURL: false))
    let listQueryItems = Dictionary(uniqueKeysWithValues: try #require(listComponents.queryItems).map { ($0.name, $0.value) })
    let logsComponents = try #require(URLComponents(url: logsURL, resolvingAgainstBaseURL: false))
    let logsQueryItems = Dictionary(uniqueKeysWithValues: try #require(logsComponents.queryItems).map { ($0.name, $0.value) })

    #expect(listRequest.url?.path == "/v2/ai/deployment")
    #expect(listQueryItems["visibility"] == "public")
    #expect(logsRequest.url?.path == "/v2/ai/deployment/deployment-id/logs")
    #expect(logsQueryItems["stream"] == "false")
    #expect(logsQueryItems["tail"] == "100")
    #expect(scaleRequest.url?.path == "/v2/ai/deployment/deployment-id/scale")
}
