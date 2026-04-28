/// Access to audit API operations.
public final class AuditResource: Sendable {
    let http: Http.Client

    /// Access to event API operations.
    public let events: EventsResource

    init(http: Http.Client) {
        self.http = http
        self.events = EventsResource(http: http)
    }
}
