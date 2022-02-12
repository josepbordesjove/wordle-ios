//
//  GameListView.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

import SwiftUI

struct GameListView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            BackgroundView(style: .sky)
            VStack {
                HeaderView {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}
