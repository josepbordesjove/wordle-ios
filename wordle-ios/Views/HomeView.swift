//
//  ContentView.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 8/2/22.
//

import SwiftUI
import CoreData

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background-1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            print("Setings Button")
                        } label: {
                            Image("settings_btn")
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                    .padding(.top, 50)
                    .padding(.trailing, 20)
                    Spacer()
                    HStack {
                        Button {
                            print("Play button was tapped")
                        } label: {
                            NavigationLink(destination: GameView()) {
                                Image("play_btn")
                            }
                        }
                        .buttonStyle(ScaleButtonStyle())
                        .padding(40)
                        Button {
                            for family: String in UIFont.familyNames
                                   {
                                       print(family)
                                       for names: String in UIFont.fontNames(forFamilyName: family)
                                       {
                                           print("== \(names)")
                                       }
                                   }
                        } label: {
                            Image("select_btn")
                        }
                        .buttonStyle(ScaleButtonStyle())
                        .padding(40)
                    }
                    .padding(.bottom, 60)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
