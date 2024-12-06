//
//  NavigationButton.swift
//  FinalProject
//
//  Created by Keying Guo on 12/5/24.
//

import SwiftUI

enum NavigationButtonStyle {
    case primary
    case secondary
}

struct NavigationButton: View {
    let text: String
    let style: NavigationButtonStyle
    let action: (() -> Void)
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.custom("Saira Stencil One", size: 20))
                .foregroundColor(style == .primary ? .white : Color(red: 0.773, green: 0.306, blue: 0.306))
                .frame(width: 330, height: 45)
                .background(style == .primary ? Color(red: 0.306, green: 0.549, blue: 0.773) : Color.white.opacity(0.5))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
        }
    }
}
