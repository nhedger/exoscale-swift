import Alamofire
import Foundation

/// Applies the configured User-Agent header when a request does not provide one.
struct ApplyUserAgent: RequestAdapter, Sendable {
    let userAgent: String

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping @Sendable (Result<URLRequest, any Error>) -> Void
    ) {
        completion(Result { try adapt(urlRequest) })
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard !userAgent.isEmpty else {
            return urlRequest
        }

        guard urlRequest.value(forHTTPHeaderField: "User-Agent") == nil else {
            return urlRequest
        }

        var request = urlRequest
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        return request
    }
}
