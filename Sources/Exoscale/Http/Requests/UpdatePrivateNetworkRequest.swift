/// Request body for updating a Private Network.
struct UpdatePrivateNetworkRequest: Codable, Sendable {
    let name: String?
    let description: String?
    let netmask: String?
    let startIP: String?
    let endIP: String?
    let labels: [String: String]?
    let options: Exoscale.PrivateNetwork.Options?

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case netmask
        case startIP = "start-ip"
        case endIP = "end-ip"
        case labels
        case options
    }
}
