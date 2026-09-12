import Foundation

extension Exoscale {
    public enum ApiError: Swift.Error, Equatable, LocalizedError {
        case unauthorized
        case forbidden
        case forbiddenByPolicy
        /// An unsuccessful HTTP response. The body is retained for API-specific details.
        case httpError(statusCode: Int, body: Data)
        /// The transport returned a response that is not HTTP.
        case invalidResponse
        /// A successful response explicitly advertised a non-JSON content type.
        case unexpectedContentType(String)

        public var errorDescription: String? {
            switch self {
            case .unauthorized:
                "The request is missing valid authorization credentials."
            case .forbidden:
                "The request is forbidden for the provided credentials."
            case .forbiddenByPolicy:
                "The request is forbidden by role policy."
            case let .httpError(statusCode, _):
                "The API returned HTTP \(statusCode) (\(HTTPURLResponse.localizedString(forStatusCode: statusCode)))."
            case .invalidResponse:
                "The API returned a non-HTTP response."
            case let .unexpectedContentType(contentType):
                "Expected a JSON response, received \(contentType)."
            }
        }
    }
}
