import Foundation

/// Access to AI model API operations.
public struct ModelsResource: Sendable {
    let http: Http.Client

    /// Lists AI models.
    ///
    /// - Returns: The list of AI models returned by the API.
    public func list() async throws -> [Exoscale.Model] {
        try await http.execute(ModelsOperations.List(request: .init()))
    }

    /// Creates an AI model.
    ///
    /// - Parameters:
    ///   - name: The model name.
    ///   - huggingfaceToken: Optional Hugging Face access token.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(name: String, huggingfaceToken: String? = nil) async throws -> Exoscale.Operation {
        try await http.execute(ModelsOperations.Create(request: .init(name: name, huggingfaceToken: huggingfaceToken)))
    }

    /// Retrieves an AI model by identifier.
    ///
    /// - Parameter id: The model identifier.
    /// - Returns: The AI model returned by the API.
    public func get(id: String) async throws -> Exoscale.Model {
        try await http.execute(ModelsOperations.Get(request: .init(id: id)))
    }

    /// Deletes an AI model by identifier.
    ///
    /// - Parameter id: The model identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(ModelsOperations.Delete(request: .init(id: id)))
    }
}
