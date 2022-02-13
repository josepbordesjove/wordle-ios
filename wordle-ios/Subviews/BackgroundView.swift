import SwiftUI

enum BackgroundStyle {
    case grass
    case sky
    
    var rawName: String {
        switch self {
        case .grass: return "background-1"
        case .sky: return "background-2"
        }
    }
}

struct BackgroundView: View {
    let style: BackgroundStyle
    
    var body: some View {
        GeometryReader { geometry in
            Image(style.rawName)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: .center)
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(style: .grass)
    }
}
