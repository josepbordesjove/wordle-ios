import Foundation

enum Letter: String, Identifiable, CaseIterable, LetterRepresentable {
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
        rawValue
    }
    
    var id: String {
        rawValue
    }
}
