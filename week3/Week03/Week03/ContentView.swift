//
//  ContentView.swift
//  Week03
//
//  Created by Keying Guo on 9/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var creatureParts = CreatureView() // Store the random creature
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // Display the randomly generated creature
                creatureParts
                    .frame(width: 300, height: 400)
                
                Spacer().frame(height: 50)
                
                // Button to regenerate a new random creature
                Button(action: {
                    generateRandomCreature()
                }) {
                    Text("Generate New Creature")
                        .font(.title)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .navigationTitle("Random Creature Generator")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
        .onAppear {
            generateRandomCreature()
        }
    }
    
    // Function to generate a new random creature
    func generateRandomCreature() {
        creatureParts = CreatureView() // Regenerate a new creature
    }
}

struct CreatureView: View {
    // Generate random colors
    let bodyColor = Color(
        red: Double.random(in: 0...1),
        green: Double.random(in: 0...1),
        blue: Double.random(in: 0...1)
    )
    
    // Random sizes for body parts
    let bodySize = CGSize(width: CGFloat.random(in: 100...200), height: CGFloat.random(in: 150...250))
    let armSize = CGSize(width: 20, height: CGFloat.random(in: 80...120))
    let legSize = CGSize(width: 20, height: CGFloat.random(in: 80...120))
    let eyeSize = CGFloat.random(in: 20...40)
    
    var body: some View {
        ZStack {
            // Body
            RoundedRectangle(cornerRadius: 25)
                .fill(bodyColor)
                .frame(width: bodySize.width, height: bodySize.height)
            
            // Eyes
            HStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: eyeSize, height: eyeSize)
                    .overlay(Circle().fill(Color.black).frame(width: eyeSize / 2, height: eyeSize / 2))
                
                Circle()
                    .fill(Color.white)
                    .frame(width: eyeSize, height: eyeSize)
                    .overlay(Circle().fill(Color.black).frame(width: eyeSize / 2, height: eyeSize / 2))
            }
            .offset(y: -bodySize.height / 3)
            
            // Arms
            HStack {
                Rectangle()
                    .fill(bodyColor)
                    .frame(width: armSize.width, height: armSize.height)
                    .rotationEffect(.degrees(-45))
                
                Spacer().frame(width: bodySize.width - 40) // Adjust spacing
                
                Rectangle()
                    .fill(bodyColor)
                    .frame(width: armSize.width, height: armSize.height)
                    .rotationEffect(.degrees(45))
            }
            .offset(y: -bodySize.height / 6)
            
            // Legs
            HStack {
                Rectangle()
                    .fill(bodyColor)
                    .frame(width: legSize.width, height: legSize.height)
                
                Spacer().frame(width: bodySize.width - 40) // Adjust spacing
                
                Rectangle()
                    .fill(bodyColor)
                    .frame(width: legSize.width, height: legSize.height)
            }
            .offset(y: bodySize.height / 3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
