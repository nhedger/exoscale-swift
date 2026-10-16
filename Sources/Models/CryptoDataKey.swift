public extension Exoscale {
    /// KMS data key returned by the crypto API.
    struct CryptoDataKey: Hashable, Sendable {
        public let plaintext: String
        public let ciphertext: String

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            plaintext: String,
            ciphertext: String
        ) {
            self.plaintext = plaintext
            self.ciphertext = ciphertext
        }

        init(data: Payload, client _: Http.Client) {
            plaintext = data.plaintext
            ciphertext = data.ciphertext
        }
    }
}

public extension Exoscale.CryptoDataKey {
    enum KeySpec: Exoscale.ExtensibleEnum {
        case aes256
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.aes256]

        public var rawValue: String {
            switch self {
            case .aes256: "AES-256"
            case let .unknown(value): value
            }
        }
    }
}
