import Foundation

public enum ExoscaleError: Error, Equatable, LocalizedError {
    case invalidRequestURL
    case unsupportedBodyStream

    public var errorDescription: String? {
        switch self {
        case .invalidRequestURL:
            "The request is missing a valid URL."
        case .unsupportedBodyStream:
            "Exoscale signing requires URLRequest.httpBody data and does not support streamed request bodies."
        }
    }
}
