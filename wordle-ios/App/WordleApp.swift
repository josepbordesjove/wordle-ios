//
//  wordle_iosApp.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 8/2/22.
//

import SwiftUI
import ComposableArchitecture

@main
struct WordleApp: App {
    let persistenceController = PersistenceController.shared
    let store: Store<AppState, AppAction> = Store(initialState: AppState(),
                                                  reducer: AppReduder.reducer,
                                                  environment: AppEnvironment())

    var body: some Scene {
        WindowGroup {
            HomeView(store: store)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
