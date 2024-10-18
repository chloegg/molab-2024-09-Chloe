//
//  SignUpView.swift
//  Week06
//
//  Created by Keying Guo on 10/18/24.
//

import SwiftUI

struct SignUpView: View {
    @Binding var currentUser: User? // Use a binding to store the signed-up user globally
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var users: [User] = []
    @State private var navigateToProfile = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Age", text: $age)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button(action: signUp) {
                Text("Create Account")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .onAppear(perform: loadSavedUsers) // Load users on appear
    }

    func signUp() {
        if let userAge = Int(age), !name.isEmpty, !email.isEmpty, !password.isEmpty {
            let newUser = User(name: name, age: userAge, email: email, password: password)
            users.append(newUser)
            saveData(users: users) // Save the user data
            currentUser = newUser // Update global currentUser
        } else {
            print("Sign up failed due to missing information")
        }
    }

    func loadSavedUsers() {
        users = loadData() // Load saved users from JSON
        print("Loaded \(users.count) users.")
    }
}

