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
        .environment(\.colorTheme, colorScheme == .dark ? .dark : .light)
    }
}

#Preview {
    Home()
}
