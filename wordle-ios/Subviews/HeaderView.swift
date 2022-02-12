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
            .frame(width: 50, height: 50, alignment: .leading)
            .buttonStyle(ScaleButtonStyle())
            Spacer()
            Image("logo_img")
            Spacer()
            Spacer()
                .frame(width: 50, height: 50, alignment: .trailing)
        }
        .padding(.top, 50)
        .padding(.bottom, 10)
        .padding(.horizontal, 20)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView()
//    }
//}
