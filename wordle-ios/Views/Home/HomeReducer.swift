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
            return .none
        case .ordersReceived(let results):
            print("Something happened")
            return .none
        }
    }
}

final class HomeEffects {
//    let store: OrderCombineStoreProtocol
//
//    init(store: OrderCombineStoreProtocol) {
//        self.store = store
//    }
//
//    func fetch() -> Effect<HomeAction, Never> {
//        return store.getTodayOrdersSummary()
//            .catchToEffect()
//            .map(HomeAction.ordersReceived)
//
//    }
}
