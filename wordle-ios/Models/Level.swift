//
//  Level.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

import Foundation

struct Levels: Codable {
    let levels: [Level]
}

struct Level: Codable, Equatable, Identifiable {
    let key: String
    let sortableKey: Int
    let name: String
    let word: String
    
    var id: String {
        key
    }
    
    enum CodingKeys: String, CodingKey {
        case key
        case sortableKey = "sortable_key"
        case name
        case word
    }
}
