//
//  ButtonNavigationView.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

import SwiftUI

struct ButtonNavigationView<Content: View>: View {
    let buttonImage: ButtonImage
    @ViewBuilder var destination: Content

    var body: some View {
        NavigationLink(destination: destination) {
            Image(buttonImage.rawValue)
                .resizable()
                .scaledToFit()
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
