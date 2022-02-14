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
