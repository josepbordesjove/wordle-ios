import SwiftUI

struct ButtonNavigationView<Content: View>: View {
    let buttonImage: ButtonImage
    @ViewBuilder var destination: Content

    var body: some View {
        NavigationLink(destination: destination) {
            switch buttonImage {
            case .generic(let string):
                ZStack {
                    Image(buttonImage.imageName)
                        .resizable()
                        .frame(height: 55)
                        .scaledToFit()
                    Text(string)
                        .font(.custom("PalameciaTitling-Regular", size: 24))
                        .minimumScaleFactor(0.01)
                        .foregroundColor(.white)
                }
            default:
                Image(buttonImage.imageName)
                    .resizable()
                    .scaledToFit()
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
