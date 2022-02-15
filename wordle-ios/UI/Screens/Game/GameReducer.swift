import ComposableArchitecture

final class GameReducer {
    private let effects: GameEffects
    
    init(effects: GameEffects) {
        self.effects = effects
    }
    
    lazy var reducer = Reducer<GameState, GameAction, GameEnvironment> { state, action, environment in
        switch action {
        case .checkLastWord:
            guard let currentWord = state.currentWord, currentWord.count == 5 else {
                state.gameToastInfo = .notFilledWordLength
                return .none
            }

            return self.effects.isWordContainedInList(word: currentWord)
        case .appendLetter(let letter):
            guard !state.gameEnded, (state.currentWord ?? "").count <= state.wordMaxLength - 1 else {
                state.gameToastInfo = .filledSpaces
                return .none
            }
            
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
            state.gameToastInfo = nil
            return .none
        case .dismissDialog:
            state.gameDialog = nil
            return .none
        case .storeLevelFinishedReceived:
            return .none
        case .isWordContainedInListReceived(let result):
            switch result {
            case .success(let isWordContained):
                guard let currentWord = state.currentWord else {
                    state.gameToastInfo = .notFilledWordLength
                    return .none
                }
                
                guard isWordContained else {
                    state.gameToastInfo = .wordDoesNotExist
                    return .none
                }
                
                state.triedWords.append(currentWord)
                state.currentWord = nil
                
                if currentWord == state.levelPlaying.word || state.triedWords.count == state.maximumTries {
                    state.gameEnded = true
                    state.gameDialog = currentWord == state.levelPlaying.word ? .finishedSuccessfully(currentWord) : .finishedNotWinning(currentWord)
                    return self.effects.storeFinished(level: state.levelPlaying, tries: state.triedWords.count, success: currentWord == state.levelPlaying.word)
                }
                
                if state.triedWords.count == state.maximumTries - 1 {
                    state.gameToastInfo = .lastChance
                }
                
                return self.effects.getFactForWord(word: currentWord)
            case .failure: return .none
            }
        case .factForWordReceived(let result):
            switch result {
            case .success(let fact):
                guard let fact = fact else { return .none }
                state.gameToastInfo = .funFact(fact)
            case .failure: break
            }
            
            return .none
        }
    }
}

final class GameEffects {
    private let storeFinishedLevelUseCase: StoreFinishedLevel.UseCase
    private let isWordContainedInListUseCase: IsWordContainedInList.UseCase
    private let getFactForWordUseCase: GetFactForWord.UseCase
    
    init(storeFinishedLevelUseCase: @escaping StoreFinishedLevel.UseCase = StoreFinishedLevel().execute,
         isWordContainedInListUseCase: @escaping IsWordContainedInList.UseCase = IsWordContainedInList().execute,
         getFactForWordUseCase: @escaping GetFactForWord.UseCase = GetFactForWord().execute) {
        self.storeFinishedLevelUseCase = storeFinishedLevelUseCase
        self.isWordContainedInListUseCase = isWordContainedInListUseCase
        self.getFactForWordUseCase = getFactForWordUseCase
    }
    
    func storeFinished(level: Level, tries: Int, success: Bool) -> Effect<GameAction, Never> {
        storeFinishedLevelUseCase(level, tries, success)
            .catchToEffect()
            .map(GameAction.storeLevelFinishedReceived)
    }
    
    func isWordContainedInList(word: String) -> Effect<GameAction, Never> {
        isWordContainedInListUseCase(word)
            .catchToEffect()
            .map(GameAction.isWordContainedInListReceived)
    }
    
    func getFactForWord(word: String) -> Effect<GameAction, Never> {
        getFactForWordUseCase(word)
            .catchToEffect()
            .map(GameAction.factForWordReceived)
    }
}
