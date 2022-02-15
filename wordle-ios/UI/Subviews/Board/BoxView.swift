import SwiftUI

struct BoxView: View {
    let color: Color
    let text: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .frame(minWidth: 45, maxWidth: 60, minHeight: 45, maxHeight: 60)
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white, lineWidth: 2)
                )
            Text(text)
                .font(.custom("PalameciaTitling-Regular", size: 28))
                .foregroundColor(.white)
        }
    }
}
