//
//  OnboardingInfo.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/16/24.
//

import SwiftUI

struct OnboardingInfo: View {
    @EnvironmentObject private var theme: ThemeUtil
    
    var body: some View {
        VStack {
            Text("Create an account on the next page to start ordering right away!")
                .font(.karla(32, weight: .bold))
            
            Spacer()
            
            Text("Made with ❤️")
                .font(.tagline)
                .tint(theme.color[\.text.secondary])
            
            Text("Nozhan Amiri")
                .font(.caption)
                .foregroundStyle(theme.color[\.text.secondary])
            Text("nozhana@gmail.com")
                .font(.caption)
                .tint(.purple)
        } // VStack
        .padding(.init(top: 64, leading: 16, bottom: 64, trailing: 16))
    }
}

#Preview {
    OnboardingInfo()
}
