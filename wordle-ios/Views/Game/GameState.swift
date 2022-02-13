import Foundation

enum GameStateError: Error {
    case notFilledWordLength
    case wordDoesNotExist
    
    var description: String {
        switch self {
        case .notFilledWordLength:
            return "La paraula introduïda no te la llargada suficient"
        case .wordDoesNotExist:
            return "La paraula introduïda no existeix"
        }
    }
}

enum GameStateDialog {
    case finishedSuccessfully
    case finishedNotWinning
    
    var title: String {
        switch self {
        case .finishedSuccessfully: return "Has guanyat la partida!"
        case .finishedNotWinning: return "No passa res..."
        }
    }
    
    var subtitle: String {
        switch self {
        case .finishedSuccessfully: return "Vas pel bon camí jove aprenent, el català no te frens amb tu."
        case .finishedNotWinning: return "Continua així. Pompeu Fabra no ho va aprendre tot amb un dia."
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .finishedSuccessfully: return "D'acord!"
        case .finishedNotWinning: return "Quina pena..."
        }
    }
}

struct GameState: Equatable {
    let wordMaxLength: Int
    let maximumTries: Int
    let levelPlaying: Level

    var currentWord: String? = nil
    var triedWords: [String] = []
    var gameEnded: Bool = false
    
    var gameError: GameStateError? = nil
    var gameDialog: GameStateDialog? = nil
    
    init(configuration: GameConfiguration = .standard, levelPlaying: Level) {
        self.wordMaxLength = configuration.columns
        self.maximumTries = configuration.rows
        self.levelPlaying = levelPlaying
    }
    
    func box(for position: BoxPosition) -> Box {
        guard position.row < triedWords.count else {
            if position.row == triedWords.count {
                let tryingWord = currentWord ?? ""
                return .trying(tryingWord[position.column])
            }

            return .unknown
        }
        
        let correctWord = levelPlaying.word
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
