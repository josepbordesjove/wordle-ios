import ComposableArchitecture
import Combine

final class GameListReducer {
    let effects: GameListEffects

    init(effects: GameListEffects) {
        self.effects = effects
    }
    
    lazy var reducer = Reducer<GameListState, GameListAction, GameListEnvironment> { state, action, environment in
        switch action {
        case .getLevels:
            return self.effects.getLevels()
        case .levelsReceived(let result):
            switch result {
            case .success(let levels): state.levels = levels
            case .failure: break
            }
            return .none
        }
    }
}

final class GameListEffects {
    private let getLevelsUseCase: GetLevels.UseCase

    init(getLevelsUseCase: @escaping GetLevels.UseCase = GetLevels().execute) {
        self.getLevelsUseCase = getLevelsUseCase
    }

    func getLevels() -> Effect<GameListAction, Never> {
        return getLevelsUseCase()
            .catchToEffect()
            .map(GameListAction.levelsReceived)
    }
}
