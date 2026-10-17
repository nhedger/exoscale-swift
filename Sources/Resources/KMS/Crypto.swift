import Foundation

public extension Exoscale {
    /// Cryptographic operations with the keys of the Key Management Service (KMS).
    ///
    /// ```swift
    /// let ciphertext = try await exoscale.crypto.encrypt(Data("secret".utf8), with: keyID)
    /// let plaintext = try await exoscale.crypto.decrypt(ciphertext, with: keyID)
    /// ```
    struct Crypto: Sendable {
        let client: HTTPClient

        // MARK: Encryption

        /// Encrypts data with a key.
        ///
        /// - Parameters:
        ///   - plaintext: The data to encrypt.
        ///   - keyID: The key's identifier.
        ///   - context: Additional authenticated data, which decrypting must pass again.
        ///   - algorithm: The encryption algorithm. The API picks it from the key by default.
        /// - Returns: The ciphertext.
        public func encrypt(
            _ plaintext: Data,
            with keyID: String,
            context: Data? = nil,
            algorithm: EncryptionAlgorithm? = nil
        ) async throws -> Data {
            try await client.send(.post, "/kms-key/\(keyID)/encrypt", body: [
                "plaintext": plaintext,
                "encryption-context": context,
                "encryption-algorithm": algorithm
            ] as JSONBody, as: Ciphertext.self).ciphertext
        }

        /// Decrypts data encrypted with a key.
        ///
        /// - Parameters:
        ///   - ciphertext: The data to decrypt.
        ///   - keyID: The key's identifier.
        ///   - context: The additional authenticated data passed when encrypting.
        ///   - algorithm: The encryption algorithm. The API picks it from the key by default.
        /// - Returns: The plaintext.
        public func decrypt(
            _ ciphertext: Data,
            with keyID: String,
            context: Data? = nil,
            algorithm: EncryptionAlgorithm? = nil
        ) async throws -> Data {
            try await client.send(.post, "/kms-key/\(keyID)/decrypt", body: [
                "ciphertext": ciphertext,
                "encryption-context": context,
                "encryption-algorithm": algorithm
            ] as JSONBody, as: Plaintext.self).plaintext
        }

        /// Decrypts data with one key and encrypts it again with another, without exposing the
        /// plaintext.
        ///
        /// - Parameters:
        ///   - ciphertext: The data to re-encrypt.
        ///   - sourceKeyID: The key the data is encrypted with.
        ///   - destinationKeyID: The key to encrypt the data with.
        ///   - sourceContext: The additional authenticated data passed when encrypting.
        ///   - destinationContext: Additional authenticated data for the new ciphertext.
        ///   - sourceAlgorithm: The algorithm the data is encrypted with.
        ///   - destinationAlgorithm: The algorithm to encrypt the data with.
        /// - Returns: The new ciphertext.
        public func reEncrypt(
            _ ciphertext: Data,
            from sourceKeyID: String,
            to destinationKeyID: String,
            sourceContext: Data? = nil,
            destinationContext: Data? = nil,
            sourceAlgorithm: EncryptionAlgorithm? = nil,
            destinationAlgorithm: EncryptionAlgorithm? = nil
        ) async throws -> Data {
            try await client.send(.post, "/kms-key/\(sourceKeyID)/re-encrypt", body: [
                "source": [
                    "key": sourceKeyID,
                    "ciphertext": ciphertext,
                    "encryption-context": sourceContext,
                    "encryption-algorithm": sourceAlgorithm
                ] as JSONBody,
                "destination": [
                    "key": destinationKeyID,
                    "encryption-context": destinationContext,
                    "encryption-algorithm": destinationAlgorithm
                ] as JSONBody
            ] as JSONBody, as: Ciphertext.self).ciphertext
        }

        /// Generates a data key for encrypting data locally, returned both in plaintext and encrypted
        /// with a KMS key.
        ///
        /// Use the plaintext key, then discard it and store the encrypted one next to the data;
        /// ``decrypt(_:with:context:algorithm:)`` recovers it.
        ///
        /// - Parameters:
        ///   - keyID: The identifier of the key that encrypts the data key.
        ///   - spec: The data key's specification.
        ///   - byteCount: The data key's length in bytes, instead of a specification.
        ///   - context: Additional authenticated data for the encrypted data key.
        public func generateDataKey(
            with keyID: String,
            spec: DataKey.Spec? = nil,
            byteCount: Int? = nil,
            context: Data? = nil
        ) async throws -> DataKey {
            try await client.send(.post, "/kms-key/\(keyID)/generate-data-key", body: [
                "key-spec": spec,
                "bytes-count": byteCount,
                "encryption-context": context
            ] as JSONBody)
        }

        // MARK: Signatures

        /// Signs a message with an asymmetric key.
        ///
        /// - Parameters:
        ///   - message: The message, or its digest when `messageType` is ``MessageType/digest``.
        ///   - keyID: The key's identifier.
        ///   - algorithm: The signing algorithm.
        ///   - messageType: Whether `message` is the message itself or its digest.
        /// - Returns: The signature.
        public func sign(
            _ message: Data,
            with keyID: String,
            algorithm: SigningAlgorithm,
            messageType: MessageType? = nil
        ) async throws -> Data {
            try await client.send(.post, "/kms-key/\(keyID)/sign", body: [
                "message": message,
                "signing-algorithm": algorithm,
                "message-type": messageType
            ] as JSONBody, as: Signature.self).signature
        }

        /// Checks a message's signature with an asymmetric key.
        ///
        /// - Parameters:
        ///   - signature: The signature.
        ///   - message: The message, or its digest when `messageType` is ``MessageType/digest``.
        ///   - keyID: The key's identifier.
        ///   - algorithm: The signing algorithm.
        ///   - messageType: Whether `message` is the message itself or its digest.
        /// - Returns: Whether the signature is valid.
        public func verify(
            _ signature: Data,
            of message: Data,
            with keyID: String,
            algorithm: SigningAlgorithm,
            messageType: MessageType? = nil
        ) async throws -> Bool {
            try await client.send(.post, "/kms-key/\(keyID)/verify", body: [
                "signature": signature,
                "message": message,
                "signing-algorithm": algorithm,
                "message-type": messageType
            ] as JSONBody, as: Verification.self).signatureValid
        }

        /// Retrieves the public half of an asymmetric key.
        public func publicKey(of keyID: String) async throws -> PublicKey {
            try await client.send(.get, "/kms-key/\(keyID)/get-public-key")
        }
    }
}

public extension Exoscale.Crypto {
    /// An algorithm for encrypting data.
    struct EncryptionAlgorithm: RawRepresentable, Hashable, Codable, Sendable {
        /// The algorithm as the API names it.
        public let rawValue: String

        /// Creates an algorithm, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// 256-bit AES, for symmetric keys.
        public static let aes256 = EncryptionAlgorithm(rawValue: "AES_256")
        /// RSA with OAEP padding and SHA-256, for RSA keys.
        public static let rsaesOAEPSHA256 = EncryptionAlgorithm(rawValue: "RSAES_OAEP_SHA_256")
    }

    /// An algorithm for signing messages.
    struct SigningAlgorithm: RawRepresentable, Hashable, Codable, Sendable {
        /// The algorithm as the API names it.
        public let rawValue: String

        /// Creates an algorithm, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// RSA-PSS with SHA-256.
        public static let rsassaPSSSHA256 = SigningAlgorithm(rawValue: "RSASSA_PSS_SHA_256")
        /// RSA-PSS with SHA-384.
        public static let rsassaPSSSHA384 = SigningAlgorithm(rawValue: "RSASSA_PSS_SHA_384")
        /// RSA-PSS with SHA-512.
        public static let rsassaPSSSHA512 = SigningAlgorithm(rawValue: "RSASSA_PSS_SHA_512")
        /// ECDSA with SHA-256.
        public static let ecdsaSHA256 = SigningAlgorithm(rawValue: "ECDSA_SHA_256")
        /// ECDSA with SHA-384.
        public static let ecdsaSHA384 = SigningAlgorithm(rawValue: "ECDSA_SHA_384")
        /// ECDSA with SHA-512.
        public static let ecdsaSHA512 = SigningAlgorithm(rawValue: "ECDSA_SHA_512")
        /// Ed25519.
        public static let eddsaEd25519 = SigningAlgorithm(rawValue: "EDDSA_ED25519")
        /// Ed25519ph, which signs a SHA-512 digest.
        public static let ed25519phSHA512 = SigningAlgorithm(rawValue: "ED25519_PH_SHA_512")
        /// ML-DSA with SHAKE256.
        public static let mlDSASHAKE256 = SigningAlgorithm(rawValue: "ML_DSA_SHAKE_256")
    }

    /// Whether a message passed for signing is the message itself or its digest.
    struct MessageType: RawRepresentable, Hashable, Codable, Sendable {
        /// The type as the API names it.
        public let rawValue: String

        /// Creates a type, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The message itself.
        public static let raw = MessageType(rawValue: "raw")
        /// A digest of the message.
        public static let digest = MessageType(rawValue: "digest")
    }

    /// A data key, in plaintext and encrypted with a KMS key.
    struct DataKey: Hashable, Codable, Sendable {
        /// The key, to use and then discard.
        public let plaintext: Data
        /// The key encrypted with the KMS key, to store next to the data.
        public let ciphertext: Data

        /// Creates a data key, for example for previews and tests.
        public init(plaintext: Data, ciphertext: Data) {
            self.plaintext = plaintext
            self.ciphertext = ciphertext
        }

        /// The specification of a data key.
        public struct Spec: RawRepresentable, Hashable, Codable, Sendable {
            /// The specification as the API names it.
            public let rawValue: String

            /// Creates a specification, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// A 256-bit AES key.
            public static let aes256 = Spec(rawValue: "AES-256")
        }
    }

    /// The public half of an asymmetric key.
    struct PublicKey: Hashable, Codable, Sendable {
        /// The key's identifier.
        public let keyID: String?
        /// The key's specification.
        public let keySpec: Exoscale.KMSKey.KeySpec?
        /// What the key is used for.
        public let usage: Exoscale.KMSKey.Usage?
        /// The public key, DER-encoded.
        public let publicKey: Data?

        /// Creates a public key, for example for previews and tests.
        public init(
            keyID: String? = nil,
            keySpec: Exoscale.KMSKey.KeySpec? = nil,
            usage: Exoscale.KMSKey.Usage? = nil,
            publicKey: Data? = nil
        ) {
            self.keyID = keyID
            self.keySpec = keySpec
            self.usage = usage
            self.publicKey = publicKey
        }

        enum CodingKeys: String, CodingKey {
            case usage
            case keyID = "key-id"
            case keySpec = "key-spec"
            case publicKey = "public-key"
        }
    }
}

extension Exoscale.Crypto.DataKey: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
    /// Describes the data key without its plaintext, so it is safe to log.
    public var description: String {
        "DataKey(plaintext: <redacted>, ciphertext: \(ciphertext))"
    }

    /// The same as ``description``.
    public var debugDescription: String {
        description
    }

    /// Keeps the plaintext out of `dump` output and debugger summaries.
    public var customMirror: Mirror {
        Mirror(self, children: ["plaintext": "<redacted>", "ciphertext": ciphertext])
    }
}

private struct Ciphertext: Decodable {
    let ciphertext: Data
}

private struct Plaintext: Decodable {
    let plaintext: Data
}

private struct Signature: Decodable {
    let signature: Data
}

private struct Verification: Decodable {
    let signatureValid: Bool

    enum CodingKeys: String, CodingKey {
        case signatureValid = "signature-valid"
    }
}
