//
//  Box.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 10/2/22.
//

import Foundation

enum Box {
    case unknown
    case correct(String)
    case incorrect(String)
    case contained(String)
}
