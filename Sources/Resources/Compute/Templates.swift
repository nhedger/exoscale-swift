public extension Exoscale {
    /// Disk images instances are created from.
    struct Templates: Sendable {
        let client: HTTPClient

        /// Lists templates.
        ///
        /// - Parameters:
        ///   - visibility: Only templates provided by Exoscale, or only the organization's own.
        ///   - family: Only templates of this operating system family, such as `ubuntu`.
        public func list(visibility: Template.Visibility? = nil, family: String? = nil) async throws -> [Template] {
            try await client.send(
                .get,
                "/template",
                query: ["visibility": visibility?.rawValue, "family": family],
                unwrapping: "templates"
            )
        }

        /// Retrieves a template.
        public func get(id: String) async throws -> Template {
            try await client.send(.get, "/template/\(id)")
        }

        /// Registers a template from a disk image.
        ///
        /// - Parameters:
        ///   - name: The template's name.
        ///   - url: Where to download the image, in QCOW2 format.
        ///   - checksum: The image's MD5 checksum.
        ///   - sshKeyEnabled: Whether to install SSH keys on instances created from the template.
        ///   - passwordEnabled: Whether to generate a password for instances created from it.
        ///   - description: The template's description.
        ///   - defaultUser: The user to log in as.
        ///   - bootMode: The firmware to boot with.
        ///   - size: The template's size.
        ///   - version: The template's version.
        ///   - build: The template's build.
        ///   - maintainer: Who maintains the template.
        ///   - applicationConsistentSnapshotEnabled: Whether snapshots ask the guest to flush its
        ///     file systems first.
        public func register(
            name: String,
            url: String,
            checksum: String,
            sshKeyEnabled: Bool,
            passwordEnabled: Bool,
            description: String? = nil,
            defaultUser: String? = nil,
            bootMode: Template.BootMode? = nil,
            size: Int? = nil,
            version: String? = nil,
            build: String? = nil,
            maintainer: String? = nil,
            applicationConsistentSnapshotEnabled: Bool? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/template", body: [
                "name": name,
                "url": url,
                "checksum": checksum,
                "ssh-key-enabled": sshKeyEnabled,
                "password-enabled": passwordEnabled,
                "description": description,
                "default-user": defaultUser,
                "boot-mode": bootMode,
                "size": size,
                "version": version,
                "build": build,
                "maintainer": maintainer,
                "application-consistent-snapshot-enabled": applicationConsistentSnapshotEnabled
            ] as JSONBody)
        }

        /// Updates a template's name or description.
        public func update(id: String, name: String? = nil, description: String? = nil) async throws -> Operation {
            try await client.send(.put, "/template/\(id)", body: ["name": name, "description": description] as JSONBody)
        }

        /// Copies a template to another zone.
        public func copy(id: String, to zone: Zone) async throws -> Operation {
            try await client.send(.post, "/template/\(id)", body: ["target-zone": ["name": zone]] as JSONBody)
        }

        /// Deletes a template.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/template/\(id)")
        }
    }
}
