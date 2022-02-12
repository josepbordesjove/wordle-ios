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
                BackgroundView(style: .sky)
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
                    ButtonView(buttonImage: .check, disabled: viewStore.state.gameEnded) {
                        withAnimation() {
                            viewStore.send(.checkLastWord)
                        }
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .padding(.bottom, 40)
                    .padding(.horizontal, 40)
                }
                if let error = viewStore.state.gameError {
                    ToastView(errorMessage: error.description) {
                        withAnimation() {
                            viewStore.send(.dismissToast)
                        }
                    }
                }
                if let dialog = viewStore.state.gameDialog {
                    ModalView(title: dialog.title, subtitle: dialog.subtitle, buttonTitle: dialog.buttonTitle) {
                        withAnimation() {
                            viewStore.send(.dismissDialog)
                        }
                    }
                }
            }
        }
    }
}
