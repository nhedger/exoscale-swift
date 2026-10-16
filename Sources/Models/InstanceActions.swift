public extension Exoscale.Instance {
    /// Retrieves a fresh instance snapshot. This object remains unchanged.
    func refresh() async throws -> Exoscale.Instance {
        try await InstancesResource(http: client).get(id: id)
    }

    /// Starts the instance, optionally using a rescue profile.
    func start(rescueProfile: RescueProfile? = nil) async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).start(id: id, rescueProfile: rescueProfile)
    }

    /// Stops the instance and returns the asynchronous operation.
    func stop() async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).stop(id: id)
    }

    /// Reboots the instance and returns the asynchronous operation.
    func reboot() async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).reboot(id: id)
    }

    /// Deletes the instance and returns the asynchronous operation.
    func delete() async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).delete(id: id)
    }

    /// Updates the instance and returns the asynchronous operation.
    func update(
        name: String? = nil,
        userData: String? = nil,
        publicIPAssignment: PublicIPAssignment? = nil,
        labels: [String: String]? = nil,
        applicationConsistentSnapshotEnabled: Bool? = nil
    ) async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).update(
            id: id,
            name: name,
            userData: userData,
            publicIPAssignment: publicIPAssignment,
            labels: labels,
            applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled
        )
    }

    /// Resets an instance field to its default value.
    func resetField(_ field: InstancesResource.Field) async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).resetField(id: id, field: field)
    }

    /// Retrieves a signed console proxy URL.
    func console() async throws -> Exoscale.InstanceConsoleProxyURL {
        try await InstancesResource(http: client).console(id: id)
    }

    /// Enables destruction protection.
    func addProtection() async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).addProtection(id: id)
    }

    /// Removes destruction protection.
    func removeProtection() async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).removeProtection(id: id)
    }

    /// Creates a snapshot of the instance.
    func createSnapshot() async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).createSnapshot(id: id)
    }

    /// Enables TPM for the instance.
    func enableTPM() async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).enableTPM(id: id)
    }

    /// Reveals the transient password returned by the API.
    func revealPassword() async throws -> Exoscale.InstancePassword {
        try await InstancesResource(http: client).revealPassword(id: id)
    }

    /// Resets the instance password.
    func resetPassword() async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).resetPassword(id: id)
    }

    /// Re-installs the instance using its current or a specified template.
    func reset(templateID: String? = nil, diskSize: Int? = nil) async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).reset(id: id, templateID: templateID, diskSize: diskSize)
    }

    /// Resizes the instance disk in GiB.
    func resizeDisk(diskSize: Int) async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).resizeDisk(id: id, diskSize: diskSize)
    }

    /// Scales the instance to another instance type.
    func scale(instanceTypeID: String) async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).scale(id: id, instanceTypeID: instanceTypeID)
    }

    /// Reverts the stopped instance to a snapshot.
    func revertSnapshot(snapshotID: String) async throws -> Exoscale.Operation {
        try await InstancesResource(http: client).revertSnapshot(id: id, snapshotID: snapshotID)
    }
}
