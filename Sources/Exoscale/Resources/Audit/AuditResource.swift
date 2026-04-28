/// Access to audit API operations.
public final class AuditResource {
    let http: Http.Client

    /// Access to event API operations.
    public lazy var events = EventsResource(http: http)

    init(http: Http.Client) {
        self.http = http
    }
}
