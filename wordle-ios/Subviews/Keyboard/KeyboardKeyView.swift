//
//  KeyboardKeyView.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

import SwiftUI

struct KeyboardKeyView: View {
    let letter: Letter
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .frame(width: 30, height: 40)
            Text(letter.value)
                .font(.custom("PalameciaTitling-Regular", size: 18))
                .foregroundColor(.accentColor)
        }
    }
}


struct KeyboardKeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardKeyView(letter: .a)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
