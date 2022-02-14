import ComposableArchitecture

final class GameListFactory {
    static func build() -> GameListView {
        let store = buildStore()
        return GameListView(store: store)
    }

    private static func buildStore() -> Store<GameListState, GameListAction> {
        let effects = GameListEffects()
        let gameListReducer = GameListReducer(effects: effects)
        return Store(initialState: GameListState(),
                     reducer: gameListReducer.reducer,
                     environment: GameListEnvironment())
    }
}
