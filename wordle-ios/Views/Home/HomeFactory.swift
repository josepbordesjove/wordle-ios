import ComposableArchitecture

final class HomeFactory {
    static func build(nextWordChallenge: String) -> HomeView {
        HomeView(store: buildStore(nextWordChallenge: nextWordChallenge))
    }

    private static func buildStore(nextWordChallenge: String) -> Store<HomeState, HomeAction> {
        let effects = HomeEffects()
        let homeReducer = HomeReducer(effects: effects)
        return Store(initialState: HomeState(nextWordChallenge: nextWordChallenge),
                     reducer: homeReducer.reducer,
                     environment: HomeEnvironment())
    }
}
