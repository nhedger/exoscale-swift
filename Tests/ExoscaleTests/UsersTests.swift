import Foundation
import Testing

@testable import Exoscale

@Test("CreateUserRequest encodes request body")
func createUserRequestEncodesRequestBody() throws {
    let request = CreateUserRequest(
        email: "dev@example.com",
        roleID: "11111111-1111-1111-1111-111111111111"
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
    let role = try #require(object["role"] as? [String: String])

    #expect(object["email"] as? String == "dev@example.com")
    #expect(role["id"] == "11111111-1111-1111-1111-111111111111")
}

@Test("CreateUserRequest omits missing role")
func createUserRequestOmitsMissingRole() throws {
    let request = CreateUserRequest(email: "dev@example.com")

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["email"] as? String == "dev@example.com")
    #expect(object["role"] == nil)
}

@Test("UpdateUserRoleRequest encodes request body")
func updateUserRoleRequestEncodesRequestBody() throws {
    let request = UpdateUserRoleRequest(roleID: "11111111-1111-1111-1111-111111111111")

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
    let role = try #require(object["role"] as? [String: String])

    #expect(role["id"] == "11111111-1111-1111-1111-111111111111")
}

@Test("ListUsersResponse decodes users")
func listUsersResponseDecodesUsers() throws {
    let data = Data(
        """
        {
          "users": [
            {
              "id": "22222222-2222-2222-2222-222222222222",
              "email": "dev@example.com",
              "sso": true,
              "two-factor-authentication": false,
              "pending": true,
              "role": {
                "id": "11111111-1111-1111-1111-111111111111",
                "name": "developer",
                "description": "Developer role",
                "editable": true
              }
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListUsersResponse.self, from: data)

    #expect(response.users.count == 1)
    #expect(response.users[0].id == "22222222-2222-2222-2222-222222222222")
    #expect(response.users[0].email == "dev@example.com")
    #expect(response.users[0].sso == true)
    #expect(response.users[0].twoFactorAuthentication == false)
    #expect(response.users[0].pending == true)
    #expect(response.users[0].role?.id == "11111111-1111-1111-1111-111111111111")
    #expect(response.users[0].role?.name == "developer")
}
