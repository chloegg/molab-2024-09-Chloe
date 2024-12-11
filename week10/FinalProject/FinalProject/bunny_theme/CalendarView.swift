//
//  CalendarView.swift
//  FinalProject
//
//  Created by Keying Guo on 12/10/24.
//

import SwiftUI

struct Reminder: Codable {
    let title: String
    let notes: String
    let time: Date
}

struct CalendarView: View {
    @State private var selectedDate: Date = Date()
    @State private var showAddReminder = false
    @State private var reminders: [Date: [Reminder]] = [:]

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 154 / 255, green: 212 / 255, blue: 225 / 255)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Text("Calendar")
                        .font(.custom("Saira Stencil One", size: 35))
                        .foregroundColor(.white)
                        .padding(.top, 10)

                    ScrollView {
                        VStack(spacing: 20) {
                            DatePicker(
                                "Select Date",
                                selection: $selectedDate,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .accentColor(Color(red: 240 / 255, green: 215 / 255, blue: 215 / 255))
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                            .padding(.horizontal, 20)

                            VStack(alignment: .leading, spacing: 10) {
                                Text("Reminders for \(formattedDate(selectedDate))")
                                    .font(.custom("Saira Stencil One", size: 20))
                                    .foregroundColor(Color(red: 0.773, green: 0.306, blue: 0.306))

                                if let remindersForDate = reminders[normalizeDate(selectedDate)]?.sorted(by: { $0.time < $1.time }),
                                   !remindersForDate.isEmpty {
                                    ForEach(Array(remindersForDate.enumerated()), id: \.1.title) { index, reminder in
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text("• \(reminder.title) at \(formattedTime(reminder.time))")
                                                    .font(.custom("Saira Stencil One", size: 16))
                                                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                                if !reminder.notes.isEmpty {
                                                    Text("  Notes: \(reminder.notes)")
                                                        .font(.custom("Saira Stencil One", size: 14))
                                                        .foregroundColor(Color.gray)
                                                }
                                            }
                                            Spacer()
                                            Button(action: {
                                                deleteReminder(at: index)
                                            }) {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundColor(.black)
                                            }
                                        }
                                    }
                                } else {
                                    Text("No reminders for this date.")
                                        .font(.custom("Saira Stencil One", size: 16))
                                        .foregroundColor(Color.gray)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                            .padding(.horizontal, 20)
                            Spacer()

                            Button(action: {
                                showAddReminder.toggle()
                            }) {
                                Text("Add Reminder")
                                    .font(.custom("Saira Stencil One", size: 20))
                                    .foregroundColor(Color(red: 0.773, green: 0.306, blue: 0.306))
                                    .frame(width: 330, height: 40)
                                    .background(Color.white.opacity(0.5))
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                            }
                            .padding(.bottom, 30)
                        }
                    }

                    ZStack {
                        Color(red: 154 / 255, green: 201 / 255, blue: 225 / 255)
                            .ignoresSafeArea(edges: .bottom)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -2)

                        VStack {
                            Spacer()
                                .frame(height: 15)
                            HStack(spacing: 0.5) {
                                NavigationLink(destination: HomeScreen().navigationBarHidden(true)) {
                                    NavigationBarItems(icon: "house.fill", label: "home", isActive: false)
                                }
                                NavigationLink(destination: ActivitiesView().navigationBarHidden(true)) {
                                    NavigationBarItems(icon: "list.bullet", label: "todos", isActive: false)
                                }
                                NavigationLink(destination: TimerView().navigationBarHidden(true)) {
                                    NavigationBarItems(icon: "timer", label: "timer", isActive: false)
                                }
                                NavigationBarItems(icon: "book.fill", label: "cal..", isActive: true)
                                NavigationLink(destination: ProfileView().navigationBarHidden(true)) {
                                    NavigationBarItems(icon: "person.fill", label: "profile", isActive: false)
                                }
                            }
                            Spacer()
                                .frame(height: 5)
                        }
                    }
                    .frame(height: 55)
                }
            }
            .sheet(isPresented: $showAddReminder) {
                AddReminderView(
                    selectedDate: selectedDate,
                    onSave: { reminder, date in
                        let normalizedDate = normalizeDate(date)
                        if reminders[normalizedDate] == nil {
                            reminders[normalizedDate] = []
                        }
                        reminders[normalizedDate]?.append(reminder)
                        saveReminders()
                    }
                )
            }
            .onAppear {
                loadReminders()
            }
            .navigationBarHidden(true)
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }

    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    private func deleteReminder(at index: Int) {
        let normalizedDate = normalizeDate(selectedDate)
        reminders[normalizedDate]?.remove(at: index)
        if reminders[normalizedDate]?.isEmpty == true {
            reminders.removeValue(forKey: normalizedDate)
        }
        saveReminders()
    }

    private func saveReminders() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(reminders.mapKeys { normalizeDate($0) }) {
            UserDefaults.standard.set(encoded, forKey: "reminders")
        }
    }

    private func loadReminders() {
        if let savedData = UserDefaults.standard.data(forKey: "reminders") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Date: [Reminder]].self, from: savedData) {
                reminders = decoded.mapKeys { normalizeDate($0) }
            }
        }
    }

    private func normalizeDate(_ date: Date) -> Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: date)
    }
}

extension Dictionary {
    func mapKeys<T: Hashable>(_ transform: (Key) -> T) -> [T: Value] {
        var result = [T: Value]()
        for (key, value) in self {
            result[transform(key)] = value
        }
        return result
    }
}

struct AddReminderView: View {
    var selectedDate: Date
    @State private var reminderTitle: String = ""
    @State private var reminderNotes: String = ""
    @State private var reminderTime: Date = Date()
    var onSave: (Reminder, Date) -> Void
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ZStack {
            Color(red: 154/255, green: 212/255, blue: 225/255)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Add Reminder")
                    .font(.custom("Saira Stencil One", size: 30))
                    .foregroundColor(.white)
                    .padding(.top, 20)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Reminder")
                        .font(.custom("Saira Stencil One", size: 20))
                        .foregroundColor(.white)
                    TextField("Enter your reminder...", text: $reminderTitle)
                        .padding()
                        .font(.custom("Saira Stencil One", size: 20))
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                }
                .padding(.horizontal, 20)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Notes")
                        .font(.custom("Saira Stencil One", size: 20))
                        .foregroundColor(.white)
                    TextField("Enter additional notes...", text: $reminderNotes)
                        .padding()
                        .font(.custom("Saira Stencil One", size: 20))
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                }
                .padding(.horizontal, 20)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Time")
                        .font(.custom("Saira Stencil One", size: 20))
                        .foregroundColor(.white)
                    DatePicker(
                        "Select Time",
                        selection: $reminderTime,
                        displayedComponents: [.hourAndMinute]
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                }
                .padding(.horizontal, 20)

                Spacer()

                Button(action: {
                    let newReminder = Reminder(title: reminderTitle, notes: reminderNotes, time: reminderTime)
                    onSave(newReminder, selectedDate)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save Reminder")
                        .font(.custom("Saira Stencil One", size: 20))
                        .foregroundColor(Color(red: 0.773, green: 0.306, blue: 0.306))
                        .frame(width: 330, height: 40)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                }
                .padding(.bottom, 30)
            }
        }
    }
}

struct NavigationBarItems: View {
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

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
