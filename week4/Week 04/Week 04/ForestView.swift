//
//  ForestView.swift
//  Week 04
//
//  Created by Keying Guo on 10/3/24.
//

import SwiftUI
import AVFoundation

struct ForestView: View {
    @State var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false // To track if the sound is playing
    @State private var showLeaves = false

    var body: some View {
        ZStack {
            Color.green.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                ForestShape()
                    .fill(Color.green)
                    .frame(width: 200, height: 300)
                    .padding()

                // Toggle between Play and Stop based on isPlaying state
                Button(action: {
                    if isPlaying {
                        stopSound()
                    } else {
                        playSound(sound: "forest_birds", type: "mp3")
                    }
                    withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                        showLeaves.toggle()
                    }
                }) {
                    Text(isPlaying ? "Stop Birds Sound" : "Play Birds Sound")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }

            if showLeaves {
                FallingLeavesView()
            }
        }
    }

    // Play sound and set isPlaying to true
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
                isPlaying = true
            } catch {
                print("Error playing sound")
            }
        }
    }

    // Stop sound and set isPlaying to false
    func stopSound() {
        audioPlayer?.stop()
        isPlaying = false
    }
}

struct ForestShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct FallingLeavesView: View {
    @State private var leafPositions = [CGFloat](repeating: 0, count: 5)

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<leafPositions.count, id: \.self) { index in
                LeafShape()
                    .fill(Color.brown)
                    .frame(width: CGFloat.random(in: 20...40), height: CGFloat.random(in: 30...50))
                    .rotationEffect(.degrees(Double.random(in: 0...360))) // Random rotation
                    .position(x: CGFloat.random(in: 0...geometry.size.width),
                              y: leafPositions[index])
                    .onAppear {
                        let delay = Double(index) * 0.5
                        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                            withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
                                leafPositions[index] = geometry.size.height + 100
                            }
                        }
                    }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct LeafShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: CGPoint(x: rect.minX + 10, y: rect.midY + 10))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.maxX - 10, y: rect.midY - 10))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), control: CGPoint(x: rect.midX - 5, y: rect.minY + 5))
        return path
    }
}

struct ForestView_Previews: PreviewProvider {
    static var previews: some View {
        ForestView()
    }
}
