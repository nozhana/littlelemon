//
//  Home.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/13/24.
//

import SwiftUI

struct Home: View {
    @StateObject private var viewModel = Inject[\.homeViewModel]
    @Environment(\.colorScheme) private var colorScheme
    
    @Inject(\.persistenceController) private var persistence
    @Inject(\.theme) private var theme
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            Menu()
                .tabItem { HomeTab.menu.label }
                .tag(HomeTab.menu)
            Profile()
                .tabItem { HomeTab.profile.label }
                .tag(HomeTab.profile)
        } // TabView
        .environment(\.managedObjectContext, persistence.container.viewContext)
        .environmentObject(viewModel)
        .sheet(isPresented: $viewModel.isShowingOnboarding, content: Onboarding.init)
        .environmentObject(theme)
        .onChange(of: colorScheme) { newValue in
            theme.color = newValue == .dark ? .dark : .light
        }
        .onAppear {
            theme.color = colorScheme == .dark ? .dark : .light
        }
    }
}

#Preview {
    Home()
}
