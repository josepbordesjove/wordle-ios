//
//  Letter.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 9/2/22.
//

import Foundation

enum Letter: Identifiable, CaseIterable, LetterRepresentable {
    case q
    case w
    case e
    case r
    case t
    case y
    case u
    case i
    case o
    case p
    
    case a
    case s
    case d
    case f
    case g
    case h
    case j
    case k
    case l
    case ç
    
    case z
    case x
    case c
    case v
    case b
    case n
    case m
    
    var value: String {
        switch self {
        case .q: return "q"
        case .w: return "w"
        case .e: return "e"
        case .r: return "r"
        case .t: return "t"
        case .y: return "y"
        case .u: return "u"
        case .i: return "i"
        case .o: return "o"
        case .p: return "p"
        case .a: return "a"
        case .s: return "s"
        case .d: return "d"
        case .f: return "f"
        case .g: return "g"
        case .h: return "h"
        case .j: return "j"
        case .k: return "k"
        case .l: return "l"
        case .ç: return "ç"
        case .z: return "z"
        case .x: return "x"
        case .c: return "c"
        case .v: return "v"
        case .b: return "b"
        case .n: return "n"
        case .m: return "m"
        }
    }
    
    var id: String {
        return value
    }
}
