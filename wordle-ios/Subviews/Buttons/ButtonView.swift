//
//  ButtonView.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

import SwiftUI

struct ButtonView: View {
    let buttonImage: ButtonImage
    let buttonAction: (() -> Void)?
    
    init(buttonImage: ButtonImage, buttonAction: (() -> Void)? = nil) {
        self.buttonImage = buttonImage
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        Button {
            buttonAction?()
        } label: {
            Image(buttonImage.rawValue)
                .resizable()
                .scaledToFit()
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(buttonImage: .delete)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
