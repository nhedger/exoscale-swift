import Foundation

/// The calls every DBaaS engine shares, under `/dbaas-<engine>`.
struct DBaaSEngineCalls: Sendable {
    let client: HTTPClient
    /// The engine as it appears in paths, such as `postgres`.
    let engine: String

    func get<Service: Decodable>(_ name: String) async throws -> Service {
        try await client.send(.get, "/dbaas-\(engine)/\(name)")
    }

    func create(_ name: String, body: JSONBody) async throws -> Exoscale.Operation {
        try await client.send(.post, "/dbaas-\(engine)/\(name)", body: body)
    }

    func update(_ name: String, body: JSONBody) async throws -> Exoscale.Operation {
        try await client.send(.put, "/dbaas-\(engine)/\(name)", body: body)
    }

    func delete(_ name: String) async throws -> Exoscale.Operation {
        try await client.send(.delete, "/dbaas-\(engine)/\(name)")
    }

    func startMaintenance(_ name: String) async throws -> Exoscale.Operation {
        try await client.send(.put, "/dbaas-\(engine)/\(name)/maintenance/start")
    }

    func stopMigration(_ name: String) async throws -> Exoscale.Operation {
        try await client.send(.post, "/dbaas-\(engine)/\(name)/migration/stop")
    }

    func deleteUser(_ username: String, from service: String) async throws -> Exoscale.Operation {
        try await client.send(.delete, "/dbaas-\(engine)/\(service)/user/\(username)")
    }

    func resetPassword<Response: Decodable>(
        of username: String,
        in service: String,
        body: JSONBody
    ) async throws -> Response {
        try await client.send(.put, "/dbaas-\(engine)/\(service)/user/\(username)/password/reset", body: body)
    }

    func revealPassword(of username: String, in service: String) async throws -> Exoscale.DBaaSService.Credentials {
        try await client.send(.get, "/dbaas-\(engine)/\(service)/user/\(username)/password/reveal")
    }
}
