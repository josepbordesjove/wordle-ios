//
//  GameView.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 8/2/22.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Image("background-2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                HeaderView(presentationMode: presentationMode)
                KeyboardView()
                Button {
                    print("Check button was tapped")
                } label: {
                    Image("check_btn")
                }
                .buttonStyle(ScaleButtonStyle())
                .padding(.bottom, 40)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
