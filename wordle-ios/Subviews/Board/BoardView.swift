//
//  BoardView.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 9/2/22.
//

import SwiftUI

struct BoardView: View {
    var gameState: GameState
    
    var body: some View {
        VStack {
            ForEach(0..<gameState.maximumTries) { row in
                HStack {
                    ForEach(0..<gameState.wordMaxLength) { column in
                        Text(text(column: column, row: row))
                            .font(.custom("PalameciaTitling-Regular", size: 28))
                            .foregroundColor(.white)
                        .frame(width: 55, height: 55)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .background(color(column: column, row: row))
                    }
                }
            }
        }
    }
    
    func text(column: Int, row: Int) -> String {
        let box = gameState.box(for: .init(row: row, column: column))
        
        switch box {
        case.unknown: return ""
        case .correct(let letter), .incorrect(let letter), .contained(let letter), .trying(let letter): return letter
        }
    }
    
    func color(column: Int, row: Int) -> Color {
        let box = gameState.box(for: .init(row: row, column: column))
        
        switch box {
        case.unknown: return Color.box
        case .correct: return Color.boxCorrect
        case .incorrect, .trying: return Color.box
        case .contained: return Color.boxContained
        }
    }
}
