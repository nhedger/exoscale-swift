import Foundation

extension Exoscale.Event {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let iamUser: Exoscale.User.Payload?
        let requestID: String?
        let iamRole: Exoscale.Role.Payload?
        let zone: String?
        let getParams: [String: Exoscale.JSONValue]?
        let bodyParams: [String: Exoscale.JSONValue]?
        let status: Int?
        let sourceIP: String?
        let iamAPIKey: Exoscale.APIKey.Payload?
        let uri: String?
        let elapsedMS: Int?
        let timestamp: Date?
        let pathParams: [String: Exoscale.JSONValue]?
        let handler: String?
        let message: String?
    }
}

extension Exoscale.Event.Payload {
    enum CodingKeys: String, CodingKey {
        case iamUser = "iam-user"
        case requestID = "request-id"
        case iamRole = "iam-role"
        case zone
        case getParams = "get-params"
        case bodyParams = "body-params"
        case status
        case sourceIP = "source-ip"
        case iamAPIKey = "iam-api-key"
        case uri
        case elapsedMS = "elapsed-ms"
        case timestamp
        case pathParams = "path-params"
        case handler
        case message
    }
}
