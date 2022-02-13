import ComposableArchitecture
import SwiftUI

struct GameListView: View {
    @Environment(\.presentationMode) var presentationMode
    let store: Store<GameListState, GameListAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                BackgroundView(style: .sky)
                VStack {
                    HeaderView {
                        presentationMode.wrappedValue.dismiss()
                    }
                    ScrollView {
                        ForEach(viewStore.state.levels) { level in
                            ButtonNavigationView(buttonImage: .generic(level.name), destination: { GameFactory.build(correctWord: level.word) })
                        }
                        .padding(20)
                    }
                }
            }
            .onAppear {
                viewStore.send(.getLevels)
            }
        }
    }
}
