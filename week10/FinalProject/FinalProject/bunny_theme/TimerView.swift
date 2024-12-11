//
//  TimerView.swift
//  FinalProject
//
//  Created by Keying Guo on 12/10/24.
//

import SwiftUI
import AVFoundation

struct TimerView: View {
    @State private var timeRemaining: Int = UserDefaults.standard.integer(forKey: "timeRemaining")
    @State private var timer: Timer?
    @State private var selectedMinutes: Int = 0
    @State private var selectedSeconds: Int = 0
    @State private var isTimerRunning = false
    @State private var isMusicPlaying = false
    @State private var showMusicPicker = false
    @State private var showStopAlert = false
    @State private var selectedMusic: String = "song1"
    @State private var audioPlayer: AVAudioPlayer?
    @State private var bunnyImage: String = "sleepingBunny"


    let musicOptions = ["song1", "song2", "song3"]
    let minuteOptions: [Int] = Array(0...59)
    let secondOptions: [Int] = Array(0...59)

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 154/255, green: 212/255, blue: 225/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 11) {
                    HStack {
                        Spacer()
                        Button(action: {
                            showMusicPicker.toggle()
                        }) {
                            Image(systemName: "music.note")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 17, height: 17)
                                .padding()
                                .foregroundColor(Color.blue.opacity(0.4))
                                .background(Color.white.opacity(0.6))
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 20)
                        .padding(.top, 0.3)
                    }
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            Circle()
                                .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                .frame(width: 160, height: 160)
                                .overlay(
                                    Circle()
                                        .stroke(Color(red: 250/255, green: 231/255, blue: 249/255), lineWidth: 8)
                                )
                                .overlay(
                                    Image(bunnyImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 205, height: 205)
                                )
                            
                            Text(formatTime(timeRemaining))
                                .font(.custom("Saira Stencil One", size: 80))
                                .foregroundColor(Color(red: 242/255, green: 201/255, blue: 76/255))
                            
                            HStack(spacing: 20) {
                                VStack {
                                    Text("Minutes")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                    Picker("Minutes", selection: $selectedMinutes) {
                                        ForEach(minuteOptions, id: \.self) {
                                            Text("\($0)")
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    .frame(width: 100)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(8)
                                }
                                
                                VStack {
                                    Text("Seconds")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                    Picker("Seconds", selection: $selectedSeconds) {
                                        ForEach(secondOptions, id: \.self) {
                                            Text("\($0)")
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    .frame(width: 100)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(8)
                                }
                            }
                            
                            // Begin/Pause/Resume Button
                            Button(action: {
                                if isTimerRunning {
                                    pauseTimer()
                                } else {
                                    startTimer()
                                }
                            }) {
                                Text(isTimerRunning ? "Pause " : (timeRemaining > 0 ? "Resume " : "Begin Timer"))
                                    .font(.custom("Saira Stencil One", size: 25))
                                    .foregroundColor(Color(red: 240/255, green: 215/255, blue: 215/255))
                                    .frame(width: 170)
                                    .padding(.vertical, 4)
                                    .background(Color(red: 197/255, green: 78/255, blue: 78/255))
                                    .cornerRadius(15)
                            }
                            .padding(.top, 10)

                            // Stop Timer Button
                            Button(action: {
                                showStopAlert = true
                            }) {
                                Text("Stop Timer")
                                    .font(.custom("Saira Stencil One", size: 25))
                                    .foregroundColor(Color(red: 0.773, green: 0.306, blue: 0.306))
                                    .frame(width: 170)
                                    .padding(.vertical, 4)
                                    .background(Color.white.opacity(0.5))
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                            }
                            .padding(.top, 10)
                            .alert(isPresented: $showStopAlert) {
                                Alert(
                                    title: Text("Are you sure?"),
                                    message: Text("Your pet will lose a health."),
                                    primaryButton: .destructive(Text("Stop")) {
                                        stopTimerAndReset()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        }
                        .padding(.horizontal, 46)
                        .padding(.top, 50)
                        .padding(.bottom, 45)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Color(red: 154 / 255, green: 201 / 255, blue: 225 / 255)
                            .ignoresSafeArea(edges: .bottom)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -2)
                        
                        VStack {
                            Spacer()
                                .frame(height: 15)
                            HStack(spacing: 0.5) {
                                NavigationLink(destination: HomeScreen().navigationBarHidden(true)) {
                                    NavigationBarItem(icon: "house.fill", label: "home", isActive: false)
                                }
                                NavigationLink(destination: ActivitiesView().navigationBarHidden(true)) {
                                    NavigationBarItem(icon: "list.bullet", label: "todos", isActive: false)
                                }
                                NavigationBarItem(icon: "timer", label: "timer", isActive: true)
                                NavigationLink(destination:
                                                CalendarView().navigationBarHidden(true)) {
                                    NavigationBarItem(icon: "book.fill", label: "cal...", isActive: false)
                                }
                                NavigationLink(destination: ProfileView().navigationBarHidden(true)) {
                                    NavigationBarItem(icon: "person.fill", label: "profile", isActive: false)
                                }
                            }
                            Spacer()
                                .frame(height: 5)
                        }
                    }
                    .frame(height: 55)
                }
            }
            .sheet(isPresented: $showMusicPicker) {
                MusicPickerView(
                    musicOptions: musicOptions,
                    selectedMusic: $selectedMusic,
                    onPlay: playMusic,
                    onPause: pauseMusic,
                    isMusicPlaying: $isMusicPlaying
                )
            }
            .onAppear {
                loadTimerState()
            }
            .onDisappear {
                saveTimerState()
                if isMusicPlaying {
                    pauseMusic()
                }
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
    
    private func playMusic(music: String) {
        guard let url = Bundle.main.url(forResource: music, withExtension: "mp3") else {
            print("Music file not found: \(music)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            isMusicPlaying = true
        } catch {
            print("Error playing music: \(error.localizedDescription)")
        }
    }
    
    private func pauseMusic() {
        audioPlayer?.pause()
        isMusicPlaying = false
    }
    
    private func startTimer() {
        if timeRemaining == 0 {
            timeRemaining = (selectedMinutes * 60) + selectedSeconds
        }
        bunnyImage = "sleepingBunny"
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                bunnyImage = "awakeBunny"
                stopTimerAndReset()
            }
        }
    }
    
    private func pauseTimer() {
        timer?.invalidate()
        isTimerRunning = false
    }
    
    private func stopTimerAndReset() {
        timer?.invalidate()
        timer = nil
        timeRemaining = 0
        isTimerRunning = false
        audioPlayer?.stop()
        isMusicPlaying = false
    }
    
    private func saveTimerState() {
        UserDefaults.standard.set(timeRemaining, forKey: "timeRemaining")
    }
    
    private func loadTimerState() {
        timeRemaining = UserDefaults.standard.integer(forKey: "timeRemaining")
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d : %02d", minutes, remainingSeconds)
    }
}


struct MusicPickerView: View {
    let musicOptions: [String]
    @Binding var selectedMusic: String
    let onPlay: (String) -> Void
    let onPause: () -> Void
    @Binding var isMusicPlaying: Bool
    
    var body: some View {
        ZStack {
            Color(red: 154/255, green: 212/255, blue: 225/255)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Select Music")
                    .font(.custom("Saira Stencil One", size: 30))
                    .foregroundColor(Color.white)
                    .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(musicOptions, id: \.self) { music in
                            Button(action: {
                                selectedMusic = music
                                onPlay(music)
                            }) {
                                Text(music.capitalized)
                                    .font(.custom("Saira Stencil One", size: 22))
                                    .foregroundColor(Color(red: 240/255, green: 215/255, blue: 215/255))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(red: 197/255, green: 78/255, blue: 78/255))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Button(action: {
                    if isMusicPlaying {
                        onPause()
                    } else {
                        onPlay(selectedMusic)
                    }
                }) {
                    Text(isMusicPlaying ? "Pause" : "Play")
                        .font(.custom("Saira Stencil One", size: 20))
                        .foregroundColor(Color(red: 0.773, green: 0.306, blue: 0.306))
                        .frame(width: 330, height: 40)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
