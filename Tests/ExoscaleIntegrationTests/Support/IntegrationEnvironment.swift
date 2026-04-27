import Foundation
import Exoscale

enum IntegrationEnvironment {
    static let isEnabled = ProcessInfo.processInfo.environment["EXOSCALE_INTEGRATION_TESTS"] == "1"

    static func client() throws -> Exoscale {
        try Exoscale(
            config: Exoscale.Config(userAgent: "exoscale-swift-integration-tests")
        )
    }
}
