@testable import Exoscale
import Foundation
import Testing

@Test("AI calls send the expected requests", arguments: [
    Call("instance types", "GET /ai/instance-type", response: "{}") { _ = try await $0.ai.instanceTypes() },
    Call("engine parameters", "GET /ai/help/inference-engine-parameters", query: ["version": "0.31.0"],
         response: "{}") {
        _ = try await $0.ai.inferenceEngineParameters(version: "0.31.0")
    },
    Call("quota", "GET /ai/quota", response: "{}") { _ = try await $0.ai.quotaPerMinute() },
    Call("list models", "GET /ai/model", query: ["visibility": "private"], response: "{}") {
        _ = try await $0.ai.models.list(visibility: .private)
    },
    Call("get model", "GET /ai/model/m-1", response: #"{"id":"m-1"}"#) { _ = try await $0.ai.models.get(id: "m-1") },
    Call("create model", "POST /ai/model", body: #"{"huggingface-token":"hf","name":"org/model"}"#) {
        _ = try await $0.ai.models.create(name: "org/model", huggingFaceToken: "hf")
    },
    Call("delete model", "DELETE /ai/model/m-1") { _ = try await $0.ai.models.delete(id: "m-1") },
    Call("list deployments", "GET /ai/deployment", response: "{}") { _ = try await $0.ai.deployments.list() },
    Call("get deployment", "GET /ai/deployment/d-1", response: #"{"id":"d-1"}"#) {
        _ = try await $0.ai.deployments.get(id: "d-1")
    },
    Call(
        "create deployment",
        "POST /ai/deployment",
        body: #"{"gpu-count":1,"gpu-type":"gpua5000","inference-engine-parameters":["--max-model-len=8192"],"#
            + #""model":{"name":"org/model"},"name":"chat","replicas":2}"#
    ) {
        _ = try await $0.ai.deployments.create(
            name: "chat",
            model: .init(name: "org/model"),
            gpuType: "gpua5000",
            gpuCount: 1,
            replicas: 2,
            inferenceEngineParameters: ["--max-model-len=8192"]
        )
    },
    Call("update deployment", "PATCH /ai/deployment/d-1", body: #"{"inference-engine-version":"0.31.0"}"#) {
        _ = try await $0.ai.deployments.update(id: "d-1", inferenceEngineVersion: "0.31.0")
    },
    Call("scale deployment", "POST /ai/deployment/d-1/scale", body: #"{"replicas":0}"#) {
        _ = try await $0.ai.deployments.scale(id: "d-1", replicas: 0)
    },
    Call("delete deployment", "DELETE /ai/deployment/d-1") { _ = try await $0.ai.deployments.delete(id: "d-1") },
    Call("deployment logs", "GET /ai/deployment/d-1/logs", query: ["tail": "100"], response: "{}") {
        _ = try await $0.ai.deployments.logs(id: "d-1", tail: 100)
    },
    Call("list API keys", "GET /ai/api-key", response: "{}") { _ = try await $0.ai.apiKeys.list() },
    Call("get API key", "GET /ai/api-key/k-1", response: #"{"id":"k-1"}"#) {
        _ = try await $0.ai.apiKeys.get(id: "k-1")
    },
    Call(
        "create API key",
        "POST /ai/api-key",
        body: #"{"deployments":[{"id":"d-1"}],"models":["org/model"],"name":"app"}"#,
        response: #"{"id":"k-1","value":"secret"}"#
    ) {
        _ = try await $0.ai.apiKeys.create(name: "app", models: ["org/model"], deploymentIDs: ["d-1"])
    },
    Call(
        "update API key",
        "PUT /ai/api-key/k-1",
        body: #"{"all-deployments":true,"all-models":false}"#,
        response: #"{"id":"k-1"}"#
    ) {
        _ = try await $0.ai.apiKeys.update(id: "k-1", allModels: false, allDeployments: true)
    },
    Call("revoke API key", "POST /ai/api-key/k-1/revoke") { _ = try await $0.ai.apiKeys.revoke(id: "k-1") }
])
func aiCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("AI models, deployments and API keys decode")
func decodeAI() async throws {
    let models = try await decode(
        #"{"models":[{"id":"m-1","name":"org/model","state":"downloading","visibility":"public","#
            + #""lifecycle-status":"eol","model-size":1024}]}"#,
        from: "/ai/model"
    ) { try await $0.ai.models.list() }
    #expect(models == [.init(
        id: "m-1",
        name: "org/model",
        state: .downloading,
        visibility: .public,
        lifecycleStatus: .endOfLife,
        modelSize: 1024
    )])

    let deployment = try await decode(
        #"{"id":"d-1","name":"chat","state":"scaling","model":{"id":"m-1"},"#
            + #""deployment-url":"https://d-1.example.com","gpu-count":2,"replicas":1}"#,
        from: "/ai/deployment/d-1"
    ) { try await $0.ai.deployments.get(id: "d-1") }
    #expect(deployment == .init(
        id: "d-1",
        name: "chat",
        state: .scaling,
        model: .init(id: "m-1"),
        deploymentURL: "https://d-1.example.com",
        gpuCount: 2,
        replicas: 1
    ))

    let key = try await decode(
        #"{"id":"k-1","name":"app","all-models":true,"models":[],"all-deployments":false,"#
            + #""deployments":[{"id":"d-1"}],"revoked-at":null}"#,
        from: "/ai/api-key/k-1"
    ) { try await $0.ai.apiKeys.get(id: "k-1") }
    #expect(key == .init(
        id: "k-1",
        name: "app",
        allModels: true,
        models: [],
        allDeployments: false,
        deployments: [.init(id: "d-1")]
    ))

    let types = try await decode(
        #"{"instance-types":[{"family":"gpua5000","authorized":true}]}"#,
        from: "/ai/instance-type"
    ) { try await $0.ai.instanceTypes() }
    #expect(types == [.init(family: "gpua5000", isAuthorized: true)])

    let quota = try await decode(#"{"quota-uom-per-minute":null}"#, from: "/ai/quota") {
        try await $0.ai.quotaPerMinute()
    }
    #expect(quota == nil)
}

@Test("New AI API keys keep their value out of descriptions")
func redactedAIAPIKey() {
    let key = Exoscale.CreatedAIAPIKey(id: "k-1", value: "top-secret", name: "app")
    var dumped = ""
    dump(key, to: &dumped)
    #expect(!"\(key)".contains("top-secret"))
    #expect(!dumped.contains("top-secret"))
}
