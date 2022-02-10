//
//  GameConfiguration.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 10/2/22.
//

import Foundation

enum GameConfiguration {
    case standard
    
    var rows: Int {
        switch self {
        case .standard:
            return 6
        }
    }
    
    var columns: Int {
        switch self {
        case .standard:
            return 5
        }
    }
}
