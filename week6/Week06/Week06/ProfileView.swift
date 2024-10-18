//
//  ProfileView.swift
//  Week06
//
//  Created by Keying Guo on 10/18/24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var currentUser: User? // Binding to update and clear currentUser when logging out
    @Environment(\.presentationMode) var presentationMode // To dismiss the view

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let user = currentUser {
                    Text("Welcome, \(user.name)!")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Bio")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name: \(user.name)")
                        Text("Age: \(user.age)")
                        Text("Email: \(user.email)")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                    Spacer()
                } else {
                    Text("Error: User data is missing.")
                        .font(.title)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: logOut) {
                Text("Log Out")
                    .foregroundColor(.red)
            })
        }
    }

    func logOut() {
        // Clear the currentUser (log out the user)
        currentUser = nil
        // Dismiss the ProfileView to return to StartView
        presentationMode.wrappedValue.dismiss()
    }
}
