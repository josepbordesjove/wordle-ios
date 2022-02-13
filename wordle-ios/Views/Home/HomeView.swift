import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: Store<HomeState, HomeAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                ZStack {
                    BackgroundView(style: .grass)
                    VStack {
                        Spacer()
                        HStack {
                            ButtonNavigationView(buttonImage: .play, destination: { GameFactory.build(correctWord: viewStore.state.nextWordChallenge) })
                                .padding(40)
                            ButtonNavigationView(buttonImage: .select, destination: { GameListFactory.build() })
                                .padding(40)
                        }
                        .padding(.bottom, 60)
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                viewStore.send(.updateNextWordChallenge)
            }
        }
    }
}
