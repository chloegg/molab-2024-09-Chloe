//
//  signupView.swift
//  FinalProject
//
//  Created by Keying Guo on 12/5/24.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var gender: String = ""
    
    var body: some View {
        ZStack {
            Color(red: 0.949, green: 0.788, blue: 0.298)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Title
                HStack {
                    Text("Profile")
                        .font(.custom("Saira Stencil One", size: 36))
                        .foregroundColor(.black)
                        .padding(.top, 40)
                    Spacer()
                }
                .padding(.horizontal, 20)
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
                
                VStack(spacing: 10) {
                    EditableInfoButton(textTitle: "name", text: $name, color: Color(red: 0.294, green: 0.580, blue: 0.290))
                    EditableInfoButton(textTitle: "age", text: $age, color: Color(red: 0.788, green: 0.361, blue: 0.361))
                    EditableInfoButton(textTitle: "gender", text: $gender, color: Color(red: 0.306, green: 0.549, blue: 0.773))
                }
                .padding(.horizontal, 40)
                .padding(.top, 40)
                
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
                    
                    NavigationLink(destination: DigiPetSelectionView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)) {
                            Text("continue")
                                .font(.custom("Saira Stencil One", size: 20))
                                .foregroundColor(.black)
                                .frame(width: 330, height: 40)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                        }
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 40)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct EditableInfoButton: View {
    let textTitle: String
    @Binding var text: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(textTitle)
                .font(.custom("Saira Stencil One", size: 24))
                .foregroundColor(.white)
            
            Spacer()
            
            TextField("", text: $text)
                .font(.custom("Saira Stencil One", size: 18))
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .frame(maxWidth: 120)
                .background(Color.white.opacity(0.2))
                .cornerRadius(4)
        }
        .padding(.horizontal, 20)
        .frame(height: 50)
        .background(color)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
