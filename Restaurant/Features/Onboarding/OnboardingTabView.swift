//
//  OnboardingTabView.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/16/24.
//

import SwiftUI

struct OnboardingTabView: View {
    @State private var tabSelection = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            OnboardingWelcome()
                .tag(0)
            OnboardingInfo()
                .tag(1)
            Login()
                .tag(2)
        }
        .tabViewStyle(.page)
        .interactiveDismissDisabled()
    }
}

#Preview {
    OnboardingTabView()
}
