@testable import Exoscale
import Foundation
import Testing

private func decode<Value: Decodable>(_: Value.Type, _ json: String) throws -> Value {
    try Exoscale.jsonDecoder().decode(Value.self, from: Data(json.utf8))
}

@Test("An unknown instance state is kept without failing the list")
func unknownInstanceStateIsKept() throws {
    let response = try decode(ListInstancesData.self, #"""
    {"instances":[{"id":"vm-1","name":"a","state":"hibernating"},{"id":"vm-2","name":"b","state":"running"}]}
    """#)

    #expect(response.instances.map(\.id) == ["vm-1", "vm-2"])
    #expect(response.instances.map(\.state) == [.unknown("hibernating"), .running])
}

@Test("A degraded nodepool and unknown SKS values no longer fail cluster decoding")
func sksClusterKeepsNewNodepoolStatesAndAddons() throws {
    let response = try decode(ListSKSClustersData.self, #"""
    {"sks-clusters":[{"id":"cluster-1","state":"running",
      "addons":["metrics-server","future-addon","karpenter"],
      "nodepools":[{"id":"pool-1","state":"degraded"},{"id":"pool-2","state":"hibernating"}]}]}
    """#)
    let cluster = try #require(response.clusters.first)

    #expect(cluster.addons == [.metricsServer, .unknown("future-addon"), .karpenter])
    #expect(cluster.nodepools?.map(\.state) == [.degraded, .unknown("hibernating")])
}

@Test("Unknown values inside public nested models are kept")
func unknownSecurityGroupRuleProtocolIsKept() throws {
    let group = try decode(Exoscale.SecurityGroup.Payload.self, #"""
    {"id":"sg-1","rules":[{"id":"rule-1","protocol":"sctp","flow-direction":"ingress"}]}
    """#)
    let rule = try #require(group.rules?.first)

    #expect(rule.networkProtocol == .unknown("sctp"))
    #expect(rule.flowDirection == .ingress)
}

@Test("Unknown values survive being sent back to the API")
func unknownValuesRoundTrip() throws {
    let body = try JSONEncoder().encode(
        UpdateSKSClusterBody(
            description: nil, labels: nil, autoUpgrade: nil, oidc: nil, name: nil,
            enableOperatorsCA: nil, featureGates: nil,
            addons: [.metricsServer, .unknown("future-addon")], audit: nil
        )
    )
    let object = try #require(JSONSerialization.jsonObject(with: body) as? [String: Any])

    #expect(object["addons"] as? [String] == ["metrics-server", "future-addon"])
}

@Test("Raw values map to known cases and everything else to unknown")
func rawValuesNormalize() {
    #expect(Exoscale.Instance.State(rawValue: "running") == .running)
    #expect(Exoscale.SKSNodepool.State(rawValue: "renewing-token") == .renewingToken)
    #expect(Exoscale.Instance.State(rawValue: "hibernating") == .unknown("hibernating"))
    #expect(Exoscale.Instance.State.unknown("running") == .running)
    #expect(Set([Exoscale.Instance.State.unknown("running"), .running]).count == 1)
    #expect(Exoscale.Operation.Reason(rawValue: "unknown") == .unknownReason)
    #expect(!Exoscale.Instance.State.allCases.contains(.unknown("hibernating")))
}

@Test("Zones added after this SDK version are kept")
func newerZonesAreKept() throws {
    let template = try decode(Exoscale.Template.Payload.self, #"{"id":"t-1","zones":["ch-gva-2","xx-new-1"]}"#)
    #expect(template.zones == [.chGva2, "xx-new-1"])

    let data = try decode(ListZonesData.self, #"""
    {"zones":[
      {"name":"xx-new-1","api-endpoint":"https://api-xx-new-1.exoscale.com/v2",
       "sos-endpoint":"https://sos-xx-new-1.exo.io"},
      {"name":"de-fra-1","api-endpoint":"https://api-de-fra-1.exoscale.com/v2",
       "sos-endpoint":"https://sos-de-fra-1.exo.io"}
    ]}
    """#)
    let client = try Exoscale(apiKey: "key", apiSecret: "secret")
    let zones = ZonesOperations.List.Response(data: data).transform(client: client.http)

    #expect(zones.map(\.name) == ["xx-new-1", .deFra1])
    #expect(zones.map(\.name.knownZone) == [nil, .deFra1])
}

@Test("Zone name shortcuts match the known zones")
func zoneNameShortcutsMatchKnownZones() {
    let shortcuts: [Exoscale.ZoneName] = [.atVie1, .atVie2, .bgSof1, .chDk2, .chGva2, .deFra1, .deMuc1, .hrZag1]
    #expect(shortcuts.map(\.rawValue) == Exoscale.KnownZone.allCases.map(\.rawValue))
}

@Test("Values from the current API spec decode as known cases")
func currentSpecValuesDecode() throws {
    let deployments = try decode(ListDeploymentsData.self, #"""
    {"deployments":[{"id":"d-1","state":"preparing"},{"id":"d-2","state":"scaling"},{"id":"d-3","state":"updating"}]}
    """#)
    #expect(deployments.deployments.map(\.state) == [.preparing, .scaling, .updating])

    let action = try decode(KMSKeyActionData.self, #"{"status":"already-applied"}"#)
    #expect(action.status == .alreadyApplied)
}

@Test("Enum values of the wrong JSON type still fail decoding")
func wrongEnumValueTypeStillFails() {
    #expect(throws: DecodingError.self) {
        try decode(ListInstancesData.self, #"{"instances":[{"id":"vm-1","name":"a","state":42}]}"#)
    }
}
