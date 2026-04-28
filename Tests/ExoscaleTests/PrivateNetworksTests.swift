import Foundation
import Testing

@testable import Exoscale

@Test("CreatePrivateNetworkRequest encodes request body")
func createPrivateNetworkRequestEncodesRequestBody() throws {
    let request = CreatePrivateNetworkRequest(
        name: "backend-net",
        description: "Backend network",
        netmask: "255.255.255.0",
        startIP: "10.0.0.10",
        endIP: "10.0.0.100",
        labels: ["env": "prod"],
        options: .init(
            routers: ["10.0.0.1"],
            dnsServers: ["10.0.0.2"],
            ntpServers: ["10.0.0.3"],
            domainSearch: ["example.internal"]
        )
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
    let labels = try #require(object["labels"] as? [String: String])
    let options = try #require(object["options"] as? [String: [String]])

    #expect(object["name"] as? String == "backend-net")
    #expect(object["description"] as? String == "Backend network")
    #expect(object["netmask"] as? String == "255.255.255.0")
    #expect(object["start-ip"] as? String == "10.0.0.10")
    #expect(object["end-ip"] as? String == "10.0.0.100")
    #expect(labels["env"] == "prod")
    #expect(options["routers"] == ["10.0.0.1"])
    #expect(options["dns-servers"] == ["10.0.0.2"])
    #expect(options["ntp-servers"] == ["10.0.0.3"])
    #expect(options["domain-search"] == ["example.internal"])
}

@Test("UpdatePrivateNetworkRequest encodes request body")
func updatePrivateNetworkRequestEncodesRequestBody() throws {
    let request = UpdatePrivateNetworkRequest(
        name: "backend-net-updated",
        description: "Updated backend network",
        netmask: "255.255.254.0",
        startIP: "10.0.1.10",
        endIP: "10.0.1.100",
        labels: ["env": "staging"],
        options: .init(routers: ["10.0.1.1"])
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
    let labels = try #require(object["labels"] as? [String: String])
    let options = try #require(object["options"] as? [String: [String]])

    #expect(object["name"] as? String == "backend-net-updated")
    #expect(object["description"] as? String == "Updated backend network")
    #expect(object["netmask"] as? String == "255.255.254.0")
    #expect(object["start-ip"] as? String == "10.0.1.10")
    #expect(object["end-ip"] as? String == "10.0.1.100")
    #expect(labels["env"] == "staging")
    #expect(options["routers"] == ["10.0.1.1"])
}

@Test("PrivateNetworkInstanceRequest encodes instance reference")
func privateNetworkInstanceRequestEncodesInstanceReference() throws {
    let request = PrivateNetworkInstanceRequest(
        instanceID: "11111111-1111-1111-1111-111111111111",
        ip: "10.0.0.50"
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
    let instance = try #require(object["instance"] as? [String: String])

    #expect(object["ip"] as? String == "10.0.0.50")
    #expect(instance["id"] == "11111111-1111-1111-1111-111111111111")
}

@Test("ListPrivateNetworksResponse decodes private networks")
func listPrivateNetworksResponseDecodesPrivateNetworks() throws {
    let data = Data(
        """
        {
          "private-networks": [
            {
              "id": "11111111-1111-1111-1111-111111111111",
              "name": "backend-net",
              "description": "Backend network",
              "labels": { "env": "prod" },
              "start-ip": "10.0.0.10",
              "end-ip": "10.0.0.100",
              "netmask": "255.255.255.0",
              "vni": 1001,
              "options": {
                "routers": ["10.0.0.1"],
                "dns-servers": ["10.0.0.2"],
                "ntp-servers": ["10.0.0.3"],
                "domain-search": ["example.internal"]
              },
              "leases": [
                {
                  "ip": "10.0.0.50",
                  "instance-id": "22222222-2222-2222-2222-222222222222"
                }
              ]
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListPrivateNetworksResponse.self, from: data)
    let privateNetwork = try #require(response.privateNetworks.first)

    #expect(privateNetwork.id == "11111111-1111-1111-1111-111111111111")
    #expect(privateNetwork.name == "backend-net")
    #expect(privateNetwork.description == "Backend network")
    #expect(privateNetwork.labels == ["env": "prod"])
    #expect(privateNetwork.startIP == "10.0.0.10")
    #expect(privateNetwork.endIP == "10.0.0.100")
    #expect(privateNetwork.netmask == "255.255.255.0")
    #expect(privateNetwork.vni == 1001)
    #expect(privateNetwork.options?.routers == ["10.0.0.1"])
    #expect(privateNetwork.options?.dnsServers == ["10.0.0.2"])
    #expect(privateNetwork.options?.ntpServers == ["10.0.0.3"])
    #expect(privateNetwork.options?.domainSearch == ["example.internal"])
    #expect(privateNetwork.leases?.first?.ip == "10.0.0.50")
    #expect(privateNetwork.leases?.first?.instanceID == "22222222-2222-2222-2222-222222222222")
}

@Test("Client builds Private Network action paths")
func clientBuildsPrivateNetworkActionPaths() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let attachRequest = try client.http.makeRequest("PUT", path: "/private-network/network-id:attach")
    let updateIPRequest = try client.http.makeRequest("PUT", path: "/private-network/network-id:update-ip")

    #expect(attachRequest.url?.path == "/v2/private-network/network-id:attach")
    #expect(updateIPRequest.url?.path == "/v2/private-network/network-id:update-ip")
}
