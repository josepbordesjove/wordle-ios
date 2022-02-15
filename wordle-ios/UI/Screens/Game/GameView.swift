import SwiftUI
import ComposableArchitecture

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    let store: Store<GameState, GameAction>
    var onFinished: (() -> Void)?
    
    var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    BackgroundView(style: .sky)
                    VStack(spacing: 0) {
                        HeaderView {
                            viewStore.send(.backButtonTapped)
                            presentationMode.wrappedValue.dismiss()
                        }
                        .padding(.bottom, 10)
                        VStack {
                            Text(viewStore.levelPlaying.name)
                                .font(.custom("PalameciaTitling-Regular", size: 22))
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                            Spacer()
                            BoardView(gameState: viewStore.state)
                            Spacer()
                        }
                        KeyboardView(gameState: viewStore.state) { action in
                            switch action {
                            case .added(let letter): viewStore.send(.appendLetter(letter))
                            case .delete: viewStore.send(.deleteLastLetter)
                            }
                        }
                        Spacer()
                            .frame(minHeight: 5, maxHeight: 10)
                        ButtonView(buttonImage: .check, disabled: viewStore.state.gameEnded) {
                            withAnimation() {
                                viewStore.send(.checkLastWord)
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height * 0.075)
                        .padding(.horizontal, 40)
                        Spacer()
                    }
                    if let error = viewStore.state.gameToastInfo {
                        ToastView(errorMessage: error.description, icon: error.toastIcon) {
                            withAnimation() {
                                viewStore.send(.dismissToast)
                            }
                        }
                    }
                    if let dialog = viewStore.state.gameDialog {
                        ModalView(title: dialog.title, subtitle: dialog.subtitle, buttonTitle: dialog.buttonTitle) {
                            withAnimation() {
                                self.onFinished?()
                                viewStore.send(.dismissDialog)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
