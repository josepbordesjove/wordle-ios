import Foundation

enum GameAction {
    case checkLastWord
    case deleteLastLetter
    case appendLetter(Letter)
    case backButtonTapped
    case dismissToast
    case dismissDialog
    case storeLevelFinishedReceived(Result<Bool, Error>)
}