import SwiftUI

struct HeaderView<Content: View>: View {
    @ViewBuilder var destination: Content
    var backButtonTapped: () -> Void
    
    var body: some View {
        HStack {
            ButtonView(buttonImage: .back) {
                backButtonTapped()
            }
            .frame(width: 45, height: 45, alignment: .leading)
            .buttonStyle(ScaleButtonStyle())
            Spacer()
            Image("logo_img")
                .resizable()
                .scaledToFit()
                .frame(height: UIScreen.main.bounds.height * 0.05)
                .padding(.vertical, 5)
            Spacer()
            if let destination = destination {
                destination
                .frame(width: 45, height: 45, alignment: .leading)
                .buttonStyle(ScaleButtonStyle())
            } else {
                Spacer()
                    .frame(width: 45, height: 45, alignment: .trailing)
            }
        }
        .padding(.horizontal, 20)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
