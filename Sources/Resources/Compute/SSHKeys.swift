public extension Exoscale {
    /// An SSH public key that can be installed on new instances.
    struct SSHKey: Hashable, Codable, Sendable {
        /// The key's name, which identifies it.
        public let name: String
        /// The key's fingerprint.
        public let fingerprint: String?

        /// Creates an SSH key, for example for previews and tests.
        public init(name: String, fingerprint: String? = nil) {
            self.name = name
            self.fingerprint = fingerprint
        }
    }

    /// SSH public keys that can be installed on new instances.
    struct SSHKeys: Sendable {
        let client: HTTPClient

        /// Lists the SSH keys.
        public func list() async throws -> [SSHKey] {
            try await client.send(.get, "/ssh-key", unwrapping: "ssh-keys")
        }

        /// Retrieves an SSH key.
        public func get(name: String) async throws -> SSHKey {
            try await client.send(.get, "/ssh-key/\(name)")
        }

        /// Imports an SSH public key.
        ///
        /// - Parameters:
        ///   - name: The name to give the key.
        ///   - publicKey: The public key, as in an `authorized_keys` line.
        public func register(name: String, publicKey: String) async throws -> Operation {
            try await client.send(.post, "/ssh-key", body: ["name": name, "public-key": publicKey] as JSONBody)
        }

        /// Deletes an SSH key. Instances it was installed on keep it.
        public func delete(name: String) async throws -> Operation {
            try await client.send(.delete, "/ssh-key/\(name)")
        }
    }
}
