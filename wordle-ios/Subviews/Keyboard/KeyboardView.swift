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
        static let keyboardHorizontalPadding: CGFloat = 10
    }
    
    var gameState: GameState
    var keyboardAction: (KeyboardAction) -> Void
    private let keyboard = CatalanKeyboardLines.allCases
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            ForEach(keyboard) { line in
                HStack(spacing: 4) {
                    ForEach(line.letters) { letter in
                        HStack {
                            Button {
                                AudioServicesPlaySystemSound(Constant.keyTappedSoundId)
                                keyboardAction(.added(letter))
                            } label: {
                                KeyboardKeyView(gameState: gameState, letter: letter, width: calculateKeyWidthForKeyboard())
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
    }
    
    private func calculateKeyWidthForKeyboard() -> CGFloat {
        let maxKeysPerRow = keyboard.sorted { $0.letters.count > $1.letters.count }.first!.letters.count + 1
        let keyWidth = (UIScreen.main.bounds.width - Constant.keyboardHorizontalPadding * 2 - CGFloat(maxKeysPerRow * 4)) / CGFloat(maxKeysPerRow)
        return keyWidth
    }
}
