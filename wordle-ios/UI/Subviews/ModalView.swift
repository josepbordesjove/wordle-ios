//
//  ModalView.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

import SwiftUI

struct ModalView: View {
    let title: String
    let subtitle: String
    let extraInformation: String?
    let buttonTitle: String
    var onDismiss: (() -> Void)?
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .opacity(0.6)
            VStack {
                ZStack {
                    Image("dialog_bg")
                        .resizable()
                        .clipped()
                        .frame(maxHeight: 80)
                    Text(title)
                        .font(.custom("PalameciaTitling-Regular", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                }
                Text(subtitle)
                    .font(.custom("PalameciaTitling-Regular", size: 16))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.accentColor)
                    .padding(15)
                if let extraInformation = extraInformation {
                    Text(extraInformation)
                        .font(.custom("PalameciaTitling-Regular", size: 16))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.accentColor)
                        .padding(15)
                }
                Spacer()
                ButtonView(buttonImage: .generic(buttonTitle)) {
                    onDismiss?()
                }
                .padding(15)
            }
            .background(Color.white)
            .fixedSize(horizontal: false, vertical: true)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding(.horizontal, 40)
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(title: "Sembla que has guanyat!",
                  subtitle: "Moltes felicitats, continua així fill o filla, triunfaràs!",
                  extraInformation: "La paraula correcta era Brida...",
                  buttonTitle: "Acceptar")
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
