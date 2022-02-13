import ComposableArchitecture

final class GameFactory {
    static func build(configuration: GameConfiguration = .standard, levelToPlay: Level, onFinished: (() -> Void)?) -> GameView {
        let store = buildStore(configuration: configuration, levelToPlay: levelToPlay)
        return GameView(store: store, onFinished: onFinished)
    }

    private static func buildStore(configuration: GameConfiguration, levelToPlay: Level) -> Store<GameState, GameAction> {
        let gameReducer = GameReducer(effects: GameEffects())
        let initialState = GameState(configuration: configuration, levelPlaying: levelToPlay)
        return Store(initialState: initialState,
                     reducer: gameReducer.reducer,
                     environment: GameEnvironment())
    }
}
