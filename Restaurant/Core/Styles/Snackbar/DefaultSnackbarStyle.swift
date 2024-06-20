//
//  DefaultSnackbarStyle.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import SwiftUI

struct DefaultSnackbarStyle: SnackbarStyle {
    func makeBody(_ configuration: SnackbarConfiguration) -> some View {
        VStack {
            Spacer()
            HStack {
                Label(configuration.content, systemImage: configuration.systemImage)
                    .imageScale(.large)
                    .font(.highlight)
                Spacer()
            }
            .padding(16)
            .background(.thickMaterial)
            .clipShape(.roundedRect16)
            .shadow(color: .black.opacity(0.12), radius: 4, y: 4)
            .padding(.init(top: 0, leading: 16, bottom: 56, trailing: 16))
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeOut(duration: 0.5))
    }
}

extension SnackbarStyle where Self == AnySnackbarStyle {
    static var `default`: DefaultSnackbarStyle {
        .init()
    }
}
