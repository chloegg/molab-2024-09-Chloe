//
//  LoginView.swift
//  Week06
//
//  Created by Keying Guo on 10/18/24.
//
import SwiftUI

struct LoginView: View {
    @Binding var currentUser: User? // Use a binding to store the logged-in user globally
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var users: [User] = []
    @State private var loginFailed = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Log In")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            if loginFailed {
                Text("Login Failed. Please try again.")
                    .foregroundColor(.red)
            }

            Button(action: logIn) {
                Text("Log In")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .onAppear(perform: loadSavedUsers) // Load users on appear
    }

    func logIn() {
        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            currentUser = user // Update global currentUser
        } else {
            loginFailed = true // Show error for invalid credentials
        }
    }

    func loadSavedUsers() {
        users = loadData() // Load saved users from JSON
        print("Loaded \(users.count) users.")
    }
}
