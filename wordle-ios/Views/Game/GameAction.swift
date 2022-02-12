//
//  GameActions.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 11/2/22.
//

import Foundation

enum GameAction: Equatable {
    case checkLastWord
    case deleteLastLetter
    case appendLetter(Letter)
    case backButtonTapped
    case dismissToast
    case dismissDialog
}
