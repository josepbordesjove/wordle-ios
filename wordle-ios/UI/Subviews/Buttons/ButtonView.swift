//
//  ButtonView.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

import SwiftUI
import ComposableArchitecture

struct ButtonView: View {
    let buttonImage: ButtonImage
    @BindableState private var disabled: Bool
    let buttonAction: (() -> Void)?
    
    init(buttonImage: ButtonImage, disabled: Bool = false, buttonAction: (() -> Void)? = nil) {
        self.buttonImage = buttonImage
        self.disabled = disabled
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        Button {
            buttonAction?()
        } label: {
            switch buttonImage {
            case .generic(let string):
                ZStack {
                    Image(buttonImage.imageName)
                        .resizable()
                        .frame(height: 55)
                        .scaledToFit()
                    Text(string)
                        .font(.custom("PalameciaTitling-Regular", size: 24))
                        .foregroundColor(.white)
                }
            default:
                Image(buttonImage.imageName)
                    .resizable()
                    .scaledToFit()
            }
        }
        .opacity(disabled ? 0.7 : 1)
        .disabled(disabled)
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(buttonImage: .delete)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
        
        ButtonView(buttonImage: .generic("Acceptar"))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
