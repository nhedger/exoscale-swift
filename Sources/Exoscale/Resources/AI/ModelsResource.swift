import Foundation

/// Access to AI model API operations.
public struct ModelsResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists AI models.
    ///
    /// - Parameter visibility: Optional visibility filter.
    /// - Returns: The list of AI models returned by the API.
    public func list(visibility: String? = nil) async throws -> [Exoscale.Model] {
        let response = try await http.get(
            path: "/ai/model",
            query: ["visibility": visibility],
            as: ListModelsResponse.self
        )
        return response.models
    }

    /// Creates an AI model.
    ///
    /// - Parameters:
    ///   - name: The model name.
    ///   - huggingfaceToken: Optional Hugging Face access token.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(name: String, huggingfaceToken: String? = nil) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateModelRequest(name: name, huggingfaceToken: huggingfaceToken)
        )

        return try await http.post(
            path: "/ai/model",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Retrieves an AI model by identifier.
    ///
    /// - Parameter id: The model identifier.
    /// - Returns: The AI model returned by the API.
    public func get(id: String) async throws -> Exoscale.Model {
        try await http.get(path: "/ai/model/\(id)", as: Exoscale.Model.self)
    }

    /// Deletes an AI model by identifier.
    ///
    /// - Parameter id: The model identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/ai/model/\(id)", as: Exoscale.Operation.self)
    }
}
