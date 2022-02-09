//
//  CatalanKeyboard.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 9/2/22.
//

import Foundation

protocol LineRepresentable {
    var letters: [Letter] { get }
}

protocol LetterRepresentable {
    var value: String { get }
}

enum CatalanKeyboardLines: Identifiable, CaseIterable, LineRepresentable {
    case firstLine
    case secondLine
    case thirdLine
    
    var letters: [Letter] {
        switch self {
        case .firstLine: return [.q, .w, .e, .r, .t, .y, .u, .i, .o, .p]
        case .secondLine: return [.a, .s, .d, .f, .g, .h, .j, .k, .l, .ç]
        case .thirdLine: return [.z, .x, .c, .v, .b, .n, .m]
        }
    }
    
    var id: String {
        switch self {
        case .firstLine: return "firstLine"
        case .secondLine: return "secondLine"
        case .thirdLine: return "thirdLine"
        }
    }
}
