import Foundation

struct FunFactsList: Equatable, Codable {
    let facts: [FunFact]
}

struct FunFact: Equatable, Codable {
    let word: String
    let description: String
}
