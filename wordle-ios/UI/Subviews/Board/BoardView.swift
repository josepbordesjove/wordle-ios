import SwiftUI

struct BoardView: View {
    var gameState: GameState
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<gameState.maximumTries) { row in
                HStack(spacing: 8) {
                    ForEach(0..<gameState.wordMaxLength) { column in
                        BoxView(color: color(column: column, row: row),
                                text: text(column: column, row: row))
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
        case .unknown, .trying: return Color.box
        case .correct: return Color.boxCorrect
        case .incorrect: return Color.boxNotContained
        case .contained: return Color.boxContained
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(gameState: .init(levelPlaying: .init(key: "", sortableKey: 1, name: "", word: "")))
            .padding()
            .previewDisplayName("Default preview")
    }
}
