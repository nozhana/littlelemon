//
//  DefaultSnackbarStyle.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import SwiftUI

struct DefaultSnackbarStyle: SnackbarStyle {
    func makeBody(_ configuration: SnackbarConfiguration) -> some View {
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
    }
}

extension SnackbarStyle where Self == AnySnackbarStyle {
    static var `default`: DefaultSnackbarStyle {
        .init()
    }
}
