import Foundation

enum GameStateToastInfo: Equatable, Error {
    case notFilledWordLength
    case wordDoesNotExist
    case filledSpaces
    case funFact(FunFact)
    case lastChance
    
    var description: String {
        switch self {
        case .notFilledWordLength:
            return "La paraula introduïda no te la llargada suficient"
        case .wordDoesNotExist:
            return "La paraula introduïda no existeix"
        case .filledSpaces:
            return "Has de borrar abans d'intoduïr més caràcters"
        case .funFact(let fact):
            return fact.description
        case .lastChance:
            return "Només et queda una oportunitat, te'n sortiràs?"
        }
    }
    
    var toastIcon: ToastViewIcon {
        switch self {
        case .notFilledWordLength, .wordDoesNotExist, .filledSpaces: return .incorrect
        case .funFact, .lastChance: return .informative
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
    var containedLetters: [Letter: LetterKeyboardStatus] = [:]
    
    var gameToastInfo: GameStateToastInfo? = nil
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
            let isContained = lettersCountInSubstring <= lettersCountInOriginalWord && correctLettersCount < lettersCountInWord
            
            return isContained ? .contained(letter) : .incorrect(letter)
        }

        return .incorrect(letter)
    }
    
    func letterKeyboardStatus(for letter: Letter) -> LetterKeyboardStatus {
        guard triedWords.count > 0 else { return .unKnown }

        let correctWordsLetters = levelPlaying.word.map { Letter(rawValue: String($0)) }
        var containedLetters: [Letter: LetterKeyboardStatus] = [:]
        
        triedWords.forEach { triedWord in
            let triedWordLetters = triedWord.map { Letter(rawValue: String($0)) }
            
            for i in 0..<correctWordsLetters.count {
                if correctWordsLetters[i] == triedWordLetters[i] && triedWordLetters[i] == letter {
                    containedLetters[letter] = .matched
                }
            }
            
            if correctWordsLetters.contains(letter) && triedWordLetters.contains(letter) && containedLetters[letter] != .matched {
                containedLetters[letter] = .contained
            } else if triedWordLetters.contains(letter) && containedLetters[letter] != .contained && containedLetters[letter] != .matched {
                containedLetters[letter] = .notContained
            }
        }
        
        return containedLetters[letter] ?? .unKnown
    }
}
