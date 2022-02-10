//
//  BoardView.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 9/2/22.
//

import SwiftUI

struct BoardView: View {
    @Binding var game: Game
    
    var body: some View {
        VStack {
            ForEach(0..<game.maximumTries) { row in
                HStack {
                    ForEach(0..<game.wordMaxLength) { column in
                        Button {
                            print("Column \(column) Row \(row) was tapped")
                        } label: {
                            Text(text(column: column, row: row))
                                .font(.custom("PalameciaTitling-Regular", size: 28))
                                .foregroundColor(.white)
                        }
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
        let box = game.box(for: .init(row: row, column: column))
        
        switch box {
        case.unknown: return ""
        case .correct(let letter), .incorrect(let letter), .contained(let letter): return letter
        }
    }
    
    func color(column: Int, row: Int) -> Color {
        let box = game.box(for: .init(row: row, column: column))
        
        switch box {
        case.unknown: return .gray
        case .correct: return .green
        case .incorrect: return .gray
        case .contained: return .yellow
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(game: .constant(Game(configuration: .standard, correctWord: "Holas", triedWords: ["oooeh"])))
            .previewLayout(PreviewLayout.fixed(width: 450, height: 450))
            .padding()
            .previewDisplayName("Default preview")
    }
}
