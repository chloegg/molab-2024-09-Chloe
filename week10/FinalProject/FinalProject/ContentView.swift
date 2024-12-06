//
//  ContentView.swift
//  FinalProject
//
//  Created by Keying Guo on 11/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var timeString = "00 : 00"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 154/255, green: 212/255, blue: 225/255)
                    .edgesIgnoringSafeArea(.all)
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.red.opacity(0.3),
                        Color.clear,
                        Color.red.opacity(0.3)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Image("strawberry")
                            .resizable()
                            .frame(width: 65, height: 65)
                        Image("strawberry")
                            .resizable()
                            .frame(width: 65, height: 65)
                        Image("strawberry")
                            .resizable()
                            .frame(width: 65, height: 65)
                    }
                    .padding(.bottom, 20)
                    
                    Text("digitama")
                        .font(.custom("Saira Stencil One", size: 36))
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                    
                    Text(timeString)
                        .font(.custom("Saira Stencil One", size: 96))
                        .foregroundColor(Color(red: 242/255, green: 201/255, blue: 76/255))
                        .padding(.top, 10)
                    
                    NavigationLink(destination: LoginView()) {
                        Text("login")
                            .font(.custom("Saira Stencil One", size: 28))
                            .foregroundColor(Color(red: 240/255, green: 215/255, blue: 215/255))
                            .frame(width: 170)
                            .padding(.vertical, 4)
                            .background(Color(red: 197/255, green: 78/255, blue: 78/255))
                            .cornerRadius(15)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color(red: 197/255, green: 78/255, blue: 78/255))
                                    .shadow(color: Color.white.opacity(0.7), radius: 4, x: -3, y: -3)
                                    .shadow(color: Color.black.opacity(0.3), radius: 4, x: 3, y: 3)
                            )
                    }
                    .padding(.top, 50)
                    
                    NavigationLink(destination: SignupView()) {
                        Text("signup")
                            .font(.custom("Saira Stencil One", size: 28))
                            .foregroundColor(Color(red: 240/255, green: 215/255, blue: 215/255))
                            .frame(width: 170, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color(red: 197/255, green: 78/255, blue: 78/255))
                                    .shadow(color: Color.white.opacity(0.7), radius: 4, x: -3, y: -3)
                                    .shadow(color: Color.black.opacity(0.3), radius: 4, x: 3, y: 3)
                            )
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    ContentView()
}
