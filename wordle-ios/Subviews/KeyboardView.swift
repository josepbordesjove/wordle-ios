//
//  KeyboardView.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 9/2/22.
//

import SwiftUI

struct KeyboardView: View {
    var body: some View {
        VStack(spacing: 15) {
            ForEach(CatalanKeyboardLines.allCases) { line in
                HStack(spacing: 4) {
                    ForEach(line.letters) { letter in
                        HStack {
                            Button {
                                print("Letter \(letter.value) was tapped")
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
                                    print("Check button was tapped")
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

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
            .previewLayout(PreviewLayout.fixed(width: 400, height: 400))
            .padding()
            .previewDisplayName("Default preview")
    }
}
