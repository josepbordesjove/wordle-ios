//
//  Background.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

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
        Image(style.rawName)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(style: .grass)
    }
}
