//
//  HeaderView.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 9/2/22.
//

import SwiftUI

struct HeaderView: View {
    var backButtonTapped: () -> Void
    
    var body: some View {
        HStack {
            ButtonView(buttonImage: .back) {
                backButtonTapped()
            }
            .frame(width: 45, height: 45, alignment: .leading)
            .buttonStyle(ScaleButtonStyle())
            Spacer()
            Image("logo_img")
                .resizable()
                .scaledToFit()
                .frame(height: UIScreen.main.bounds.height * 0.05)
                .padding(.vertical, 5)
            Spacer()
            Spacer()
                .frame(width: 45, height: 45, alignment: .trailing)
        }
        .padding(.horizontal, 20)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
