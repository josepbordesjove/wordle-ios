//
//  GameListState.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 13/2/22.
//

import Foundation

struct GameListState: Equatable {
    var levels: [Level] = []
    var finishedLevels: [LevelFinished] = []
    
    func isLevelSuccess(_ level: Level) -> GameCompletedStatus {
        guard let finishedLevel = (finishedLevels.filter { $0.levelId == level.id }).first else {
            return .unknown
        }
        
        return finishedLevel.success ? .successful : .unSuccessful
    }
}
