//
//  ActivitiesView.swift
//  FinalProject
//
//  Created by Keying Guo on 12/9/24.
//

import SwiftUI

struct ActivitiesView: View {
    @State private var showPopup = false
    @State private var newTodo = ""
    @State private var isPriority = false
    @State private var prioritizedActivities: [String] = UserDefaults.standard.stringArray(forKey: "prioritizedActivities") ?? []
    @State private var activities: [String] = UserDefaults.standard.stringArray(forKey: "activities") ?? []

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color(red: 154/255, green: 212/255, blue: 225/255)
                        .ignoresSafeArea()

                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                showPopup = true
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color.white.opacity(0.6))
                                        .frame(width: 40, height: 40)
                                    
                                    Image(systemName: "plus")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color.blue.opacity(0.2))
                                }
                            }
                            .padding(.trailing, 29)
                            .padding(.top, 10)
                        }
                        .frame(maxWidth: .infinity)
                        
                        ScrollView {
                            VStack(spacing: 15) {
                                HStack {
                                    AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/47d7fd6e9b31fcce25ed3c1634e1d580699c52bd57ca3ea2ff862adcb7af003a?placeholderIfAbsent=true&apiKey=aa7a4deaf7484c0083679b37f9f13087&format=webp")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 150)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.leading, 128)
                                
                                ForEach(Array(prioritizedActivities.enumerated()), id: \.element) { index, activity in
                                    ActivityItemView(
                                        title: activity,
                                        activities: $prioritizedActivities,
                                        index: index,
                                        isPriority: true,
                                        onDelete: savePrioritizedActivitiesToUserDefaults
                                    )
                                    .padding(.horizontal, 20)
                                }
                                
                                ForEach(Array(activities.enumerated()), id: \.element) { index, activity in
                                    ActivityItemView(
                                        title: activity,
                                        activities: $activities,
                                        index: index,
                                        isPriority: false,
                                        onDelete: saveActivitiesToUserDefaults
                                    )
                                    .padding(.horizontal, 20)
                                }
                            }
                        }

                        // Updated Navigation Bar
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
                                    NavigationBarItem(icon: "list.bullet", label: "todos", isActive: true)
                                    NavigationLink(destination: TimerView().navigationBarHidden(true)) { // TimerView added here
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

                    if showPopup {
                        popupView()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }

    @ViewBuilder
    private func popupView() -> some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 15) {
                Text("Add New To-Do")
                    .font(.custom("Saira Stencil One", size: 24))
                    .foregroundColor(.white)

                TextField("Enter to-do", text: $newTodo)
                    .font(.custom("Saira Stencil One", size: 18))
                    .padding(10)
                    .frame(width: UIScreen.main.bounds.width * 0.7)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 2)

                HStack {
                    Button(action: {
                        isPriority.toggle()
                    }) {
                        HStack(spacing: 10) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 24, height: 24)

                                if isPriority {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.black)
                                        .frame(width: 16, height: 16)
                                }
                            }

                            Text("Mark as priority")
                                .font(.custom("Saira Stencil One", size: 18))
                                .foregroundColor(.white)
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                }

                HStack(spacing: 15) {
                    Button(action: {
                        showPopup = false
                        isPriority = false
                    }) {
                        Text("Cancel")
                            .font(.custom("Saira Stencil One", size: 20))
                            .padding()
                            .frame(width: 120)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    }

                    Button(action: {
                        if !newTodo.isEmpty {
                            if isPriority {
                                prioritizedActivities.append(newTodo)
                                savePrioritizedActivitiesToUserDefaults()
                            } else {
                                activities.insert(newTodo, at: 0)
                                saveActivitiesToUserDefaults()
                            }
                            newTodo = ""
                            isPriority = false
                            showPopup = false
                        }
                    }) {
                        Text("Add")
                            .font(.custom("Saira Stencil One", size: 20))
                            .padding()
                            .frame(width: 120)
                            .background(Color(red: 1, green: 0.525, blue: 0.953))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    }
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.8, height: 300)
            .background(Color(red: 0.604, green: 0.788, blue: 0.882))
            .cornerRadius(12)
            .shadow(radius: 5)
        }
        .transition(.opacity)
        .animation(.easeInOut, value: showPopup)
    }

    private func saveActivitiesToUserDefaults() {
        UserDefaults.standard.set(activities, forKey: "activities")
    }

    private func savePrioritizedActivitiesToUserDefaults() {
        UserDefaults.standard.set(prioritizedActivities, forKey: "prioritizedActivities")
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView()
    }
}
