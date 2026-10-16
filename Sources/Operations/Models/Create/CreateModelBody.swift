import Foundation

/// Request body for creating an AI model.
struct CreateModelBody: Encodable, Sendable {
    let name: String
    let huggingfaceToken: String?

    init(name: String, huggingfaceToken: String? = nil) {
        self.name = name
        self.huggingfaceToken = huggingfaceToken
    }

    enum CodingKeys: String, CodingKey {
        case name
        case huggingfaceToken = "huggingface-token"
    }
}
