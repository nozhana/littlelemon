//
//  Home.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/13/24.
//

import SwiftUI

struct Home: View {
    @StateObject private var viewModel = Inject[\.homeViewModel]
    @ObservedObject private var snackbar = Inject[\.snackbar]
    @Environment(\.colorScheme) private var colorScheme
    
    @Inject(\.persistenceController) private var persistence
    @Inject(\.theme) private var theme
    
    var body: some View {
        Menu()
            .environment(\.managedObjectContext, persistence.container.viewContext)
            .environmentObject(viewModel)
            .sheet(isPresented: $viewModel.isShowingOnboarding, content: OnboardingTabView.init)
            .snackbar($snackbar.isShowingSnackbar, configuration: snackbar.configuration)
            .environmentObject(theme)
            .onChange(of: colorScheme) { newValue in
                theme.apply(newValue)
            }
            .onAppear {
                theme.apply(colorScheme)
            }
    }
}

#Preview {
    Home()
}
