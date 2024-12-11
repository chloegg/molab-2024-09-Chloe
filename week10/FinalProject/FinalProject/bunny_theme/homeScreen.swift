//
//  homeScreen.swift
//  FinalProject
//
//  Created by Keying Guo on 12/6/24.
//

import SwiftUI

struct HomeScreen: View {
    @State private var petName: String = "Fluffy"
    @State private var petLevel: Int = 1
    @State private var petHappiness: Double = 50 // Initially 50%
    @State private var petHealth: Double = 50    // Initially 50%

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 250 / 255, green: 231 / 255, blue: 249 / 255)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 20) {
                            PetSection(petName: petName, petLevel: petLevel)

                            PetStatsSection(happiness: petHappiness, health: petHealth)

                            InteractionSection(
                                onCompleteTask: increaseHappinessAndHealth,
                                onCompleteTimer: increaseHealth
                            )
                        }
                        .padding(.top, 20)
                    }

                    Spacer()

                    // Navigation Bar
                    ZStack {
                        Color(red: 154 / 255, green: 201 / 255, blue: 225 / 255)
                            .ignoresSafeArea(edges: .bottom)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -2)

                        VStack {
                            Spacer()
                                .frame(height: 15)
                            HStack(spacing: 0.5) {
                                NavigationBarItem(icon: "house.fill", label: "home", isActive: true)
                                NavigationLink(destination: ActivitiesView().navigationBarHidden(true)) {
                                    NavigationBarItem(icon: "list.bullet", label: "todos", isActive: false)
                                }
                                NavigationLink(destination: TimerView().navigationBarHidden(true)) {
                                    NavigationBarItem(icon: "timer", label: "timer", isActive: false)
                                }
                                NavigationLink(destination: CalendarView().navigationBarHidden(true)) {
                                    NavigationBarItem(icon: "book.fill", label: "cal..", isActive: false)
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
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }

    private func increaseHappinessAndHealth() {
        petHappiness = min(petHappiness + 2, 100) // Cap at 100%
        petHealth = min(petHealth + 2, 100)       // Cap at 100%
    }

    private func increaseHealth() {
        petHealth = min(petHealth + 5, 100)       // Cap at 100%
    }
}

struct InteractionSection: View {
    let onCompleteTask: () -> Void
    let onCompleteTimer: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Interact with Your Pet")
                .font(.custom("Saira Stencil One", size: 24))
                .foregroundColor(.black)

            HStack(spacing: 40) {
                NavigationLink(destination: ActivitiesView().navigationBarHidden(true)) {
                    InteractionButton(label: "Feed", icon: "leaf.fill", color: .green, action: onCompleteTask)
                }
                InteractionButton(label: "Play", icon: "gamecontroller.fill", color: .blue, action: {})
                NavigationLink(destination: TimerView().navigationBarHidden(true)) {
                    InteractionButton(label: "Rest", icon: "bed.double.fill", color: .purple, action: onCompleteTimer)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

struct InteractionButton: View {
    let label: String
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding()
                    .background(color)
                    .clipShape(Circle())

                Text(label)
                    .font(.custom("Saira Stencil One", size: 14))
                    .foregroundColor(.black)
                    .padding(.top, 5)
            }
        }
    }
}

struct PetStatsSection: View {
    let happiness: Double
    let health: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Pet Stats")
                .font(.custom("Saira Stencil One", size: 24))
                .foregroundColor(.black)

            StatRow(label: "Happiness", value: happiness, color: .yellow)
            StatRow(label: "Health", value: health, color: .red)
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 4)
        .padding(.horizontal, 20)
    }
}

struct StatRow: View {
    let label: String
    let value: Double
    let color: Color

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .font(.custom("Saira Stencil One", size: 18))
                    .foregroundColor(.black)
                Spacer()
                Text("\(Int(value))%")
                    .font(.custom("Saira Stencil One", size: 18))
                    .foregroundColor(.black)
            }
            ProgressView(value: value / 100)
                .progressViewStyle(LinearProgressViewStyle(tint: color))
        }
    }
}


struct PetSection: View {
    let petName: String
    let petLevel: Int

    var body: some View {
        VStack {
            ZStack {
                Image("bathBunny") // Replace system image with custom image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160, height: 160)
                            }

            Text(petName)
                .font(.custom("Saira Stencil One", size: 28))
                .foregroundColor(.black)
                .padding(.top, -4)

            Text("Level \(petLevel)")
                .font(.custom("Saira Stencil One", size: 18))
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 20)
    }
}


struct NavigationBarItem: View {
    let icon: String
    let label: String
    let isActive: Bool

    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.white)
            Text(label)
                .font(.custom("Saira Stencil One", size: 14))
                .foregroundColor(.white)
        }
        .padding(.vertical, 7)
        .padding(.horizontal, 16)
        .background(isActive ? Color.black.opacity(0.2) : Color.clear)
        .cornerRadius(8)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
