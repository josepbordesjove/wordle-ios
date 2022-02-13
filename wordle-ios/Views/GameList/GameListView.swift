import ComposableArchitecture
import SwiftUI

struct GameListView: View {
    enum Constant {
        static let columns = [GridItem(.adaptive(minimum: 150))]
    }

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
                        LazyVGrid(columns: Constant.columns, spacing: 20) {
                            ForEach(viewStore.state.levels) { level in
                                HStack {
                                    ButtonNavigationView(buttonImage: .generic(level.name), destination: { GameFactory.build(levelToPlay: level, onFinished: nil) })
                                        .disabled(viewStore.state.isLevelSuccess(level) != .unknown)
                                        .opacity(viewStore.state.isLevelSuccess(level) != .unknown ? 0.6 : 1)
                                    Image(viewStore.state.isLevelSuccess(level).imageName)
                                        .resizable()
                                        .frame(width: 25, height: 25, alignment: .center)
                                        .scaledToFit()
                                    Spacer()
                                        .frame(width: 5, height: 5)
                                }
                            }
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
