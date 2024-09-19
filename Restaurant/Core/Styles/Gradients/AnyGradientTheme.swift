//
//  AnyGradientTheme.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/18/24.
//

import Foundation

struct AnyGradientTheme: GradientTheme {
    private let theme: any GradientTheme
    init(_ theme: some GradientTheme) {
        self.theme = theme
    }
    
    var background: PrimitiveGradient { theme.background }
}

extension GradientTheme {
    func eraseToAnyGradientTheme() -> AnyGradientTheme { .init(self) }
}
