//
//  RootView.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 4/4/24.
//

import SwiftUI

struct RootView: View {
    @State private var isShowingOnboarding = false
    @StateObject private var viewModel = Container.shared.rootViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, \(viewModel.firstName.isEmpty ? "world" : viewModel.firstName)!")
            Button("Clear data", systemImage: "trash") {
                viewModel.clearData()
                isShowingOnboarding = true
            }
            .font(.callout.bold())
            .buttonStyle(.bordered)
            .padding(.top, 16)
        }
        .padding()
        .onAppear {
            isShowingOnboarding = !viewModel.isOnboarded
        }
        .sheet(isPresented: $isShowingOnboarding, onDismiss: viewModel.objectWillChange.send, content: Onboarding.init)
    }
}

#Preview {
    RootView()
}
