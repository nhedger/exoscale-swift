import Exoscale
import Testing

@Suite("Live security groups", .enabled(if: IntegrationEnvironment.isEnabled))
struct SecurityGroupsIntegrationTests {
    @Test("Lists security groups")
    func listsSecurityGroups() async throws {
        let exoscale = try IntegrationEnvironment.client()

        let securityGroups = try await exoscale.compute.securityGroups.list()

        #expect(!securityGroups.isEmpty)
        #expect(securityGroups.allSatisfy { $0.id?.isEmpty == false })
        #expect(securityGroups.allSatisfy { $0.name?.isEmpty == false })
    }
}
