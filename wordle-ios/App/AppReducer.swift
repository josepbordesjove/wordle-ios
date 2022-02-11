//
//  File.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 11/2/22.
//

import ComposableArchitecture

final class AppReduder {
    static let reducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
        return .none
    }
}
