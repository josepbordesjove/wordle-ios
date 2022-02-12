//
//  GameReducer.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 11/2/22.
//

import ComposableArchitecture

final class GameReducer {
    static let reducer = Reducer<GameState, GameAction, GameEnvironment> { state, action, environment in
        switch action {
        case .checkLastWord:
            guard let currentWord = state.currentWord, currentWord.count == 5 else {
                state.gameError = .notFilledWordLength
                return .none
            }
            
            guard WordsFiveLetterList.all.contains(currentWord) else {
                state.gameError = .wordDoesNotExist
                return .none
            }
            
            state.triedWords.append(currentWord)
            state.currentWord = nil
            
            if currentWord == state.correctWord || state.triedWords.count == state.maximumTries {
                state.gameEnded = true
                state.gameDialog = currentWord == state.correctWord ? .finishedSuccessfully : .finishedNotWinning
            }

            return .none
        case .appendLetter(let letter):
            guard !state.gameEnded, (state.currentWord ?? "").count <= state.wordMaxLength - 1 else { return .none }
            if state.currentWord == nil {
                state.currentWord = letter.value
            } else {
                state.currentWord?.append(letter.value)
            }
            
            return .none
        case .deleteLastLetter:
            guard !state.gameEnded else { return .none }
            _ = state.currentWord?.popLast()
            return .none
        case .backButtonTapped:
            state.currentWord = nil
            return .none
        case .dismissToast:
            state.gameError = nil
            return .none
        case .dismissDialog:
            state.gameDialog = nil
            return .none
        }
    }
}
