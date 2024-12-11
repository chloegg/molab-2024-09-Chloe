//
//  choosePet.swift
//  FinalProject
//
//  Created by Keying Guo on 12/5/24.
//

import SwiftUI

struct DigiPetSelectionView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 154/255, green: 212/255, blue: 225/255)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    Text("Choose Your\nDigi-Pet!")
                        .font(.custom("Saira Stencil One", size: 40))
                        .foregroundColor(Color(red: 77/255, green: 77/255, blue: 77/255))
                        .multilineTextAlignment(.center)
                        .padding(.top, 60)
                    
                    HStack(spacing: 20) {
                        Image("strawberry")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Image("strawberry")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Image("strawberry")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            print("Bear selected!")
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 231/255, green: 244/255, blue: 189/255))
                                .frame(width: 120, height: 120)
                                .overlay(
                                    Image("bear")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 230, height: 230)
                                        .offset(x: -71)
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            print("Cat selected!")
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 231/255, green: 244/255, blue: 189/255))
                                .frame(width: 120, height: 120)
                                .overlay(
                                    Image("cat")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 330, height: 330)
                                        .offset(x: -81)
                                )
                        }
                    }
                    
                    HStack(spacing: 20) {
                        NavigationLink(destination: NameEntryView()) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 231/255, green: 244/255, blue: 189/255))
                                .frame(width: 120, height: 120)
                                .overlay(
                                    Image("bunny")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 170, height: 170)
                                        .offset(x: 27)
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                   
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 231/255, green: 244/255, blue: 189/255))
                                .frame(width: 120, height: 120)
                                .overlay(
                                    VStack {
                                        Image(systemName: "lock.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.black.opacity(0.3)) // Lower opacity
                                    }
                                )
    
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

struct DigiPetSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DigiPetSelectionView()
    }
}
