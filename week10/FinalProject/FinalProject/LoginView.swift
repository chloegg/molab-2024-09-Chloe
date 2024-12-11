//
//  LoginView.swift
//  FinalProject
//
//  Created by Keying Guo on 12/5/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var navigateToHome = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 1, green: 0.525, blue: 0.953)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    HStack {
                        Text("Login")
                            .font(.custom("Saira Stencil One", size: 36))
                            .foregroundColor(.black)
                            .padding(.top, 40)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    Image("orange")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 270, height: 270)
                        .padding(.top, 10)
                        .offset(x: -20)

                    Spacer()

                    VStack(alignment: .leading, spacing: 15) {
                        Text("username")
                            .font(.custom("Saira Stencil One", size: 14))
                            .foregroundColor(Color(red: 0.302, green: 0.302, blue: 0.302))

                        TextField("Enter username", text: $username)
                            .padding()
                            .frame(height: 50)
                            .font(.custom("Saira Stencil One", size: 14))
                            .background(Color(red: 0.914, green: 0.914, blue: 0.914))
                            .border(Color.black, width: 1)

                        Text("password")
                            .font(.custom("Saira Stencil One", size: 14))
                            .foregroundColor(Color(red: 0.302, green: 0.302, blue: 0.302))

                        SecureField("Enter password", text: $password)
                            .padding()
                            .font(.custom("Saira Stencil One", size: 14))
                            .frame(height: 50)
                            .background(Color(red: 0.914, green: 0.914, blue: 0.914))
                            .border(Color.black, width: 1)
                    }
                    .padding(.horizontal, 40)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                            .padding(.horizontal, 40)
                    }

                    Spacer()
                    Spacer()

                    VStack(spacing: 15) {
                        NavigationLink(
                            destination: HomeScreen()
                                .navigationBarHidden(true),
                            isActive: $navigateToHome
                        ) {
                            Button(action: validateLogin) {
                                Text("Login")
                                    .font(.custom("Saira Stencil One", size: 20))
                                    .foregroundColor(.black)
                                    .frame(width: 330, height: 40)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private func validateLogin() {
        let storedUsername = UserDefaults.standard.string(forKey: "username") ?? ""
        let storedPassword = UserDefaults.standard.string(forKey: "password") ?? ""

        if username == storedUsername && password == storedPassword {
            navigateToHome = true 
        } else {
            errorMessage = "Invalid username or password."
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
