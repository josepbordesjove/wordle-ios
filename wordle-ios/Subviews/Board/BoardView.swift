import SwiftUI

struct BoardView: View {
    var gameState: GameState
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<gameState.maximumTries) { row in
                HStack(spacing: 8) {
                    ForEach(0..<gameState.wordMaxLength) { column in
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(color(column: column, row: row))
                                .frame(minWidth: 35, maxWidth: calculateKeyWidthForBox(), minHeight: 35, maxHeight: calculateKeyWidthForBox())
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(4)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                            Text(text(column: column, row: row))
                                .font(.custom("PalameciaTitling-Regular", size: 28))
                                .foregroundColor(.white)
                        }
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
        case.unknown, .trying: return Color.box
        case .correct: return Color.boxCorrect
        case .incorrect: return Color.boxNotContained
        case .contained: return Color.boxContained
        }
    }
    
    private func calculateKeyWidthForBox() -> CGFloat {
        let maxBoxesPerRow = gameState.wordMaxLength + 1
        let boxWidth = (UIScreen.main.bounds.width - 40 - CGFloat(maxBoxesPerRow * 10)) / CGFloat(maxBoxesPerRow)
        return boxWidth * 1.2
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(gameState: .init(levelPlaying: .init(key: "", sortableKey: 1, name: "", word: "")))
            .padding()
            .previewDisplayName("Default preview")
    }
}
