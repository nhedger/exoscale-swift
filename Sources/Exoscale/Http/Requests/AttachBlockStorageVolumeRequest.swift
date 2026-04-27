/// Request body for attaching a block storage volume to an instance.
struct AttachBlockStorageVolumeRequest: Codable, Sendable {
    let instance: InstanceIDReference
}
