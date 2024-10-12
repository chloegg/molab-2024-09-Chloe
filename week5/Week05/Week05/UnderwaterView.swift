//
//  UnderwaterView.swift
//  Week 04
//
//  Created by Keying Guo on 10/3/24.
//

import SwiftUI
import AVFoundation

struct UnderwaterView: View {
    @State var audioPlayer: AVAudioPlayer?
    @AppStorage("isUnderwaterPlaying") private var isPlaying: Bool = false // Persist play state
    @AppStorage("underwaterPlayCount") private var playCount: Int = 0 // Persist play count
    @State private var showBubbles = false

    var body: some View {
        ZStack {
            Color.blue.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                UnderwaterShape()
                    .stroke(Color.blue, lineWidth: 3)
                    .frame(width: 300, height: 200)
                    .padding()

                // Toggle between Play and Stop based on isPlaying state
                Button(action: {
                    if isPlaying {
                        stopSound()
                    } else {
                        playSound(sound: "ocean_waves", type: "mp3")
                    }
                }) {
                    Text(isPlaying ? "Stop Waves Sound" : "Play Waves Sound")
                        .padding()
                        .background(isPlaying ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(maxWidth: 200)
                }

                // Display the number of times the sound has been played
                Text("Times Played: \(playCount)")
                    .font(.headline)
                    .padding()
            }
            
            if showBubbles {
                BubblesView()
                    .transition(.opacity) // Optional: add transition for smooth appearance
            }
        }
        .onAppear {
            // Restore the previous state
            if isPlaying {
                showBubbles = true
            }
        }
        .animation(.easeInOut, value: showBubbles) // Animate the appearance/disappearance
    }

    // Play sound and increment the play count
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
                isPlaying = true // Persist the play state
                playCount += 1 // Increment the play count
                showBubbles = true
            } catch {
                print("Error playing sound")
            }
        }
    }

    // Stop sound and set isPlaying to false
    func stopSound() {
        audioPlayer?.stop()
        isPlaying = false // Persist the stop state
        showBubbles = false
    }
}

struct UnderwaterShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct BubblesView: View {
    @State private var bubblePositions = [CGFloat](repeating: 0, count: 5)

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<bubblePositions.count, id: \.self) { index in
                Circle()
                    .fill(Color.white.opacity(0.6))
                    .frame(width: CGFloat.random(in: 10...30), height: CGFloat.random(in: 10...30))
                    .position(x: CGFloat.random(in: 0...geometry.size.width),
                              y: bubblePositions[index])
                    .onAppear {
                        let delay = Double(index) * 0.5
                        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                            withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: false)) {
                                bubblePositions[index] = geometry.size.height + 100
                            }
                        }
                    }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct UnderwaterView_Previews: PreviewProvider {
    static var previews: some View {
        UnderwaterView()
    }
}
