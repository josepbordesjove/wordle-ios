import ComposableArchitecture

final class HomeFactory {
    static func build() -> HomeView {
        HomeView(store: buildStore())
    }

    private static func buildStore() -> Store<HomeState, HomeAction> {
        let effects = HomeEffects()
        let homeReducer = HomeReducer(effects: effects)
        return Store(initialState: HomeState(),
                     reducer: homeReducer.reducer,
                     environment: HomeEnvironment())
    }
}
