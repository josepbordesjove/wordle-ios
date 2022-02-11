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
        VStack {
            HStack {
                Button {
                    backButtonTapped()
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

//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView()
//    }
//}
