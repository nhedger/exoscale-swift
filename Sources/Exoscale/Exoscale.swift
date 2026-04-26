import Foundation

public struct ExoscaleCredentials: Sendable {
    public let apiKey: String
    let apiSecret: String

    public init() throws {
        try self.init(environment: ProcessInfo.processInfo.environment)
    }

    public init(apiKey: String, apiSecret: String) throws {
        guard !apiKey.isEmpty else {
            throw ExoscaleError.missingAPIKey
        }

        guard !apiSecret.isEmpty else {
            throw ExoscaleError.missingAPISecret
        }

        self.apiKey = apiKey
        self.apiSecret = apiSecret
    }

    public init(environment: [String: String] = ProcessInfo.processInfo.environment) throws {
        try self.init(
            apiKey: environment["EXOSCALE_API_KEY"] ?? "",
            apiSecret: environment["EXOSCALE_API_SECRET"] ?? ""
        )
    }
}

public enum ExoscaleError: Error, Equatable, LocalizedError {
    case missingAPIKey
    case missingAPISecret
    case invalidRequestURL
    case unsupportedBodyStream

    public var errorDescription: String? {
        switch self {
        case .missingAPIKey:
            "Exoscale API key is required."
        case .missingAPISecret:
            "Exoscale API secret is required."
        case .invalidRequestURL:
            "The request is missing a valid URL."
        case .unsupportedBodyStream:
            "Exoscale signing requires URLRequest.httpBody data and does not support streamed request bodies."
        }
    }
}
