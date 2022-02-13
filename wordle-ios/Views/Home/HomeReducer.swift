import ComposableArchitecture
import Combine

final class HomeReducer {
    private let effects: HomeEffects

    init(effects: HomeEffects) {
        self.effects = effects
    }
    
    lazy var reducer = Reducer<HomeState, HomeAction, HomeEnvironment> { state, action, environment in
        switch action {
        case .updateNextWordChallenge:
            return self.effects.getNextLevel()
        case .nextLevelReceived(let result):
            switch result {
            case .success(let nextLevel): state.nextLevel = nextLevel
            case .failure: break
            }
            return .none
        }
    }
}

final class HomeEffects {
    private let getNextLevelUseCase: GetNextLevel.UseCase

    init(getNextLevelUseCase: @escaping GetNextLevel.UseCase = GetNextLevel().execute) {
        self.getNextLevelUseCase = getNextLevelUseCase
    }

    func getNextLevel() -> Effect<HomeAction, Never> {
        return getNextLevelUseCase()
            .catchToEffect()
            .map(HomeAction.nextLevelReceived)
    }
}
