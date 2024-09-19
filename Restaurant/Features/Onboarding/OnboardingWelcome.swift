//
//  OnboardingWelcome.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/16/24.
//

import SwiftUI

struct OnboardingWelcome: View {
    @EnvironmentObject private var theme: ThemeUtil
    
    var body: some View {
        VStack(spacing: 16) {
            Image("LittleLemonLogo", bundle: .main)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 280, height: 280)
                .clipShape(.roundedRect8)
                .shadow(color: .black.opacity(0.12), radius: 6, y: 2)
            
            Text("Welcome to Little Lemon!")
                .font(.markaziText(32, weight: .bold))
                .foregroundStyle(theme.color[\.text.primary])
            
            Text("Swipe left to continue.")
                .font(.karla(21))
                .foregroundStyle(theme.color[\.text.disabled])
        }
    }
}

#Preview {
    OnboardingWelcome()
}
