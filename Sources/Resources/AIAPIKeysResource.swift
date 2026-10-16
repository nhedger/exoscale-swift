import Foundation

/// Access to AI API key operations.
public struct AIAPIKeysResource: Sendable {
    let http: Http.Client

    /// Lists AI API keys for the current organization.
    ///
    /// - Returns: The AI API keys returned by the API.
    public func list() async throws -> [Exoscale.AIAPIKey] {
        try await http.execute(AIAPIKeysOperations.List(request: .init()))
    }

    /// Creates a new AI API key.
    ///
    /// - Parameters:
    ///   - name: The AI API key name.
    ///   - scope: The AI API key scope.
    /// - Returns: The created AI API key including its plaintext value.
    public func create(name: String, scope: String) async throws -> Exoscale.AIAPIKeyWithValue {
        try await http.execute(AIAPIKeysOperations.Create(request: .init(name: name, scope: scope)))
    }

    /// Retrieves an AI API key by identifier.
    ///
    /// - Parameter id: The AI API key identifier.
    /// - Returns: The AI API key returned by the API.
    public func get(id: String) async throws -> Exoscale.AIAPIKey {
        try await http.execute(AIAPIKeysOperations.Get(request: .init(id: id)))
    }

    /// Updates an AI API key.
    ///
    /// - Parameters:
    ///   - id: The AI API key identifier.
    ///   - name: Optional new AI API key name.
    ///   - scope: Optional new AI API key scope.
    /// - Returns: The updated AI API key returned by the API.
    public func update(id: String, name: String? = nil, scope: String? = nil) async throws
        -> Exoscale.AIAPIKey {
        try await http.execute(AIAPIKeysOperations.Update(request: .init(id: id, name: name, scope: scope)))
    }

    /// Deletes an AI API key.
    ///
    /// - Parameter id: The AI API key identifier.
    /// - Returns: `true` when the API confirms the key was deleted.
    public func delete(id: String) async throws -> Bool {
        try await http.execute(AIAPIKeysOperations.Delete(request: .init(id: id)))
    }

    /// Rotates an AI API key value.
    ///
    /// - Parameter id: The AI API key identifier.
    /// - Returns: The rotated plaintext key value.
    public func rotate(id: String) async throws -> String {
        try await http.execute(AIAPIKeysOperations.Rotate(request: .init(id: id)))
    }

    /// Reveals an AI API key's plaintext value.
    public func reveal(id: String) async throws -> String {
        try await http.execute(AIAPIKeysOperations.Reveal(request: .init(id: id)))
    }
}
