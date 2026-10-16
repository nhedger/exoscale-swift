/// Transforms a decoded API payload into an SDK result.
protocol HttpResponse: Sendable {
    associatedtype Payload: Decodable & Sendable
    associatedtype Result: Sendable

    init(data: Payload)
    func transform(client: Http.Client) throws -> Result
}
