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
            return .concatenate(self.effects.getLevels(), self.effects.getFinishedLevels())
        case .levelsReceived(let result):
            switch result {
            case .success(let levels): state.levels = levels
            case .failure: break
            }
            return .none
        case .getFinishedLevelsReceived(let result):
            switch result {
            case .success(let finishedLevels): state.finishedLevels = finishedLevels
            case .failure: break
            }
            return .none
        }
    }
}

final class GameListEffects {
    private let getLevelsUseCase: GetLevels.UseCase
    private let getFinishedLevelsUseCase: GetFinishedLevels.UseCase

    init(getLevelsUseCase: @escaping GetLevels.UseCase = GetLevels().execute,
         getFinishedLevelsUseCase: @escaping GetFinishedLevels.UseCase = GetFinishedLevels().execute) {
        self.getLevelsUseCase = getLevelsUseCase
        self.getFinishedLevelsUseCase = getFinishedLevelsUseCase
    }

    func getLevels() -> Effect<GameListAction, Never> {
        getLevelsUseCase()
            .catchToEffect()
            .map(GameListAction.levelsReceived)
    }
    
    func getFinishedLevels() -> Effect<GameListAction, Never> {
        getFinishedLevelsUseCase()
            .catchToEffect()
            .map(GameListAction.getFinishedLevelsReceived)
    }
}
