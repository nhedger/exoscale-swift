import Exoscale
import Testing

@Suite("Live SSH keys", .enabled(if: IntegrationEnvironment.isEnabled))
struct SSHKeysIntegrationTests {
    @Test("Lists SSH keys")
    func listsSSHKeys() async throws {
        let exoscale = try IntegrationEnvironment.client()

        let sshKeys = try await exoscale.compute.sshKeys.list()

        #expect(sshKeys.allSatisfy { $0.name?.isEmpty == false })
    }
}
