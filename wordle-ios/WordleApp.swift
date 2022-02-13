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

    // TODO: Fetch properly the next word, should be a level instead of a word btw
    var body: some Scene {
        WindowGroup {
            HomeFactory.build(nextWordChallenge: "tarda")
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
