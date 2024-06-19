//
//  Colors.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/18/24.
//

import Foundation

struct ColorsLight: ColorTheme {
    let surface: SurfaceColorTheme = SurfaceColorsLight()
    let text: TextColorTheme = TextColorsLight()
    let icon: IconColorTheme = IconColorsLight()
    let stroke: StrokeColorTheme = StrokeColorsLight()
}

struct ColorsDark: ColorTheme {
    let surface: SurfaceColorTheme = SurfaceColorsDark()
    let text: TextColorTheme = TextColorsDark()
    let icon: IconColorTheme = IconColorsDark()
    let stroke: StrokeColorTheme = StrokeColorsDark()
}

extension ColorTheme where Self == AnyColorTheme {
    static var light: Self { ColorsLight().eraseToAnyColorTheme() }
    static var dark: Self { ColorsDark().eraseToAnyColorTheme() }
}
