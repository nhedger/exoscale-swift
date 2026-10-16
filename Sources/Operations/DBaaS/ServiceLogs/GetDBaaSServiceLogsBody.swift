import Foundation

/// Request body for querying DBaaS service logs.
struct GetDBaaSServiceLogsBody: Encodable, Sendable {
    let limit: Int?
    let sortOrder: Exoscale.DBaaS.SortOrder?
    let offset: String?

    enum CodingKeys: String, CodingKey {
        case limit
        case sortOrder = "sort-order"
        case offset
    }
}
