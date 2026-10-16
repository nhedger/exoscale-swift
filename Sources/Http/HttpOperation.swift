/// Pairs an endpoint's request with its response transformation.
///
/// This describes an API call, whereas `Exoscale.Operation` is an asynchronous
/// job returned by the API.
protocol HttpOperation: Sendable {
    associatedtype Request: HttpRequest
    associatedtype Response: HttpResponse

    var request: Request { get }
    func createResponse(_ data: Response.Payload) -> Response
}

extension HttpOperation {
    func createResponse(_ data: Response.Payload) -> Response {
        Response(data: data)
    }
}
