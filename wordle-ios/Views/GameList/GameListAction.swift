//
//  GameListAction.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 13/2/22.
//

import Foundation

enum GameListAction {
    case getLevels
    case levelsReceived(Result<[Level], Error>)
    case getFinishedLevelsReceived(Result<[LevelFinished], Error>)
}
