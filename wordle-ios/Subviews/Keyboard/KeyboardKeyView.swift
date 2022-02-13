//
//  KeyboardKeyView.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

import SwiftUI

struct KeyboardKeyView: View {
    var gameState: GameState
    let letter: Letter
    let width: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(color(letter: letter))
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .frame(width: width, height: width * 1.33, alignment: .center)
            Text(letter.value)
                .font(.custom("PalameciaTitling-Regular", size: 18))
                .foregroundColor(.accentColor)
        }
    }
    
    func color(letter: Letter) -> Color {
        let status = gameState.letterKeyboardStatus(for: letter)
        
        switch status {
        case .matched: return Color.boxCorrect
        case .contained: return Color.boxContained
        case .notContained: return Color.box
        case .unKnown: return Color.white
        }
    }
}


struct KeyboardKeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardKeyView(gameState: .init(levelPlaying: .init(key: "",
                                                             sortableKey: 1,
                                                             name: "",
                                                             word: "")),
                        letter: .a,
                        width: 30)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
