//
//  StartView.swift
//  Week06
//
//  Created by Keying Guo on 10/18/24.
//

import SwiftUI

struct StartView: View {
    @State private var currentUser: User? = nil // Store current user globally
    @State private var isSignUp = false // Boolean to trigger SignUpView
    @State private var isLogin = false // Boolean to trigger LoginView

    var body: some View {
        VStack(spacing: 20) {
            if let _ = currentUser {
                // Show ProfileView when logged in
                ProfileView(currentUser: $currentUser)
            } else {
                // Show login/signup buttons when no user is logged in
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Button(action: {
                    isSignUp = true // Trigger showing SignUpView
                }) {
                    Text("Sign Up")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .fullScreenCover(isPresented: $isSignUp) {
                    SignUpView(currentUser: $currentUser) // Pass down currentUser as binding
                }

                Button(action: {
                    isLogin = true // Trigger showing LoginView
                }) {
                    Text("Log In")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .fullScreenCover(isPresented: $isLogin) {
                    LoginView(currentUser: $currentUser) // Pass down currentUser as binding
                }
            }
        }
        .padding()
    }
}

#Preview {
    StartView()
}
