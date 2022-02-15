import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: Store<HomeState, HomeAction>
    
    var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                    BackgroundView(style: .grass)
                    VStack {
                        Spacer()
                        HStack {
                            if let nextLevel = viewStore.state.nextLevel {
                                ButtonNavigationView(buttonImage: .play, destination: { GameFactory.build(levelToPlay: nextLevel, onFinished: { viewStore.send(.updateNextWordChallenge) }) })
                                    .padding(40)
                            }
                            ButtonNavigationView(buttonImage: .select, destination: { GameListFactory.build() })
                                .padding(40)
                        }
                        .padding(.bottom, 60)
                    }
                }
                .onAppear {
                    viewStore.send(.updateNextWordChallenge)
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
    }
}
