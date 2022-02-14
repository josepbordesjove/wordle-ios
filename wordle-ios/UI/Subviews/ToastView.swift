//
//  ToastView.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

import SwiftUI

struct ToastView: View {
    @State var timeRemaining = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let errorMessage: String
    var onDismiss: (() -> Void)?
    
    var body: some View {
        VStack {
            ZStack {
                Capsule(style: .continuous)
                    .fill(Color.accentColor)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                HStack {
                    Image("close_btn")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                    Text(errorMessage)
                        .font(.custom("PalameciaTitling-Regular", size: 14))
                        .foregroundColor(.white)
                }
                .padding(10)
            }
            .frame(height: 55)
            .padding(.top, 45)
            .padding(.horizontal, 20)
            .onTapGesture {
                withAnimation {
                    onDismiss?()
                }
            }
            Spacer()
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                withAnimation {
                    onDismiss?()
                }
            }
        }
        .transition(AnyTransition.move(edge: .top).combined(with: .scale).combined(with: .opacity))
        .zIndex(100)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(errorMessage: "No s'ha trobat la paraula inroduïda")
    }
}
