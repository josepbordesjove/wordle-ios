//
//  ScaleButtonStyle.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        if configuration.isPressed {
            UIImpactFeedbackGenerator().impactOccurred()
        }

        return configuration.label
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
    }
}
