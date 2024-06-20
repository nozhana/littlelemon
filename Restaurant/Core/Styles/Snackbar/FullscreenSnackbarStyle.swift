//
//  FullscreenSnackbarStyle.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/20/24.
//

import SwiftUI

struct FullscreenSnackbarStyle: SnackbarStyle {
    func makeBody(_ configuration: SnackbarConfiguration) -> some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(.thinMaterial)
            
            VStack(alignment: .leading, spacing: 44) {
                Image(systemName: configuration.systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 84, height: 84)
                    .imageScale(.medium)
                    .foregroundStyle(.primary)
                Text(configuration.content)
                    .font(.title)
            }
            .padding(.horizontal, 64)
        }
        .transition(.scale(scale: 0.8).combined(with: .opacity))
        .animation(.easeOut(duration: 0.5))
    }
}

extension SnackbarStyle where Self == AnySnackbarStyle {
    static var fullscreen: FullscreenSnackbarStyle {
        .init()
    }
}
