import Foundation

/// Access to KMS crypto API operations.
public struct CryptoResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Encrypts base64-encoded plaintext with a KMS key.
    ///
    /// - Parameters:
    ///   - id: The KMS key identifier.
    ///   - plaintext: The base64-encoded plaintext.
    ///   - encryptionContext: Optional base64-encoded encryption context appended to the AAD.
    /// - Returns: The base64-encoded ciphertext returned by the API.
    public func encrypt(
        id: String,
        plaintext: String,
        encryptionContext: String? = nil
    ) async throws -> String {
        let body = try JSONEncoder().encode(
            EncryptRequest(encryptionContext: encryptionContext, plaintext: plaintext)
        )
        let response = try await http.post(
            path: "/kms-key/\(id)/encrypt",
            body: body,
            as: EncryptResponse.self
        )
        return response.ciphertext
    }

    /// Decrypts base64-encoded ciphertext with a KMS key.
    ///
    /// - Parameters:
    ///   - id: The KMS key identifier.
    ///   - ciphertext: The base64-encoded ciphertext.
    ///   - encryptionContext: Optional base64-encoded encryption context appended to the AAD.
    /// - Returns: The base64-encoded plaintext returned by the API.
    public func decrypt(
        id: String,
        ciphertext: String,
        encryptionContext: String? = nil
    ) async throws -> String {
        let body = try JSONEncoder().encode(
            DecryptRequest(encryptionContext: encryptionContext, ciphertext: ciphertext)
        )
        let response = try await http.post(
            path: "/kms-key/\(id)/decrypt",
            body: body,
            as: DecryptResponse.self
        )
        return response.plaintext
    }

    /// Generates a data encryption key from a KMS key.
    ///
    /// - Parameters:
    ///   - id: The KMS key identifier.
    ///   - keySpec: Optional generated key specification.
    ///   - bytesCount: Optional generated key byte count.
    ///   - encryptionContext: Optional base64-encoded encryption context appended to the AAD.
    /// - Returns: The generated data key returned by the API.
    public func generateDataKey(
        id: String,
        keySpec: Exoscale.CryptoDataKey.KeySpec? = nil,
        bytesCount: Int? = nil,
        encryptionContext: String? = nil
    ) async throws -> Exoscale.CryptoDataKey {
        let body = try JSONEncoder().encode(
            GenerateDataKeyRequest(
                keySpec: keySpec,
                bytesCount: bytesCount,
                encryptionContext: encryptionContext
            )
        )
        return try await http.post(
            path: "/kms-key/\(id)/generate-data-key",
            body: body,
            as: Exoscale.CryptoDataKey.self
        )
    }

    /// Re-encrypts ciphertext from one KMS key to another.
    ///
    /// - Parameters:
    ///   - id: The KMS key identifier used in the API path.
    ///   - sourceKeyID: The source KMS key identifier.
    ///   - destinationKeyID: The destination KMS key identifier.
    ///   - ciphertext: The base64-encoded ciphertext to re-encrypt.
    ///   - sourceEncryptionContext: Optional source base64-encoded encryption context.
    ///   - destinationEncryptionContext: Optional destination base64-encoded encryption context.
    /// - Returns: The base64-encoded re-encrypted ciphertext returned by the API.
    public func reEncrypt(
        id: String,
        sourceKeyID: String,
        destinationKeyID: String,
        ciphertext: String,
        sourceEncryptionContext: String? = nil,
        destinationEncryptionContext: String? = nil
    ) async throws -> String {
        let body = try JSONEncoder().encode(
            ReEncryptRequest(
                sourceKeyID: sourceKeyID,
                destinationKeyID: destinationKeyID,
                ciphertext: ciphertext,
                sourceEncryptionContext: sourceEncryptionContext,
                destinationEncryptionContext: destinationEncryptionContext
            )
        )
        let response = try await http.post(
            path: "/kms-key/\(id)/re-encrypt",
            body: body,
            as: ReEncryptResponse.self
        )
        return response.ciphertext
    }
}
