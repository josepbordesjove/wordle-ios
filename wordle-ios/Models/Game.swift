//
//  Game.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 10/2/22.
//

import Foundation

struct Game {
    struct BoxPosition {
        let row: Int
        let column: Int
    }
    
    let wordMaxLength: Int
    let correctWord: String
    let maximumTries: Int

    var currentWord: String?
    var triedWords: [String]

    
    init(configuration: GameConfiguration = .standard, correctWord: String, triedWords: [String] = []) {
        self.wordMaxLength = configuration.columns
        self.correctWord = correctWord
        self.maximumTries = configuration.rows
        self.triedWords = triedWords
        self.currentWord = nil
    }
    
    func box(for position: BoxPosition) -> Box {
        guard position.row < triedWords.count else {
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
