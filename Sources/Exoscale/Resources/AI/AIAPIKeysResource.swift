import Foundation

/// Access to AI API key operations.
public struct AIAPIKeysResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists AI API keys for the current organization.
    ///
    /// - Returns: The AI API keys returned by the API.
    public func list() async throws -> [Exoscale.AIAPIKey] {
        let response = try await http.get(path: "/ai/ai-api-key", as: ListAIAPIKeysResponse.self)
        return response.aiAPIKeys
    }

    /// Creates a new AI API key.
    ///
    /// - Parameters:
    ///   - name: The AI API key name.
    ///   - scope: The AI API key scope.
    /// - Returns: The created AI API key including its plaintext value.
    public func create(name: String, scope: String) async throws -> Exoscale.AIAPIKeyWithValue {
        let body = try JSONEncoder().encode(CreateAIAPIKeyRequest(name: name, scope: scope))

        return try await http.post(
            path: "/ai/ai-api-key",
            body: body,
            as: Exoscale.AIAPIKeyWithValue.self
        )
    }

    /// Retrieves an AI API key by identifier.
    ///
    /// - Parameter id: The AI API key identifier.
    /// - Returns: The AI API key returned by the API.
    public func get(id: String) async throws -> Exoscale.AIAPIKey {
        try await http.get(path: "/ai/ai-api-key/\(id)", as: Exoscale.AIAPIKey.self)
    }

    /// Updates an AI API key.
    ///
    /// - Parameters:
    ///   - id: The AI API key identifier.
    ///   - name: Optional new AI API key name.
    ///   - scope: Optional new AI API key scope.
    /// - Returns: The updated AI API key returned by the API.
    public func update(id: String, name: String? = nil, scope: String? = nil) async throws
        -> Exoscale.AIAPIKey
    {
        let body = try JSONEncoder().encode(UpdateAIAPIKeyRequest(name: name, scope: scope))

        return try await http.patch(
            path: "/ai/ai-api-key/\(id)",
            body: body,
            as: Exoscale.AIAPIKey.self
        )
    }

    /// Deletes an AI API key.
    ///
    /// - Parameter id: The AI API key identifier.
    /// - Returns: `true` when the API confirms the key was deleted.
    public func delete(id: String) async throws -> Bool {
        let response = try await http.delete(
            path: "/ai/ai-api-key/\(id)", as: DeleteAIAPIKeyResponse.self)
        return response.deleted
    }

    /// Rotates an AI API key value.
    ///
    /// - Parameter id: The AI API key identifier.
    /// - Returns: The rotated AI API key including its plaintext value.
    public func rotate(id: String) async throws -> Exoscale.AIAPIKeyWithValue {
        try await http.post(
            path: "/ai/ai-api-key/\(id)/rotate", as: Exoscale.AIAPIKeyWithValue.self)
    }
}
