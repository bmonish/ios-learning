//
//  ContentView.swift
//  HelloWorldSwift
//
//  Created by monish-pt4649 on 01/12/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
            Button(action: {}) {
                Text("Test Button")
            }
            Button(action: {}) {
                Text("Test Button")
            }
            Button(action: {}) {
                Text("Test Button")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
