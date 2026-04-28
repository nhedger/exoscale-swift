import Foundation

extension Exoscale {
    public enum ApiError: Swift.Error, Equatable, LocalizedError {
        case unauthorized
        case forbidden

        public var errorDescription: String? {
            switch self {
            case .unauthorized:
                "The request is missing valid authorization credentials."
            case .forbidden:
                "The request is forbidden for the provided credentials."
            }
        }
    }
}
