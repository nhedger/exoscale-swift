import Foundation

/// Access to compute instance API operations.
public struct InstancesResource {
    public enum Field: String, Sendable {
        case labels
    }

    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Retrieves a signed console proxy URL for a compute instance.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The signed console proxy URL returned by the API.
    public func console(id: String) async throws -> Exoscale.InstanceConsoleProxyURL {
        try await http.get(path: "/console/\(id)", as: Exoscale.InstanceConsoleProxyURL.self)
    }

    /// Lists compute instances in the configured zone.
    ///
    /// - Parameters:
    ///   - managerId: Restrict results to instances managed by the specified resource.
    ///   - managerType: Restrict results to instances managed by the specified resource type.
    ///   - ipAddress: Restrict results to instances matching the specified IP address.
    ///   - labels: Restrict results to instances matching the specified labels.
    /// - Returns: The list of compute instances returned by the API.
    public func list(
        managerId: String? = nil,
        managerType: String? = nil,
        ipAddress: String? = nil,
        labels: [String: String]? = nil
    ) async throws -> [Exoscale.Instance] {
        var query: [String: String?] = [:]

        if let managerId {
            query["manager-id"] = managerId
        }

        if let managerType {
            query["manager-type"] = managerType
        }

        if let ipAddress {
            query["ip-address"] = ipAddress
        }

        if let labels = serializeLabels(labels) {
            query["labels"] = labels
        }

        let response = try await http.get(
            path: "/instance",
            query: query,
            as: ListInstancesResponse.self
        )
        return response.instances
    }

    /// Creates a compute instance.
    ///
    /// - Parameters:
    ///   - diskSize: The instance disk size in GiB.
    ///   - instanceTypeID: The instance type identifier.
    ///   - templateID: The template identifier.
    ///   - applicationConsistentSnapshotEnabled: Optional application-consistent snapshot flag.
    ///   - antiAffinityGroupIDs: Optional anti-affinity group identifiers.
    ///   - publicIPAssignment: Optional public IP assignment mode.
    ///   - labels: Optional instance labels.
    ///   - autoStart: Optional flag controlling whether the instance starts after creation.
    ///   - securityGroupIDs: Optional security group identifiers.
    ///   - name: Optional instance name.
    ///   - secureBootEnabled: Optional secure boot flag.
    ///   - sshKeyName: Optional legacy SSH key name.
    ///   - userData: Optional base64-encoded cloud-init user data.
    ///   - tpmEnabled: Optional TPM flag.
    ///   - deployTargetID: Optional deploy target identifier.
    ///   - ipv6Enabled: Optional deprecated IPv6 flag.
    ///   - sshKeyNames: Optional SSH key names.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        diskSize: Int,
        instanceTypeID: String,
        templateID: String,
        applicationConsistentSnapshotEnabled: Bool? = nil,
        antiAffinityGroupIDs: [String]? = nil,
        publicIPAssignment: Exoscale.Instance.PublicIPAssignment? = nil,
        labels: [String: String]? = nil,
        autoStart: Bool? = nil,
        securityGroupIDs: [String]? = nil,
        name: String? = nil,
        secureBootEnabled: Bool? = nil,
        sshKeyName: String? = nil,
        userData: String? = nil,
        tpmEnabled: Bool? = nil,
        deployTargetID: String? = nil,
        ipv6Enabled: Bool? = nil,
        sshKeyNames: [String]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateInstanceRequest(
                applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled,
                antiAffinityGroups: antiAffinityGroupIDs?.map { InstanceIDReference(id: $0) },
                publicIPAssignment: publicIPAssignment,
                labels: labels,
                autoStart: autoStart,
                securityGroups: securityGroupIDs?.map { InstanceIDReference(id: $0) },
                name: name,
                instanceType: InstanceIDReference(id: instanceTypeID),
                template: InstanceIDReference(id: templateID),
                secureBootEnabled: secureBootEnabled,
                sshKey: sshKeyName.map { InstanceSSHKeyReference(name: $0) },
                userData: userData,
                tpmEnabled: tpmEnabled,
                deployTarget: deployTargetID.map { InstanceIDReference(id: $0) },
                ipv6Enabled: ipv6Enabled,
                diskSize: diskSize,
                sshKeys: sshKeyNames?.map { InstanceSSHKeyReference(name: $0) }
            )
        )

        return try await http.post(path: "/instance", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a compute instance.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/instance/\(id)", as: Exoscale.Operation.self)
    }

    /// Retrieves a compute instance by identifier.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The compute instance returned by the API.
    public func get(id: String) async throws -> Exoscale.Instance {
        try await http.get(path: "/instance/\(id)", as: Exoscale.Instance.self)
    }

    /// Updates a compute instance.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - name: Optional instance name.
    ///   - userData: Optional base64-encoded cloud-init user data.
    ///   - publicIPAssignment: Optional public IP assignment mode.
    ///   - labels: Optional instance labels.
    ///   - applicationConsistentSnapshotEnabled: Optional application-consistent snapshot flag.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        id: String,
        name: String? = nil,
        userData: String? = nil,
        publicIPAssignment: Exoscale.Instance.PublicIPAssignment? = nil,
        labels: [String: String]? = nil,
        applicationConsistentSnapshotEnabled: Bool? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateInstanceRequest(
                name: name,
                userData: userData,
                publicIPAssignment: publicIPAssignment,
                labels: labels,
                applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled
            )
        )

        return try await http.put(path: "/instance/\(id)", body: body, as: Exoscale.Operation.self)
    }

    /// Resets an instance field to its default value.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - field: The instance field to reset.
    /// - Returns: The asynchronous operation returned by the API.
    public func resetField(id: String, field: Field) async throws -> Exoscale.Operation {
        try await http.delete(path: "/instance/\(id)/\(field.rawValue)", as: Exoscale.Operation.self)
    }

    /// Enables instance destruction protection.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func addProtection(id: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/instance/\(id):add-protection", as: Exoscale.Operation.self)
    }

    /// Creates a snapshot of a compute instance.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func createSnapshot(id: String) async throws -> Exoscale.Operation {
        try await http.post(path: "/instance/\(id):create-snapshot", as: Exoscale.Operation.self)
    }

    /// Enables TPM for a compute instance.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func enableTPM(id: String) async throws -> Exoscale.Operation {
        try await http.post(path: "/instance/\(id):enable-tpm", as: Exoscale.Operation.self)
    }

    /// Reveals the password used during instance creation or the latest password reset.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The transient password returned by the API.
    public func revealPassword(id: String) async throws -> Exoscale.InstancePassword {
        try await http.get(path: "/instance/\(id):password", as: Exoscale.InstancePassword.self)
    }

    /// Reboots a compute instance.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func reboot(id: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/instance/\(id):reboot", as: Exoscale.Operation.self)
    }

    /// Removes instance destruction protection.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func removeProtection(id: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/instance/\(id):remove-protection", as: Exoscale.Operation.self)
    }

    /// Re-installs a compute instance to a base or target template.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - templateID: Optional target template identifier.
    ///   - diskSize: Optional instance disk size in GiB.
    /// - Returns: The asynchronous operation returned by the API.
    public func reset(
        id: String,
        templateID: String? = nil,
        diskSize: Int? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            ResetInstanceRequest(
                template: templateID.map { InstanceIDReference(id: $0) },
                diskSize: diskSize
            )
        )

        return try await http.put(path: "/instance/\(id):reset", body: body, as: Exoscale.Operation.self)
    }

    /// Resets a compute instance password.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func resetPassword(id: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/instance/\(id):reset-password", as: Exoscale.Operation.self)
    }

    /// Resizes a compute instance disk.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - diskSize: The target disk size in GiB.
    /// - Returns: The asynchronous operation returned by the API.
    public func resizeDisk(id: String, diskSize: Int) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(ResizeInstanceDiskRequest(diskSize: diskSize))
        return try await http.put(path: "/instance/\(id):resize-disk", body: body, as: Exoscale.Operation.self)
    }

    /// Scales a compute instance to a new instance type.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - instanceTypeID: The target instance type identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func scale(id: String, instanceTypeID: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            ScaleInstanceRequest(instanceType: InstanceIDReference(id: instanceTypeID))
        )
        return try await http.put(path: "/instance/\(id):scale", body: body, as: Exoscale.Operation.self)
    }

    /// Starts a compute instance.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - rescueProfile: Optional rescue mode profile.
    /// - Returns: The asynchronous operation returned by the API.
    public func start(
        id: String,
        rescueProfile: Exoscale.Instance.RescueProfile? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(StartInstanceRequest(rescueProfile: rescueProfile))
        return try await http.put(path: "/instance/\(id):start", body: body, as: Exoscale.Operation.self)
    }

    /// Stops a compute instance.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func stop(id: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/instance/\(id):stop", as: Exoscale.Operation.self)
    }

    /// Reverts a stopped compute instance to a snapshot.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - snapshotID: The snapshot identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func revertSnapshot(id: String, snapshotID: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(RevertInstanceSnapshotRequest(id: snapshotID))
        return try await http.post(path: "/instance/\(id):revert-snapshot", body: body, as: Exoscale.Operation.self)
    }
}
