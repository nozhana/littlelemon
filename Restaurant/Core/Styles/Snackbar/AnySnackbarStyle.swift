//
//  AnySnackbarStyle.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import SwiftUI

struct AnySnackbarStyle: SnackbarStyle {
    private let style: any SnackbarStyle
    
    init(_ style: some SnackbarStyle) {
        self.style = style
    }
    
    func makeBody(_ configuration: SnackbarConfiguration) -> some View {
        AnyView(style.makeBody(configuration))
    }
}

extension SnackbarStyle {
    func eraseToAnySnackbarStyle() -> AnySnackbarStyle {
        .init(self)
    }
}
