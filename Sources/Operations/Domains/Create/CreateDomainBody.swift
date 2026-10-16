import Foundation

/// Request body for creating a DNS domain.
struct CreateDomainBody: Encodable, Sendable {
    let unicodeName: String

    enum CodingKeys: String, CodingKey {
        case unicodeName = "unicode-name"
    }
}
