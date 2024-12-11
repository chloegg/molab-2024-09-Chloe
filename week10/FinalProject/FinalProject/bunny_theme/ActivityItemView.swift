//
//  ActivityItemView.swift
//  FinalProject
//
//  Created by Keying Guo on 12/10/24.
//

import SwiftUI

struct ActivityItemView: View {
    let title: String
    @Binding var activities: [String]
    let index: Int
    let isPriority: Bool
    let onDelete: () -> Void

    @State private var isChecked = false

    var body: some View {
        HStack(spacing: 19) {
            Button(action: {
                isChecked = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    activities.remove(at: index)
                    onDelete()
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 24, height: 24)

                    if isChecked {
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: 16, height: 16)
                    }
                }
            }

            Text(title)
                .font(.custom("Saira Stencil One", size: 32))
                .foregroundColor(Color(red: 0.969, green: 0.898, blue: 0.898))
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 300)
        .padding(.vertical, 25)
        .padding(.horizontal, 17)
        .background(isPriority ? Color(red: 1, green: 0.325, blue: 0.753) : Color(red: 1, green: 0.525, blue: 0.953))
        .cornerRadius(8)
    }
}
