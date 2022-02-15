import SwiftUI

enum ToastViewIcon {
    case incorrect
    case informative
    
    var image: String {
        switch self {
        case .incorrect: return "close_btn"
        case .informative: return "alert_btn"
        }
    }
}

struct ToastView: View {
    enum Constant {
        static let interval: Double = 1
        static let initialTime = 6
    }

    @State var timeRemaining = Constant.initialTime
    var timer = Timer.publish(every: Constant.interval, on: .main, in: .common).autoconnect()
    
    let errorMessage: String
    let icon: ToastViewIcon
    var onDismiss: (() -> Void)?
    
    var body: some View {
        VStack {
            ZStack {
                Capsule(style: .continuous)
                    .fill(Color.accentColor)
                    .background(
                        Capsule(style: .continuous)
                            .stroke(.white, lineWidth: 2)
                    )
                HStack {
                    Image(icon.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                    Text(errorMessage)
                        .font(.custom("PalameciaTitling-Regular", size: 16))
                        .foregroundColor(.white)
                }
                .padding(16)
            }
            .animation(.spring())
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 8)
            .padding(.horizontal, 20)
            .shadow(radius: 5)
            .onTapGesture {
                withAnimation {
                    onDismiss?()
                }
            }
            Spacer()
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= Int(Constant.interval)
            } else {
                withAnimation {
                    onDismiss?()
                }
            }
        }
        .onDisappear(perform: {
            timeRemaining = Constant.initialTime
        })
        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
        .zIndex(100)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(errorMessage: "No s'ha trobat la paraula inroduïda", icon: .informative)
    }
}
