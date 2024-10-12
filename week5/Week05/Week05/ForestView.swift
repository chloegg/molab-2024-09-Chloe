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
    @AppStorage("isForestPlaying") private var isPlaying: Bool = false // Persist play state
    @AppStorage("forestPlayCount") private var playCount: Int = 0 // Persist play count
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
                }) {
                    Text(isPlaying ? "Stop Birds Sound" : "Play Birds Sound")
                        .padding()
                        .background(isPlaying ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(maxWidth: 200)
                }

                // Display the number of times the sound has been played
                Text("Times Played: \(playCount)")
                    .font(.headline)
                    .padding()
            }

            if showLeaves {
                FallingLeavesView()
                    .transition(.opacity) // Optional: add transition for smooth appearance
            }
        }
        .onAppear {
            // Restore the previous state
            if isPlaying {
                showLeaves = true
            }
        }
        .animation(.easeInOut, value: showLeaves) // Animate the appearance/disappearance
    }

    // Play sound and increment the play count
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
                isPlaying = true // Persist the play state
                playCount += 1 // Increment the play count
                showLeaves = true
            } catch {
                print("Error playing sound")
            }
        }
    }

    // Stop sound and set isPlaying to false
    func stopSound() {
        audioPlayer?.stop()
        isPlaying = false // Persist the stop state
        showLeaves = false
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
