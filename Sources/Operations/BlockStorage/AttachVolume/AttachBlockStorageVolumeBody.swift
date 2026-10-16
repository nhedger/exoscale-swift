import Foundation

/// Request body for attaching a block storage volume to an instance.
struct AttachBlockStorageVolumeBody: Encodable, Sendable {
    let instance: InstanceIDReference
}
