import Foundation
import Testing

@testable import Exoscale

/// Exercises resource methods through the real request encoding, signing and decoding stack.
private final class APIUpdateProtocol: URLProtocol, @unchecked Sendable {
    struct Fixture: Sendable {
        let response: String
        var body: String?
    }

    static let operation = #"{"id":"op","state":"success"}"#
    static let fixtures: [String: Fixture] = [
        "GET /v2/ai/api-key": .init(response: #"{"ai-api-keys":[]}"#),
        "GET /v2/ai/api-key/key": .init(response: #"{"id":"key"}"#),
        "POST /v2/ai/api-key": .init(response: #"{"id":"key","value":"secret"}"#, body: #"{"name":"test","scope":"public"}"#),
        "PATCH /v2/ai/api-key/key": .init(response: #"{"id":"key","name":"renamed"}"#, body: #"{"name":"renamed"}"#),
        "DELETE /v2/ai/api-key/key": .init(response: #"{"deleted":true}"#),
        "POST /v2/ai/api-key/key/rotate": .init(response: #"{"value":"rotated"}"#),
        "GET /v2/ai/api-key/key/reveal": .init(response: #"{"value":"revealed"}"#),
        "GET /v2/ai/quota": .init(response: #"{"quota-uom-per-minute":null}"#),
        "GET /v2/ai/model": .init(response: #"{"models":[]}"#),
        "POST /v2/ai/deployment": .init(response: operation, body: #"{"name":"test","model":{"id":"model"},"gpu-type":"gpua30","gpu-count":1,"replicas":1,"product-name":"billing"}"#),
        "GET /v2/live-balance": .init(response: #"{"balance":12.5,"currency":"CHF"}"#),
        "PUT /v2/iam-role/role": .init(response: operation, body: #"{"assume-role-policy":{"rules":[{"action":"allow","expression":"true"}]}}"#),
        "POST /v2/iam-role/role/assume": .init(response: #"{"key":"temporary","expires-at":"2026-09-12T12:00:00Z"}"#, body: #"{"ttl":900}"#),
        "POST /v2/kms-key/key/schedule-deletion": .init(response: #"{"delete-at":"2026-09-19T14:00:00.000+02:00"}"#, body: "{}"),
        "POST /v2/kms-key": .init(response: #"{"name":"test"}"#, body: #"{"name":"test"}"#),
        "PUT /v2/sks-cluster/cluster/generate-karpenter-nodepool": .init(response: #"{"nodepool":"kind: NodePool\n"}"#),
        "PUT /v2/sks-cluster/cluster/generate-karpenter-exoscale-nodeclass": .init(response: #"{"exoscale-nodeclass":"kind: ExoscaleNodeClass\n"}"#),
        "POST /v2/sks-cluster/cluster/nodepool": .init(response: operation, body: #"{"name":"gpu","size":1,"disk-size":50,"instance-type":{"id":"type"},"nvidia-mig-profiles":{"b300.269gb":"7g.269gb"}}"#),
        "PUT /v2/sks-cluster/cluster/nodepool/nodepool": .init(response: operation, body: #"{"nvidia-mig-profiles":{"a30.24gb":"1g.6gb","rtxpro6000.96gb":"1g.24gb+gfx"}}"#),
        "GET /v2/vpc": .init(response: #"{"vpcs":[{"id":"vpc"}]}"#),
        "POST /v2/vpc": .init(response: operation, body: #"{"name":"test"}"#),
        "GET /v2/vpc/vpc": .init(response: #"{"id":"vpc"}"#),
        "PUT /v2/vpc/vpc": .init(response: #"{"id":"vpc","name":"renamed"}"#, body: #"{"name":"renamed"}"#),
        "DELETE /v2/vpc/vpc": .init(response: "{}"),
        "GET /v2/vpc/vpc/route": .init(response: #"{"routes":[{"kind":"Vpc"}]}"#),
        "GET /v2/vpc/vpc/subnet": .init(response: #"{"subnets":[{"id":"subnet"}]}"#),
        "POST /v2/vpc/vpc/subnet": .init(response: operation, body: #"{"name":"test","addressfamily":"inet4","address-space":"private","ipv4-block":"10.0.0.0/24"}"#),
        "GET /v2/vpc/vpc/subnet/subnet": .init(response: #"{"id":"subnet","instances":[{"id":"vm","ipv4":"10.0.0.2"}]}"#),
        "PUT /v2/vpc/vpc/subnet/subnet": .init(response: #"{"id":"subnet","name":"renamed"}"#, body: #"{"name":"renamed"}"#),
        "DELETE /v2/vpc/vpc/subnet/subnet": .init(response: "{}"),
        "PUT /v2/vpc/vpc/subnet/subnet/attach": .init(response: operation, body: #"{"instance":{"id":"vm"},"ipv4":"10.0.0.2"}"#),
        "PUT /v2/vpc/vpc/subnet/subnet/detach": .init(response: operation, body: #"{"instance":{"id":"vm"}}"#),
        "GET /v2/vpc/vpc/subnet/subnet/route": .init(response: #"{"routes":[{"kind":"Subnet"}]}"#),
        "POST /v2/vpc/vpc/subnet/subnet/route": .init(response: #"{"id":"route","target":"10.0.0.2"}"#, body: #"{"destination":"0.0.0.0/0","target":"10.0.0.2"}"#),
        "DELETE /v2/vpc/vpc/subnet/subnet/route/route": .init(response: "{}"),
        "GET /v2/dbaas-clickhouse/db": .init(response: #"{"name":"db","clickhouse-settings":{"tiered_storage_move_factor":0.2},"connection-info":{"uri":["clickhouse://db"]}}"#),
        "POST /v2/dbaas-clickhouse/db": .init(response: operation, body: #"{"plan":"startup","version":"25","clickhouse-settings":{"tiered_storage_move_factor":0.2}}"#),
        "PUT /v2/dbaas-clickhouse/db": .init(response: operation, body: #"{"version":"26"}"#),
        "DELETE /v2/dbaas-clickhouse/db": .init(response: operation),
        "PUT /v2/dbaas-clickhouse/db/maintenance/start": .init(response: operation),
        "GET /v2/dbaas-settings-clickhouse": .init(response: #"{"settings":{"clickhouse":{"type":"object"}}}"#),
        "GET /v2/dbaas-clickhouse/db/user": .init(response: #"{"users":[{"username":"alice","uuid":"user-id","required":false}]}"#),
        "POST /v2/dbaas-clickhouse/db/user": .init(response: #"{"username":"alice","password":"secret"}"#, body: #"{"username":"alice","roles":[{"uuid":"role-id"}]}"#),
        "DELETE /v2/dbaas-clickhouse/db/user/user-id": .init(response: operation),
        "PUT /v2/dbaas-clickhouse/db/user/alice/password/reset": .init(response: #"{"username":"alice","password":"new"}"#, body: "{}"),
        "GET /v2/dbaas-clickhouse/db/user/alice/password/reveal": .init(response: #"{"username":"alice","password":"new"}"#),
        "GET /v2/dbaas-clickhouse/db/acl-config": .init(response: #"{"users":[{"username":"alice","roles":[],"privileges":[]}]}"#),
        "GET /v2/dbaas-clickhouse/db/role": .init(response: #"{"roles":[{"name":"reader","uuid":"role-id","granted-roles":[]}]}"#),
        "DELETE /v2/dbaas-clickhouse/db/role/role-id": .init(response: operation),
        "PUT /v2/dbaas-mysql/db": .init(response: operation, body: #"{"version":"8.4"}"#),
        "POST /v2/dbaas-valkey/db": .init(response: operation, body: #"{"plan":"startup","version":"8","valkey-settings":{"frequent_snapshots":true,"active_expire_effort":2}}"#),
        "PUT /v2/dbaas-valkey/db": .init(response: operation, body: #"{"version":"8"}"#),
        "POST /v2/dbaas-postgres/db": .init(response: operation, body: #"{"plan":"startup","pgaudit-settings":{"log":"all"}}"#),
        "PUT /v2/dbaas-postgres/db": .init(response: operation, body: #"{"pgaudit-settings":{"log":"all"}}"#),
    ]

    override static func canInit(with request: URLRequest) -> Bool { true }
    override static func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        do {
            let url = try #require(request.url)
            let fixture = try #require(Self.fixtures["\(request.httpMethod ?? "") \(url.path)"])
            #expect(url.query == nil || url.query == "")
            #expect(request.value(forHTTPHeaderField: "Authorization") != nil)
            if let expected = fixture.body {
                var data = request.httpBody ?? Data()
                if let stream = request.httpBodyStream {
                    stream.open()
                    defer { stream.close() }
                    var buffer = [UInt8](repeating: 0, count: 4096)
                    while stream.hasBytesAvailable {
                        let count = stream.read(&buffer, maxLength: buffer.count)
                        if count <= 0 { break }
                        data.append(contentsOf: buffer.prefix(count))
                    }
                }
                let actual = try JSONDecoder().decode(Exoscale.JSONValue.self, from: data)
                let expectedValue = try JSONDecoder().decode(Exoscale.JSONValue.self, from: Data(expected.utf8))
                #expect(actual == expectedValue)
            }
            let response = try #require(HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"]))
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: Data(fixture.response.utf8))
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}

private func apiUpdateClient() throws -> Http.Client {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [APIUpdateProtocol.self]
    return Http.Client(
        config: try Exoscale.Config(apiKey: "test", apiSecret: "test", zone: .chGva2),
        sessionConfiguration: configuration
    )
}

@Test("Current AI key paths, value-only responses and nullable consumption quota")
func currentAIEndpoints() async throws {
    let http = try apiUpdateClient()
    let ai = AIResource(http: http)
    #expect(try await ai.apiKeys.list().isEmpty)
    #expect(try await ai.apiKeys.get(id: "key").id == "key")
    #expect(try await ai.apiKeys.create(name: "test", scope: "public").value == "secret")
    #expect(try await ai.apiKeys.update(id: "key", name: "renamed").name == "renamed")
    #expect(try await ai.apiKeys.rotate(id: "key") == "rotated")
    #expect(try await ai.apiKeys.reveal(id: "key") == "revealed")
    #expect(try await ai.apiKeys.delete(id: "key"))
    #expect(try await ai.consumptionQuota().quotaUOMPerMinute == nil)
    #expect(try await ai.models.list().isEmpty)
    _ = try await ai.deployments.create(name: "test", modelID: "model", gpuType: "gpua30", gpuCount: 1, replicas: 1, productName: "billing")
}

@Test("IAM policy updates, KMS deletion dates, live balance and Karpenter manifests")
func currentIAMKMSAndSKSEndpoints() async throws {
    let http = try apiUpdateClient()
    let roles = RolesResource(http: http)
    _ = try await roles.updateAssumeRolePolicy(id: "role", policy: .init(rules: [.init(action: .allow, expression: "true")]))
    #expect(try await roles.assume(targetRoleID: "role", ttl: 900).expiresAt == Date(timeIntervalSince1970: 1789214400))
    #expect(try await KMSKeysResource(http: http).scheduleDeletion(id: "key") == Date(timeIntervalSince1970: 1789819200))
    #expect(try await KMSKeysResource(http: http).create(name: "test").name == "test")
    #expect(try await OrganizationResource(http: http).liveBalance().balance == 12.5)
    let clusters = ClustersResource(http: http)
    #expect(try await clusters.generateKarpenterNodepool(id: "cluster") == "kind: NodePool\n")
    #expect(try await clusters.generateKarpenterExoscaleNodeclass(id: "cluster") == "kind: ExoscaleNodeClass\n")
}

@Test("All VPC, subnet and route endpoints use their documented response types")
func vpcEndpoints() async throws {
    let vpcs = VPCsResource(http: try apiUpdateClient())
    #expect(try await vpcs.list().first?.id == "vpc")
    #expect(try await vpcs.get(id: "vpc").id == "vpc")
    _ = try await vpcs.create(name: "test")
    #expect(try await vpcs.update(id: "vpc", name: "renamed").name == "renamed")
    #expect(try await vpcs.routes(vpcID: "vpc").first?.kind == .vpc)
    let subnets = vpcs.subnets(vpcID: "vpc")
    #expect(try await subnets.list().first?.id == "subnet")
    _ = try await subnets.create(name: "test", ipv4Block: "10.0.0.0/24")
    #expect(try await subnets.get(id: "subnet").instances?.first?.ipv4 == "10.0.0.2")
    #expect(try await subnets.update(id: "subnet", name: "renamed").name == "renamed")
    _ = try await subnets.attachInstance(id: "subnet", instanceID: "vm", ipv4: "10.0.0.2")
    _ = try await subnets.detachInstance(id: "subnet", instanceID: "vm")
    let routes = subnets.routes(subnetID: "subnet")
    #expect(try await routes.list().first?.kind == .subnet)
    #expect(try await routes.create(destination: "0.0.0.0/0", target: "10.0.0.2").id == "route")
    try await routes.delete(id: "route")
    try await subnets.delete(id: "subnet")
    try await vpcs.delete(id: "vpc")
}

@Test("All ClickHouse endpoints including UUID deletion and synchronous user credentials")
func clickhouseEndpoints() async throws {
    let clickhouse = DBaaSResource(http: try apiUpdateClient()).clickhouse
    #expect(try await clickhouse.get(name: "db").connectionInfo?.uri == ["clickhouse://db"])
    _ = try await clickhouse.create(name: "db", plan: "startup", version: "25", clickhouseSettings: ["tiered_storage_move_factor": .double(0.2)])
    _ = try await clickhouse.update(name: "db", version: "26")
    _ = try await clickhouse.startMaintenance(name: "db")
    #expect(try await clickhouse.settings().clickhouse?.type == "object")
    #expect(try await clickhouse.listUsers(serviceName: "db").first?.uuid == "user-id")
    #expect(try await clickhouse.createUser(serviceName: "db", username: "alice", roles: [.init(uuid: "role-id")]).password == "secret")
    #expect(try await clickhouse.resetUserPassword(serviceName: "db", username: "alice").password == "new")
    #expect(try await clickhouse.revealUserPassword(serviceName: "db", username: "alice").password == "new")
    #expect(try await clickhouse.aclConfig(serviceName: "db").users?.first?.username == "alice")
    #expect(try await clickhouse.listRoles(serviceName: "db").first?.uuid == "role-id")
    _ = try await clickhouse.deleteRole(serviceName: "db", roleUUID: "role-id")
    _ = try await clickhouse.deleteUser(serviceName: "db", userUUID: "user-id")
    _ = try await clickhouse.delete(name: "db")
}

@Test("New database versions and audit settings reach the API")
func updatedDatabaseRequests() async throws {
    let dbaas = DBaaSResource(http: try apiUpdateClient())
    _ = try await dbaas.mysql.update(name: "db", version: "8.4")
    _ = try await dbaas.valkey.create(name: "db", plan: "startup", valkeySettings: ["frequent_snapshots": .bool(true), "active_expire_effort": .integer(2)], version: "8")
    _ = try await dbaas.valkey.update(name: "db", version: "8")
    _ = try await dbaas.postgresql.create(name: "db", plan: "startup", pgauditSettings: ["log": .string("all")])
    _ = try await dbaas.postgresql.update(name: "db", pgauditSettings: ["log": .string("all")])
}

@Test("SKS MIG profiles use current GPU names in create, update and responses")
func nvidiaMIGProfiles() async throws {
    let nodepools = NodepoolsResource(http: try apiUpdateClient())
    _ = try await nodepools.create(clusterID: "cluster", name: "gpu", size: 1, diskSize: 50, instanceTypeID: "type", nvidiaMIGProfiles: .init(b300: "7g.269gb"))
    _ = try await nodepools.update(clusterID: "cluster", id: "nodepool", nvidiaMIGProfiles: .init(a30: "1g.6gb", rtxPro6000: "1g.24gb+gfx"))
    let cluster = try JSONDecoder().decode(Exoscale.SKSCluster.self, from: Data(#"{"oidc":{"issuer-url":"https://issuer.example"},"nodepools":[{"nvidia-mig-profiles":{"b300.269gb":"7g.269gb"}}]}"#.utf8))
    #expect(cluster.nodepools?.first?.nvidiaMIGProfiles?.b300 == "7g.269gb")
    #expect(cluster.oidc?.issuerURL == "https://issuer.example")
}

@Test("New optional response fields and sparse deployment responses decode")
func updatedResponseFields() throws {
    let decoder = Exoscale.jsonDecoder()
    let snapshot = try decoder.decode(Exoscale.Snapshot.self, from: Data(#"{"instance":{"id":"vm","name":"test","disk-encrypted":true,"instance-type":{"id":"type"},"template":{"id":"template"},"ssh-key":{"name":"key"}}}"#.utf8))
    #expect(snapshot.instance?.diskEncrypted == true)
    #expect(snapshot.instance?.instanceType?.id == "type")
    let volume = try decoder.decode(Exoscale.BlockStorageVolume.self, from: Data(#"{"encrypted":true}"#.utf8))
    #expect(volume.encrypted == true)
    let key = try decoder.decode(Exoscale.KMSKey.self, from: Data(#"{"delete-at":"2026-09-19T12:00:00Z","material":{"automatic":true}}"#.utf8))
    #expect(key.deleteAt == Date(timeIntervalSince1970: 1789819200))
    #expect(key.material?.automatic == true)
    let mysql = try decoder.decode(Exoscale.DBaaS.MySQL.Service.self, from: Data(#"{"binlog-retention-period":3600}"#.utf8))
    #expect(mysql.binlogRetentionPeriod == 3600)
    let postgres = try decoder.decode(Exoscale.DBaaS.PostgreSQL.Service.self, from: Data(#"{"pgaudit-settings":{"log":"all"}}"#.utf8))
    #expect(postgres.pgauditSettings?["log"] == .string("all"))
    let deployment = try decoder.decode(Exoscale.AIDeployment.self, from: Data(#"{"name":"shared","state":"ready","deployment-url":"https://example.com","model":{"id":"model"},"visibility":"public"}"#.utf8))
    #expect(deployment.visibility == "public")
    #expect(deployment.gpuCount == nil)
    let instanceType = try decoder.decode(Exoscale.InstanceType.self, from: Data(#"{"family":"gpub300"}"#.utf8))
    #expect(instanceType.family == .gpub300)
}
