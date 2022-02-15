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
                state.gameError = .notFilledWordLength
                return .none
            }

            return self.effects.isWordContainedInList(word: currentWord)
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
        case .storeLevelFinishedReceived:
            return .none
        case .isWordContainedInListReceived(let result):
            switch result {
            case .success(let isWordContained):
                guard let currentWord = state.currentWord else {
                    state.gameError = .notFilledWordLength
                    return .none
                }
                
                guard isWordContained else {
                    state.gameError = .wordDoesNotExist
                    return .none
                }
                
                state.triedWords.append(currentWord)
                state.currentWord = nil
                
                if currentWord == state.levelPlaying.word || state.triedWords.count == state.maximumTries {
                    state.gameEnded = true
                    state.gameDialog = currentWord == state.levelPlaying.word ? .finishedSuccessfully : .finishedNotWinning
                    return self.effects.storeFinished(level: state.levelPlaying, tries: state.triedWords.count, success: currentWord == state.levelPlaying.word)
                }
                
                return .none
            case .failure: return .none
            }
        }
    }
}

final class GameEffects {
    private let storeFinishedLevelUseCase: StoreFinishedLevel.UseCase
    private let isWordContainedInListUseCase: IsWordContainedInList.UseCase
    
    init(storeFinishedLevelUseCase: @escaping StoreFinishedLevel.UseCase = StoreFinishedLevel().execute,
         isWordContainedInListUseCase: @escaping IsWordContainedInList.UseCase = IsWordContainedInList().execute) {
        self.storeFinishedLevelUseCase = storeFinishedLevelUseCase
        self.isWordContainedInListUseCase = isWordContainedInListUseCase
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
}
