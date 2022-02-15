import SwiftUI

struct WordExample {
    let word: String
    let description: String
    let boxForLetter: [String: Box]
}

struct HowToView: View {
    enum Constant {
        static let instructions = [
            "Endevina la paraula amb 6 intents",
            "Has d'introduir paraules de 5 lletres que existeixen i fer clic a ENTER.",
            "Després de cada intent, el color de les lletres canviarà. Si la lletra està a la posició correcta canviarà a verd, en canvi, si la lletra està continguda a la paraula però no està a la posició correcta, sortirà de color groc.",
            "No es tenen en compte els accents a l'hora d'introduïr les paraules.",
            "Les lletres es poden repetir."
        ]
        
        static let examples: [WordExample] = [
            .init(word: "broma",
                  description: "La lletra \"B\" es troba en el lloc correcte de la paraula.",
                  boxForLetter: ["b": .correct("b")]),
            .init(word: "pesca",
                  description: "La paraula té la lletra \"C\" però en un altre lloc.",
                  boxForLetter: ["c": .contained("c")]),
            .init(word: "cacau",
                  description: "La paraula no conté les lletres \"C\", \"A\", \"C\", \"U\".",
                  boxForLetter: [:])
        ]
    }

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                BackgroundView(style: .sky)
                VStack(spacing: 0) {
                    HeaderView {
                        Spacer()
                    } backButtonTapped: {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.bottom, 10)
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(Constant.instructions, id: \.self) { instruction in
                                Text(instruction)
                                    .font(.custom("PalameciaTitling-Regular", size: 18))
                                    .minimumScaleFactor(0.01)
                                    .foregroundColor(.white)
                            }
                            ForEach(Constant.examples, id: \.word) { example in
                                VStack(alignment: .leading) {
                                    HStack {
                                        ForEach(Array(example.word), id: \.self) { character in
                                            BoxView(color: color(for: example, char: "\(character)"),
                                                    text: "\(character)")
                                        }
                                    }
                                    .frame(maxWidth: 300)
                                    Text(example.description)
                                        .font(.custom("PalameciaTitling-Regular", size: 18))
                                        .minimumScaleFactor(0.01)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(20)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    // MARK: Helpers
    
    private func color(for example: WordExample, char: String) -> Color {
        guard let box = example.boxForLetter[char] else { return .box }
        
        switch box {
        case .unknown, .trying: return Color.box
        case .correct: return Color.boxCorrect
        case .incorrect: return Color.boxNotContained
        case .contained: return Color.boxContained
        }
    }
}
