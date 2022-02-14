enum GameCompletedStatus: CaseIterable {
    case successful
    case unSuccessful
    case unknown
    
    var imageName: String {
        switch self {
        case .successful: return "correct_btn"
        case .unSuccessful: return "close_btn"
        case .unknown: return "question_btn"
        }
    }
}
