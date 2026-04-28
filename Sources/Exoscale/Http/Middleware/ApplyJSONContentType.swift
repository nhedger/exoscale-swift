import Alamofire
import Foundation

/// Applies the JSON content type header when a request body is present and no content type is specified.
struct ApplyJSONContentType: RequestAdapter, Sendable {
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping @Sendable (Result<URLRequest, any Error>) -> Void
    ) {
        completion(Result { try adapt(urlRequest) })
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard urlRequest.httpBody != nil || urlRequest.httpBodyStream != nil else {
            return urlRequest
        }

        guard urlRequest.value(forHTTPHeaderField: "Content-Type") == nil else {
            return urlRequest
        }

        var request = urlRequest
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
