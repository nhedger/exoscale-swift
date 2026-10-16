import Foundation

/// Resolves endpoint inputs without performing I/O.
protocol HttpRequest: Sendable {
    func resolve() throws -> Http.Request
}

extension Http {
    enum Method: String, Sendable {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }

    /// Transport inputs produced by an operation-specific request.
    struct Request: Sendable {
        let method: Method
        let path: Path
        /// Query parameters; entries with a `nil` value are omitted from the request.
        var query: [String: String?] = [:]
        var body: Data?
        var headers: [String: String] = [:]
    }
}
