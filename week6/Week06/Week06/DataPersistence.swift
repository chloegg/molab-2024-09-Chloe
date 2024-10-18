//
//  DataPersistence.swift
//  Week06
//
//  Created by Keying Guo on 10/18/24.
//

import Foundation

// Save Data to JSON
func saveData(users: [User]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(users) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent("users.json")
            do {
                try encoded.write(to: fileURL)
                print("User data saved successfully.") // Debugging line
            } catch {
                print("Failed to save data: \(error.localizedDescription)")
            }
        }
    } else {
        print("Failed to encode users.") // Debugging line
    }
}

// Load Data from JSON
func loadData() -> [User] {
    let decoder = JSONDecoder()
    if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentDirectory.appendingPathComponent("users.json")
        if let data = try? Data(contentsOf: fileURL) {
            if let decoded = try? decoder.decode([User].self, from: data) {
                print("Data loaded successfully from: \(fileURL)") // Debugging line
                return decoded
            }
        } else {
            print("No data found at: \(fileURL)") // Debugging line
        }
    }
    return []
}
