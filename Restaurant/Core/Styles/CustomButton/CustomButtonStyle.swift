//
//  CustomButtonStyle.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/19/24.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    enum Role {
        case prominent, ghost, destructive
    }
    
    let colors: any ColorTheme
    let role: Role
    
    init(colors: some ColorTheme, role: Role = .prominent) {
        self.colors = colors
        self.role = role
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.highlight)
            .foregroundStyle(.primary)
            .padding(.init(top: 14, leading: 24, bottom: 14, trailing: 24))
            .background {
                switch role {
                case .prominent:
                    colors.surface.action.value
                case .ghost:
                    colors.surface.primary.value
                case .destructive:
                    colors.surface.error.value
                }
            }
            .clipShape(.roundedRect(12))
            .roundedBorder(2, cornerRadius: 12, color: role == .ghost ? colors.stroke.secondary.value : colors.stroke.primary.value)
            .shadow(color: .black.opacity(0.06), radius: 4, y: 2)
            .shadow(color: .black.opacity(0.05), radius: 7, y: 7)
    }
}
