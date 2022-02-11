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
                // TODO: Handle error
                print("The word is not finished")
                return .none
            }
            
            guard WordsFiveLetterList.all.contains(currentWord) else {
                // TODO: Handle error
                print("The word is not contained in the list")
                return .none
            }
            
            state.triedWords.append(currentWord)
            state.currentWord = nil
            return .none
        case .appendLetter(let letter):
            guard (state.currentWord ?? "").count <= state.wordMaxLength - 1 else { return .none }
            if state.currentWord == nil {
                state.currentWord = letter.value
            } else {
                state.currentWord?.append(letter.value)
            }
            
            return .none
        case .deleteLastLetter:
            _ = state.currentWord?.popLast()
            return .none
        case .backButtonTapped:
            state.currentWord = nil
            return .none
        }
    }
}
