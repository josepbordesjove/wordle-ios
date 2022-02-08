//
//  ContentView.swift
//  wordle-ios
//
//  Created by Josep Bordes Jové on 8/2/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("background-1")
                .resizable()
                .scaledToFill()
            Text("Welcome")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
