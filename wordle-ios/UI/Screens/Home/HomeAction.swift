enum HomeAction {
    case updateNextWordChallenge
    case nextLevelReceived(Result<Level?, Error>)
}
