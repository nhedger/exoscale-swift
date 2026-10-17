import Foundation

public extension Exoscale {
    /// Compute instances.
    ///
    /// Calls that change an instance return an ``Operation``; wait for it with
    /// ``Operation/wait(timeout:interval:)``.
    struct Instances: Sendable {
        let client: HTTPClient

        // MARK: Reading

        /// Lists the instances in the zone.
        ///
        /// - Parameters:
        ///   - instancePoolID: Only instances managed by this instance pool.
        ///   - ipAddress: Only instances with this IP address.
        ///   - labels: Only instances with all these labels.
        public func list(
            instancePoolID: String? = nil,
            ipAddress: String? = nil,
            labels: [String: String]? = nil
        ) async throws -> [Instance] {
            try await client.send(
                .get,
                "/instance",
                query: [
                    "manager-id": instancePoolID,
                    "manager-type": instancePoolID.map { _ in "instance-pool" },
                    "ip-address": ipAddress,
                    "labels": labels?.labelFilter
                ],
                unwrapping: "instances"
            )
        }

        /// Retrieves an instance.
        public func get(id: String) async throws -> Instance {
            try await client.send(.get, "/instance/\(id)")
        }

        /// Retrieves the password generated for an instance whose template supports it.
        public func password(id: String) async throws -> String? {
            try await client.send(.get, "/instance/\(id):password", as: Password.self).password
        }

        /// Retrieves a signed URL for the instance's VNC console.
        public func consoleURL(id: String) async throws -> URL {
            let console = try await client.send(.get, "/console/\(id)", as: Console.self)
            guard let url = console.url.flatMap(URL.init(string:)) else {
                throw ClientError.invalidResponse
            }
            return url
        }

        // MARK: Creating and changing

        /// Creates an instance.
        ///
        /// - Parameters:
        ///   - name: The instance's name.
        ///   - instanceTypeID: The instance type, which sets its CPU and memory.
        ///   - templateID: The template to create the instance from.
        ///   - diskSize: The size of the root disk, in GiB, from 10 to 51,200.
        ///   - sshKeys: The names of the SSH keys to install.
        ///   - securityGroupIDs: The security groups to put the instance in.
        ///   - antiAffinityGroupIDs: The anti-affinity groups to put the instance in.
        ///   - deployTargetID: The dedicated hypervisor to run the instance on.
        ///   - publicIPAssignment: Which public addresses the instance gets.
        ///   - labels: Labels to attach to the instance.
        ///   - userData: Base64-encoded cloud-init user data.
        ///   - vpc: The VPC subnets to attach the instance to.
        ///   - ipForwarding: Whether the instance may forward traffic for other addresses in its VPC.
        ///   - autoStart: Whether to start the instance once it's created. The API defaults to `true`.
        ///   - secureBootEnabled: Whether to enable secure boot.
        ///   - tpmEnabled: Whether to add a Trusted Platform Module.
        ///   - applicationConsistentSnapshotEnabled: Whether snapshots ask the guest to flush its
        ///     file systems first.
        /// - Returns: The operation creating the instance. Its reference holds the new instance's
        ///   identifier.
        public func create(
            name: String? = nil,
            instanceTypeID: String,
            templateID: String,
            diskSize: Int,
            sshKeys: [String]? = nil,
            securityGroupIDs: [String]? = nil,
            antiAffinityGroupIDs: [String]? = nil,
            deployTargetID: String? = nil,
            publicIPAssignment: Instance.PublicIPAssignment? = nil,
            labels: [String: String]? = nil,
            userData: String? = nil,
            vpc: Instance.VPCAttachment? = nil,
            ipForwarding: Bool? = nil,
            autoStart: Bool? = nil,
            secureBootEnabled: Bool? = nil,
            tpmEnabled: Bool? = nil,
            applicationConsistentSnapshotEnabled: Bool? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/instance", body: [
                "name": name,
                "instance-type": ["id": instanceTypeID],
                "template": ["id": templateID],
                "disk-size": diskSize,
                "ssh-keys": sshKeys?.map { ["name": $0] },
                "security-groups": securityGroupIDs?.map { ["id": $0] },
                "anti-affinity-groups": antiAffinityGroupIDs?.map { ["id": $0] },
                "deploy-target": deployTargetID.map { ["id": $0] },
                "public-ip-assignment": publicIPAssignment,
                "labels": labels,
                "user-data": userData,
                "vpc": vpc,
                "ip-forwarding": ipForwarding,
                "auto-start": autoStart,
                "secureboot-enabled": secureBootEnabled,
                "tpm-enabled": tpmEnabled,
                "application-consistent-snapshot-enabled": applicationConsistentSnapshotEnabled
            ] as JSONBody)
        }

        /// Updates an instance. Only the values passed are changed.
        ///
        /// - Parameters:
        ///   - id: The instance's identifier.
        ///   - name: A new name.
        ///   - labels: New labels, replacing the current ones. Use ``removeLabels(id:)`` to remove
        ///     them all.
        ///   - userData: New base64-encoded cloud-init user data.
        ///   - publicIPAssignment: Which public addresses the instance has.
        ///   - applicationConsistentSnapshotEnabled: Whether snapshots ask the guest to flush its
        ///     file systems first.
        public func update(
            id: String,
            name: String? = nil,
            labels: [String: String]? = nil,
            userData: String? = nil,
            publicIPAssignment: Instance.PublicIPAssignment? = nil,
            applicationConsistentSnapshotEnabled: Bool? = nil
        ) async throws -> Operation {
            try await client.send(.put, "/instance/\(id)", body: [
                "name": name,
                "labels": labels,
                "user-data": userData,
                "public-ip-assignment": publicIPAssignment,
                "application-consistent-snapshot-enabled": applicationConsistentSnapshotEnabled
            ] as JSONBody)
        }

        /// Removes all labels from an instance.
        public func removeLabels(id: String) async throws -> Operation {
            try await client.send(.delete, "/instance/\(id)/labels")
        }

        /// Deletes an instance.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/instance/\(id)")
        }

        // MARK: Power

        /// Starts an instance, optionally in rescue mode.
        public func start(id: String, rescueProfile: Instance.RescueProfile? = nil) async throws -> Operation {
            try await client.send(.put, "/instance/\(id):start", body: ["rescue-profile": rescueProfile] as JSONBody)
        }

        /// Stops an instance.
        public func stop(id: String) async throws -> Operation {
            try await client.send(.put, "/instance/\(id):stop")
        }

        /// Reboots an instance.
        public func reboot(id: String) async throws -> Operation {
            try await client.send(.put, "/instance/\(id):reboot")
        }

        // MARK: Resizing and resetting

        /// Changes an instance's type. The instance must be stopped.
        public func scale(id: String, instanceTypeID: String) async throws -> Operation {
            try await client.send(
                .put,
                "/instance/\(id):scale",
                body: ["instance-type": ["id": instanceTypeID]] as JSONBody
            )
        }

        /// Grows an instance's root disk. Disks can't shrink.
        ///
        /// - Parameter size: The new size, in GiB, from 10 to 51,200.
        public func resizeDisk(id: String, size: Int) async throws -> Operation {
            try await client.send(.put, "/instance/\(id):resize-disk", body: ["disk-size": size] as JSONBody)
        }

        /// Reinstalls an instance from a template, erasing its root disk.
        ///
        /// - Parameters:
        ///   - templateID: The template to reinstall from. Defaults to the current one.
        ///   - diskSize: A new disk size, in GiB. Defaults to the current one.
        public func reset(id: String, templateID: String? = nil, diskSize: Int? = nil) async throws -> Operation {
            try await client.send(.put, "/instance/\(id):reset", body: [
                "template": templateID.map { ["id": $0] },
                "disk-size": diskSize
            ] as JSONBody)
        }

        /// Generates a new password for an instance whose template supports it.
        public func resetPassword(id: String) async throws -> Operation {
            try await client.send(.put, "/instance/\(id):reset-password")
        }

        // MARK: Snapshots

        /// Creates a snapshot of an instance's root disk.
        public func createSnapshot(id: String) async throws -> Operation {
            try await client.send(.post, "/instance/\(id):create-snapshot")
        }

        /// Restores an instance's root disk from one of its snapshots. The instance must be stopped.
        public func revert(id: String, toSnapshot snapshotID: String) async throws -> Operation {
            try await client.send(.post, "/instance/\(id):revert-snapshot", body: ["id": snapshotID] as JSONBody)
        }

        // MARK: Protection and security

        /// Protects an instance from being deleted until ``unprotect(id:)`` is called.
        public func protect(id: String) async throws -> Operation {
            try await client.send(.put, "/instance/\(id):add-protection")
        }

        /// Allows a protected instance to be deleted again.
        public func unprotect(id: String) async throws -> Operation {
            try await client.send(.put, "/instance/\(id):remove-protection")
        }

        /// Adds a Trusted Platform Module to an instance. It can't be removed afterwards.
        public func enableTPM(id: String) async throws -> Operation {
            try await client.send(.post, "/instance/\(id):enable-tpm")
        }
    }
}

private struct Password: Decodable {
    let password: String?
}

private struct Console: Decodable {
    let url: String?
}
