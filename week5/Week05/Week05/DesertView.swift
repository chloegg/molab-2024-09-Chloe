//
//  DesertView.swift
//  Week 04
//
//  Created by Keying Guo on 10/3/24.
//

import SwiftUI
import AVFoundation

struct DesertView: View {
    @State var audioPlayer: AVAudioPlayer?
    @AppStorage("isDesertPlaying") private var isPlaying: Bool = false // Persist play state
    @AppStorage("desertPlayCount") private var playCount: Int = 0 // Persist play count
    @State private var showFlowingWind = false

    var body: some View {
        ZStack {
            Color.orange.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                DesertShape()
                    .stroke(Color.orange, lineWidth: 3)
                    .frame(width: 300, height: 200)
                    .padding()

                // Toggle between Play and Stop based on isPlaying state
                Button(action: {
                    if isPlaying {
                        stopSound()
                    } else {
                        playSound(sound: "desert_wind", type: "mp3")
                    }
                }) {
                    Text(isPlaying ? "Stop Wind Sound" : "Play Wind Sound")
                        .padding()
                        .background(isPlaying ? Color.red : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(maxWidth: 200)
                }

                // Display the number of times the sound has been played
                Text("Times Played: \(playCount)")
                    .font(.headline)
                    .padding()
            }

            if showFlowingWind {
                FlowingWindView()
                    .transition(.opacity) // Optional: add transition for smooth appearance
            }
        }
        .onAppear {
            // Restore the previous state
            if isPlaying {
                showFlowingWind = true
            }
        }
        .animation(.easeInOut, value: showFlowingWind) // Animate the appearance/disappearance
    }

    // Play sound and increment the play count
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
                isPlaying = true // Persist the play state
                playCount += 1 // Increment the play count
                showFlowingWind = true
            } catch {
                print("Error playing sound")
            }
        }
    }

    // Stop sound and set isPlaying to false
    func stopSound() {
        audioPlayer?.stop()
        isPlaying = false // Persist the stop state
        showFlowingWind = false
    }
}

struct DesertShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control1: CGPoint(x: rect.midX, y: rect.minY), control2: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}

struct FlowingWindView: View {
    @State private var windOffset: CGFloat = -300

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<3) { index in
                    FlowingRibbonShape()
                        .stroke(Color.white.opacity(0.7), lineWidth: CGFloat.random(in: 4...8))
                        .offset(x: windOffset, y: CGFloat(index) * 100 - 150)
                        .onAppear {
                            withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                                windOffset = geometry.size.width + 300
                            }
                        }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct FlowingRibbonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveHeight: CGFloat = 50
        let waveLength: CGFloat = rect.width / 4
        let startPoint = CGPoint(x: rect.minX, y: rect.midY)

        path.move(to: startPoint)
        
        // Create a flowing wave pattern across the screen
        for i in stride(from: 0, through: rect.width, by: waveLength) {
            let controlPoint1 = CGPoint(x: startPoint.x + i + waveLength / 2, y: rect.midY - waveHeight)
            let controlPoint2 = CGPoint(x: startPoint.x + i + waveLength, y: rect.midY)
            path.addCurve(to: CGPoint(x: controlPoint2.x, y: controlPoint2.y), control1: controlPoint1, control2: controlPoint2)
        }
        return path
    }
}

struct DesertView_Previews: PreviewProvider {
    static var previews: some View {
        DesertView()
    }
}
