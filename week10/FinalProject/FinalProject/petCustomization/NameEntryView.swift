//
//  NameEntryView.swift
//  FinalProject
//
//  Created by Keying Guo on 12/6/24.
//

import SwiftUI

struct NameEntryView: View {
    @Environment(\.dismiss) private var dismiss // Allows dismissing this view
    @State private var name: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("hiiii...jibibjijibjiji")
                    .font(.custom("Saira Stencil One", size: 20))
                    .foregroundColor(Color(red: 77/255, green: 77/255, blue: 77/255))
                    .padding(.top, 123)
                
                Text("Enter Name:")
                    .font(.custom("Saira Stencil One", size: 32))
                    .foregroundColor(Color(red: 77/255, green: 77/255, blue: 77/255))
                    .padding(.top, 1)
                
                TextField("", text: $name)
                    .font(.custom("Saira Stencil One", size: 32))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(UnderlineTextFieldStyle())
                    .accessibility(label: Text("Name input field"))
                
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/47d7fd6e9b31fcce25ed3c1634e1d580699c52bd57ca3ea2ff862adcb7af003a?placeholderIfAbsent=true&apiKey=aa7a4deaf7484c0083679b37f9f13087&format=webp")) { image in
                    image
                        .resizable()
                        .aspectRatio(0.87, contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 156)
                .padding(.top, 17)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("back")
                        .font(.custom("Saira Stencil One", size: 20))
                        .foregroundColor(Color(red: 197/255, green: 78/255, blue: 78/255))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 70)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
                }
                .padding(.top, 109)
                
                NavigationLink(destination: HomeScreen().navigationBarHidden(true)) {
                    Text("continue")
                        .font(.custom("Saira Stencil One", size: 20))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 70)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
                }
                .padding(.top, 5)
            }
            .padding(.horizontal, 51)
            .padding(.bottom, 45)
        }
        .background(Color(red: 206/255, green: 218/255, blue: 128/255))
        .navigationBarBackButtonHidden(true) // Hides the back button
        .navigationBarHidden(true) // Hides the navigation bar
    }
}

struct UnderlineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack {
            configuration
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black)
        }
    }
}

struct NameEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NameEntryView()
    }
}
