/// Access to KMS API operations.
public final class KMSResource: Sendable {
    let http: Http.Client

    /// Access to KMS crypto API operations.
    public let crypto: CryptoResource

    /// Access to KMS key API operations.
    public let keys: KMSKeysResource

    init(http: Http.Client) {
        self.http = http
        self.crypto = CryptoResource(http: http)
        self.keys = KMSKeysResource(http: http)
    }
}
