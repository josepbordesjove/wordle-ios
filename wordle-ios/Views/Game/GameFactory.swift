import ComposableArchitecture

final class GameFactory {
    static func build(configuration: GameConfiguration = .standard, correctWord: String) -> GameView {
        let store = buildStore(configuration: configuration, correctWord: correctWord)
        return GameView(store: store)
    }

    private static func buildStore(configuration: GameConfiguration, correctWord: String) -> Store<GameState, GameAction> {
        let gameReducer = GameReducer(effects: GameEffects())
        return Store(initialState: GameState(configuration: configuration, correctWord: correctWord),
                     reducer: gameReducer.reducer,
                     environment: GameEnvironment())
    }
}
