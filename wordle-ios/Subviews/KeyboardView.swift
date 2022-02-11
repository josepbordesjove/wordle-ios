//
//  KeyboardView.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 9/2/22.
//

import SwiftUI

enum KeyboardAction {
    case added(Letter)
    case delete
}

struct KeyboardView: View {
    var keyboardAction: (KeyboardAction) -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(CatalanKeyboardLines.allCases) { line in
                HStack(spacing: 4) {
                    ForEach(line.letters) { letter in
                        HStack {
                            Button {
                                keyboardAction(.added(letter))
                            } label: {
                                Text(letter.value)
                                    .font(.custom("PalameciaTitling-Regular", size: 16))
                                    .foregroundColor(.accentColor)
                            }
                            .frame(width: 30, height: 40)
                            .cornerRadius(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .background(Color.white)
                            if letter == line.letters.last && line == CatalanKeyboardLines.allCases.last {
                                Button {
                                    keyboardAction(.delete)
                                } label: {
                                    Image("delete_btn")
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(10)
    }
}
