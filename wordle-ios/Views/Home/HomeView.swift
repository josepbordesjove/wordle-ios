//
//  ContentView.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 8/2/22.
//

import SwiftUI
import CoreData
import ComposableArchitecture

struct HomeView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView(style: .grass)
                VStack {
                    Spacer()
                    HStack {
                        ButtonNavigationView(buttonImage: .play, destination: { GameView(correctWord: WordsFiveLetterList.all.randomElement() ?? "aaaaa") })
                            .padding(40)
                        ButtonNavigationView(buttonImage: .select, destination: { GameListView() })
                            .padding(40)
                    }
                    .padding(.bottom, 60)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
