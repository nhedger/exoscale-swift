import Foundation

public extension Exoscale {
    /// Dedicated inference: models, the deployments serving them, and API keys to call them.
    struct AI: Sendable {
        let client: HTTPClient

        /// Models that deployments can serve.
        public var models: AIModels {
            AIModels(client: client)
        }

        /// Deployments serving models on GPUs.
        public var deployments: AIDeployments {
            AIDeployments(client: client)
        }

        /// API keys for sending inference requests (beta).
        public var apiKeys: AIAPIKeys {
            AIAPIKeys(client: client)
        }

        /// Lists the GPU families deployments can run on.
        public func instanceTypes() async throws -> [AIInstanceType] {
            try await client.send(.get, "/ai/instance-type", unwrapping: "instance-types")
        }

        /// Lists the parameters the inference engine accepts.
        ///
        /// - Parameter version: The inference engine's version. The API uses the latest by default.
        public func inferenceEngineParameters(version: String? = nil) async throws -> [InferenceEngineParameter] {
            try await client.send(
                .get,
                "/ai/help/inference-engine-parameters",
                query: ["version": version],
                unwrapping: "parameters"
            )
        }

        /// Retrieves the organization's inference quota (beta).
        ///
        /// - Returns: The quota per minute, or `nil` when there is none.
        public func quotaPerMinute() async throws -> Int? {
            try await client.send(.get, "/ai/quota", as: InferenceQuota.self).perMinute
        }
    }

    /// Models that dedicated inference deployments can serve.
    struct AIModels: Sendable {
        let client: HTTPClient

        /// Lists the models.
        ///
        /// - Parameter visibility: Only the organization's own models, or only public ones.
        public func list(visibility: AIModel.Visibility? = nil) async throws -> [AIModel] {
            try await client.send(.get, "/ai/model", query: ["visibility": visibility?.rawValue], unwrapping: "models")
        }

        /// Retrieves a model.
        public func get(id: String) async throws -> AIModel {
            try await client.send(.get, "/ai/model/\(id)")
        }

        /// Adds a model from Hugging Face.
        ///
        /// - Parameters:
        ///   - name: The model's Hugging Face repository, such as `mistralai/Mistral-7B-Instruct-v0.3`.
        ///   - huggingFaceToken: A Hugging Face access token, for gated or private models.
        public func create(name: String, huggingFaceToken: String? = nil) async throws -> Operation {
            try await client.send(.post, "/ai/model", body: [
                "name": name,
                "huggingface-token": huggingFaceToken
            ] as JSONBody)
        }

        /// Deletes a model. Models that deployments still serve can't be deleted.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/ai/model/\(id)")
        }
    }

    /// Dedicated inference deployments, serving models on GPUs.
    struct AIDeployments: Sendable {
        let client: HTTPClient

        /// Lists the deployments.
        public func list() async throws -> [AIDeployment] {
            try await client.send(.get, "/ai/deployment", unwrapping: "deployments")
        }

        /// Retrieves a deployment.
        public func get(id: String) async throws -> AIDeployment {
            try await client.send(.get, "/ai/deployment/\(id)")
        }

        /// Creates a deployment.
        ///
        /// - Parameters:
        ///   - name: The deployment's name.
        ///   - model: The model to serve, by identifier or name.
        ///   - gpuType: The GPU family, from ``AI/instanceTypes()``.
        ///   - gpuCount: The number of GPUs per replica.
        ///   - replicas: The number of replicas.
        ///   - productName: The product to bill the deployment as, such as `my-product`: up to 256
        ///     lowercase letters and digits, in words joined by single hyphens.
        ///   - inferenceEngineVersion: The inference engine's version.
        ///   - inferenceEngineParameters: Extra command-line parameters for the inference engine.
        public func create(
            name: String,
            model: Reference<AIModel>,
            gpuType: String,
            gpuCount: Int,
            replicas: Int,
            productName: String? = nil,
            inferenceEngineVersion: String? = nil,
            inferenceEngineParameters: [String]? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/ai/deployment", body: [
                "name": name,
                "model": model,
                "gpu-type": gpuType,
                "gpu-count": gpuCount,
                "replicas": replicas,
                "product-name": productName,
                "inference-engine-version": inferenceEngineVersion,
                "inference-engine-parameters": inferenceEngineParameters
            ] as JSONBody)
        }

        /// Updates a deployment. Only the values passed are changed.
        public func update(
            id: String,
            name: String? = nil,
            inferenceEngineVersion: String? = nil,
            inferenceEngineParameters: [String]? = nil
        ) async throws -> Operation {
            try await client.send(.patch, "/ai/deployment/\(id)", body: [
                "name": name,
                "inference-engine-version": inferenceEngineVersion,
                "inference-engine-parameters": inferenceEngineParameters
            ] as JSONBody)
        }

        /// Changes the number of replicas of a deployment.
        public func scale(id: String, replicas: Int) async throws -> Operation {
            try await client.send(.post, "/ai/deployment/\(id)/scale", body: ["replicas": replicas] as JSONBody)
        }

        /// Deletes a deployment.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/ai/deployment/\(id)")
        }

        /// Retrieves the latest log lines of a deployment.
        ///
        /// - Parameter tail: The number of lines to return, from the end.
        public func logs(id: String, tail: Int? = nil) async throws -> [AIDeploymentLogEntry] {
            try await client.send(
                .get,
                "/ai/deployment/\(id)/logs",
                query: ["tail": tail.map(String.init)],
                unwrapping: "logs"
            )
        }
    }

    /// API keys for sending inference requests to AI models and deployments (beta).
    struct AIAPIKeys: Sendable {
        let client: HTTPClient

        /// Lists the API keys.
        public func list() async throws -> [AIAPIKey] {
            try await client.send(.get, "/ai/api-key", unwrapping: "ai-api-keys")
        }

        /// Retrieves an API key.
        public func get(id: String) async throws -> AIAPIKey {
            try await client.send(.get, "/ai/api-key/\(id)")
        }

        /// Creates an API key.
        ///
        /// - Parameters:
        ///   - name: The key's name.
        ///   - allModels: Whether the key can reach every model.
        ///   - models: The names of the models the key can reach.
        ///   - allDeployments: Whether the key can reach every deployment.
        ///   - deploymentIDs: The identifiers of the deployments the key can reach.
        /// - Returns: The new key, with its value. The value isn't shown again.
        public func create(
            name: String,
            allModels: Bool? = nil,
            models: [String]? = nil,
            allDeployments: Bool? = nil,
            deploymentIDs: [String]? = nil
        ) async throws -> CreatedAIAPIKey {
            try await client.send(.post, "/ai/api-key", body: [
                "name": name,
                "all-models": allModels,
                "models": models,
                "all-deployments": allDeployments,
                "deployments": deploymentIDs?.map { Reference<AIDeployment>(id: $0) }
            ] as JSONBody)
        }

        /// Changes which models and deployments an API key can reach. Only the values passed are
        /// changed.
        public func update(
            id: String,
            allModels: Bool? = nil,
            models: [String]? = nil,
            allDeployments: Bool? = nil,
            deploymentIDs: [String]? = nil
        ) async throws -> AIAPIKey {
            try await client.send(.put, "/ai/api-key/\(id)", body: [
                "all-models": allModels,
                "models": models,
                "all-deployments": allDeployments,
                "deployments": deploymentIDs?.map { Reference<AIDeployment>(id: $0) }
            ] as JSONBody)
        }

        /// Revokes an API key, so it can't be used anymore.
        public func revoke(id: String) async throws -> Operation {
            try await client.send(.post, "/ai/api-key/\(id)/revoke")
        }
    }
}

private struct InferenceQuota: Decodable {
    let perMinute: Int?

    enum CodingKeys: String, CodingKey {
        case perMinute = "quota-uom-per-minute"
    }
}
