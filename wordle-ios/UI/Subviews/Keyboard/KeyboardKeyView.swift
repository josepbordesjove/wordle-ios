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
    private let status: LetterKeyboardStatus
    
    init(gameState: GameState, letter: Letter, width: CGFloat) {
        self.gameState = gameState
        self.letter = letter
        self.width = width
        status = gameState.letterKeyboardStatus(for: letter)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(backgroundColor())
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(borderColor(), lineWidth: 2)
                )
                .frame(width: width, height: width * 1.33, alignment: .center)
            Text(letter.value)
                .font(.custom("PalameciaTitling-Regular", size: 18))
                .foregroundColor(textColor())
        }
    }
    
    func backgroundColor() -> Color {
        switch status {
        case .matched: return Color.keyboardCorrect
        case .contained: return Color.keyboardContained
        case .notContained: return Color.box
        case .unKnown: return Color.white
        }
    }
    
    func borderColor() -> Color {
        switch status {
        case .matched: return Color.gray
        case .contained: return Color.gray
        case .notContained: return Color.gray
        case .unKnown: return Color.gray
        }
    }
    
    func textColor() -> Color {
        switch status {
        case .matched: return Color.accentColor
        case .contained: return Color.accentColor
        case .notContained: return Color.accentColor
        case .unKnown: return Color.accentColor
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
