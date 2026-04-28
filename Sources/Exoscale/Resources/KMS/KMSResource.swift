/// Access to KMS API operations.
public final class KMSResource {
    let http: Http.Client

    /// Access to KMS crypto API operations.
    public lazy var crypto = CryptoResource(http: http)

    /// Access to KMS key API operations.
    public lazy var keys = KMSKeysResource(http: http)

    init(http: Http.Client) {
        self.http = http
    }
}
