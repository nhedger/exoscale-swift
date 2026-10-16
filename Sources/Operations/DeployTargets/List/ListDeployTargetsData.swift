import Foundation

/// Response for listing Deploy Targets.
struct ListDeployTargetsData: Decodable, Sendable {
    let deployTargets: [Exoscale.DeployTarget.Payload]

    enum CodingKeys: String, CodingKey {
        case deployTargets = "deploy-targets"
    }
}
