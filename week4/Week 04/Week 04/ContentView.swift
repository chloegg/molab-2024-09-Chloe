//
//  ContentView.swift
//  Week 04
//
//  Created by Keying Guo on 10/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            UnderwaterView()
                .tabItem {
                    Label("Underwater", systemImage: "drop.fill")
                }
            ForestView()
                .tabItem {
                    Label("Forest", systemImage: "leaf.fill")
                }
            DesertView()
                .tabItem {
                    Label("Desert", systemImage: "sun.max.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

