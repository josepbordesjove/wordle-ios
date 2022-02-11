//
//  GameState.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 11/2/22.
//

import Foundation

struct GameState: Equatable {
    let wordMaxLength: Int
    let maximumTries: Int
    let correctWord: String

    var currentWord: String? = nil
    var triedWords: [String] = []
    
    init(configuration: GameConfiguration = .standard, correctWord: String) {
        self.wordMaxLength = configuration.columns
        self.maximumTries = configuration.rows
        self.correctWord = correctWord
    }
    
    func box(for position: BoxPosition) -> Box {
        guard position.row < triedWords.count else {
            if position.row == triedWords.count {
                let tryingWord = currentWord ?? ""
                return .trying(tryingWord[position.column])
            }

            return .unknown
        }
        
        let word = triedWords[position.row]
        let letter = word[position.column]
        
        if letter == correctWord[position.column] {
            return .correct(letter)
        } else if correctWord.contains(letter) {
            let correctLettersCount = (0..<correctWord.count).filter ({ word[$0] == correctWord[$0] && String(word[$0]) == letter }).count
            let lettersCountInWord = correctWord.filter({ String($0) == letter }).count
            
            let substring = word.substring(toIndex: position.column + 1)
            let lettersCountInSubstring = substring.filter({ String($0) == letter }).count
            let lettersCountInOriginalWord = correctWord.filter({ String($0) == letter }).count
            
            return lettersCountInSubstring <= lettersCountInOriginalWord && correctLettersCount < lettersCountInWord ? .contained(letter) : .incorrect(letter)
        }

        return .incorrect(letter)
    }
}
