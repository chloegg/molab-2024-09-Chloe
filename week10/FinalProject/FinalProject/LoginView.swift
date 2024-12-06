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
    
    var body: some View {
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
                    .frame(width: 250, height: 250)
                    .offset(x: -17)
                
                Spacer()

                VStack(alignment: .leading, spacing: 15) {
                    Text("username")
                        .font(.custom("Saira Stencil One", size: 14))
                        .foregroundColor(Color(red: 0.302, green: 0.302, blue: 0.302))
                    
                    TextField("Enter username", text: $username)
                        .padding()
                        .frame(height: 50)
                        .background(Color(red: 0.914, green: 0.914, blue: 0.914))
                        .border(Color.black, width: 1)
                    
                    Text("password")
                        .font(.custom("Saira Stencil One", size: 14))
                        .foregroundColor(Color(red: 0.302, green: 0.302, blue: 0.302))
                    
                    SecureField("Enter password", text: $password)
                        .padding()
                        .frame(height: 50)
                        .background(Color(red: 0.914, green: 0.914, blue: 0.914))
                        .border(Color.black, width: 1)
                }
                .padding(.horizontal, 40)
                
                Spacer()
                Spacer()
                Spacer()
                
                VStack(spacing: 15) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("back")
                            .font(.custom("Saira Stencil One", size: 20))
                            .foregroundColor(Color(red: 0.773, green: 0.306, blue: 0.306))
                            .frame(width: 330, height: 40)
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                    }
                    
                    Button(action: {
                    }) {
                        Text("continue")
                            .font(.custom("Saira Stencil One", size: 20))
                            .foregroundColor(.black)
                            .frame(width: 330, height: 40)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 40)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
