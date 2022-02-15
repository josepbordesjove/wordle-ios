import Foundation

struct GameListState: Equatable {
    var levels: [Level] = []
    var finishedLevels: [LevelFinished] = []
    
    var percentageCompleted: Int {
        guard levels.count > 0 else { return 0 }
        return Int((Double(finishedLevels.count) / Double(levels.count)) * 100)
    }
    
    var points: Int {
        finishedLevels.reduce(0) { result, level in
            let levelPoints = level.success ? 6 - level.tries : 0
            return result + levelPoints
        }
    }
    
    func isLevelSuccess(_ level: Level) -> GameCompletedStatus {
        guard let finishedLevel = (finishedLevels.filter { $0.levelId == level.id }).first else {
            return .unknown
        }
        
        return finishedLevel.success ? .successful : .unSuccessful
    }
}
