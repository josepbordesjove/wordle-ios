//
//  KeyboardView.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 9/2/22.
//

import SwiftUI
import AVFoundation

enum KeyboardAction {
    case added(Letter)
    case delete
}

struct KeyboardView: View {
    private enum Constant {
        static let keyTappedSoundId: UInt32 = 1123
        static let deleteTappedSoundId: UInt32 = 1155
    }
    
    var keyboardAction: (KeyboardAction) -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(CatalanKeyboardLines.allCases) { line in
                HStack(spacing: 4) {
                    ForEach(line.letters) { letter in
                        HStack {
                            Button {
                                AudioServicesPlaySystemSound(Constant.keyTappedSoundId)
                                keyboardAction(.added(letter))
                            } label: {
                                KeyboardKeyView(letter: letter)
                            }
                            if letter == line.letters.last && line == CatalanKeyboardLines.allCases.last {
                                ButtonView(buttonImage: .delete) {
                                    AudioServicesPlaySystemSound(Constant.deleteTappedSoundId)
                                    keyboardAction(.delete)
                                }
                                .frame(height: 40)
                            }
                        }
                    }
                }
            }
        }
        .padding(10)
    }
}
