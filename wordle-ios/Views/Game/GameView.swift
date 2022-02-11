//
//  GameView.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 8/2/22.
//

import SwiftUI
import ComposableArchitecture

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    let store: Store<GameState, GameAction>
    
    init(configuration: GameConfiguration = .standard, correctWord: String) {
        self.store = Store(initialState: GameState(configuration: configuration, correctWord: correctWord),
                          reducer: GameReducer.reducer,
                          environment: GameEnvironment())
    }
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Image("background-2")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    HeaderView {
                        viewStore.send(.backButtonTapped)
                        presentationMode.wrappedValue.dismiss()
                    }
                    BoardView(gameState: viewStore.state)
                    Spacer()
                    KeyboardView { action in
                        switch action {
                        case .added(let letter): viewStore.send(.appendLetter(letter))
                        case .delete: viewStore.send(.deleteLastLetter)
                        }
                    }
                    Button {
                        viewStore.send(.checkLastWord)
                    } label: {
                        Image("check_btn")
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .padding(.bottom, 40)
                }
            }
        }
    }
}
