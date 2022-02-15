import Foundation

enum GameListAction {
    case getLevels
    case levelsReceived(Result<[Level], Error>)
    case getFinishedLevelsReceived(Result<[LevelFinished], Error>)
}
