enum HomeAction {
    case updateNextWordChallenge
    case ordersReceived(Result<[String], Error>)
}
