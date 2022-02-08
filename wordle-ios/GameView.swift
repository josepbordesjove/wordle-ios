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
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("back_btn")
                    }
                    .frame(width: 50, height: 50, alignment: .leading)
                    .buttonStyle(ScaleButtonStyle())
                    Spacer()
                    Image("logo-img")
                    Spacer()
                    Spacer()
                        .frame(width: 50, height: 50, alignment: .trailing)
                }
                .padding(.top, 50)
                .padding(.trailing, 20)
                .padding(.leading, 20)
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
