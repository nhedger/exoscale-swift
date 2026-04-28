import Foundation

/// Access to AI deployment API operations.
public struct DeploymentsResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists AI deployments.
    ///
    /// - Parameter visibility: Optional visibility filter.
    /// - Returns: The AI deployments returned by the API.
    public func list(visibility: String? = nil) async throws -> [Exoscale.AIDeployment] {
        let response = try await http.get(
            path: "/ai/deployment",
            query: ["visibility": visibility],
            as: ListDeploymentsResponse.self
        )
        return response.deployments
    }

    /// Creates an AI deployment.
    ///
    /// - Parameters:
    ///   - name: The deployment name.
    ///   - modelID: The deployed model identifier.
    ///   - gpuType: The GPU type family.
    ///   - gpuCount: The number of GPUs per replica.
    ///   - replicas: The number of replicas.
    ///   - inferenceEngineVersion: Optional inference engine version.
    ///   - inferenceEngineParameters: Optional extra inference engine CLI arguments.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        name: String,
        modelID: String,
        gpuType: String,
        gpuCount: Int,
        replicas: Int,
        inferenceEngineVersion: String? = nil,
        inferenceEngineParameters: [String]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateDeploymentRequest(
                gpuCount: gpuCount,
                inferenceEngineVersion: inferenceEngineVersion,
                name: name,
                gpuType: gpuType,
                replicas: replicas,
                inferenceEngineParameters: inferenceEngineParameters,
                model: .init(id: modelID)
            )
        )

        return try await http.post(path: "/ai/deployment", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves an AI deployment by identifier.
    ///
    /// - Parameter id: The deployment identifier.
    /// - Returns: The AI deployment returned by the API.
    public func get(id: String) async throws -> Exoscale.AIDeployment {
        try await http.get(path: "/ai/deployment/\(id)", as: Exoscale.AIDeployment.self)
    }

    /// Updates an AI deployment.
    ///
    /// - Parameters:
    ///   - id: The deployment identifier.
    ///   - name: Optional deployment name.
    ///   - inferenceEngineVersion: Optional inference engine version.
    ///   - inferenceEngineParameters: Optional extra inference engine CLI arguments.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        id: String,
        name: String? = nil,
        inferenceEngineVersion: String? = nil,
        inferenceEngineParameters: [String]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateDeploymentRequest(
                inferenceEngineVersion: inferenceEngineVersion,
                name: name,
                inferenceEngineParameters: inferenceEngineParameters
            )
        )

        return try await http.patch(path: "/ai/deployment/\(id)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes an AI deployment.
    ///
    /// - Parameter id: The deployment identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/ai/deployment/\(id)", as: Exoscale.Operation.self)
    }

    /// Reveals an AI deployment inference endpoint API key.
    ///
    /// - Parameter id: The deployment identifier.
    /// - Returns: The API key returned by the API.
    public func revealAPIKey(id: String) async throws -> String {
        let response = try await http.get(
            path: "/ai/deployment/\(id)/api-key",
            as: RevealDeploymentAPIKeyResponse.self
        )
        return response.apiKey
    }

    /// Retrieves AI deployment logs.
    ///
    /// - Parameters:
    ///   - id: The deployment identifier.
    ///   - stream: Optional streaming flag.
    ///   - tail: Optional number of log lines to return.
    /// - Returns: The deployment log entries returned by the API.
    public func logs(
        id: String,
        stream: Bool? = nil,
        tail: Int? = nil
    ) async throws -> [Exoscale.AIDeploymentLogEntry] {
        let response = try await http.get(
            path: "/ai/deployment/\(id)/logs",
            query: [
                "stream": stream.map { $0 ? "true" : "false" },
                "tail": tail.map(String.init),
            ],
            as: GetDeploymentLogsResponse.self
        )
        return response.logs
    }

    /// Scales an AI deployment.
    ///
    /// - Parameters:
    ///   - id: The deployment identifier.
    ///   - replicas: The target replica count.
    /// - Returns: The asynchronous operation returned by the API.
    public func scale(id: String, replicas: Int) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(ScaleDeploymentRequest(replicas: replicas))
        return try await http.post(path: "/ai/deployment/\(id)/scale", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves inference engine parameter definitions.
    ///
    /// - Parameter version: Optional inference engine version filter.
    /// - Returns: The parameter definitions returned by the API.
    public func inferenceEngineParameters(version: String? = nil) async throws -> [Exoscale.InferenceEngineParameter] {
        let response = try await http.get(
            path: "/ai/help/inference-engine-parameters",
            query: ["version": version],
            as: GetInferenceEngineHelpResponse.self
        )
        return response.parameters
    }

    /// Lists available AI instance types.
    ///
    /// - Returns: The AI instance types returned by the API.
    public func listInstanceTypes() async throws -> [Exoscale.AIInstanceType] {
        let response = try await http.get(path: "/ai/instance-type", as: ListAIInstanceTypesResponse.self)
        return response.instanceTypes
    }
}
