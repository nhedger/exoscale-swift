/// Access to event API operations.
public struct EventsResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists infrastructure mutation events.
    ///
    /// - Parameters:
    ///   - from: Optional start of the date-time range.
    ///   - to: Optional end of the date-time range.
    /// - Returns: The events returned by the API.
    public func list(from: String? = nil, to: String? = nil) async throws -> [Exoscale.Event] {
        var query: [String: String?] = [:]

        if let from {
            query["from"] = from
        }

        if let to {
            query["to"] = to
        }

        return try await http.get(path: "/event", query: query, as: [Exoscale.Event].self)
    }
}
