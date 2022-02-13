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
    var body: some Scene {
        WindowGroup {
            HomeFactory.build()
        }
    }
}
