//
//  Gradients.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/18/24.
//

import Foundation

struct GradientsLight: GradientTheme {
    let background: PrimitiveGradient = .light
}

struct GradientsDark: GradientTheme {
    let background: PrimitiveGradient = .dark
}

extension AnyGradientTheme {
    static var light: AnyGradientTheme { GradientsLight().eraseToAnyGradientTheme() }
    static var dark: AnyGradientTheme { GradientsDark().eraseToAnyGradientTheme() }
}
