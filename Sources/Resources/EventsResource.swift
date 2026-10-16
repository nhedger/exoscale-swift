/// Access to event API operations.
public struct EventsResource: Sendable {
    let http: Http.Client

    /// Lists infrastructure mutation events.
    ///
    /// - Parameters:
    ///   - from: Optional start of the date-time range.
    ///   - to: Optional end of the date-time range.
    /// - Returns: The events returned by the API.
    public func list(from: String? = nil, to: String? = nil) async throws -> [Exoscale.Event] {
        try await http.execute(EventsOperations.List(request: .init(from: from, to: to)))
    }
}
