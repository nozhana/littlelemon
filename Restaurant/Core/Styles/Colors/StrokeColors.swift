//
//  StrokeColors.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

struct StrokeColorsLight: StrokeColorTheme {
    let primary: PrimitiveColor = .black24
    let secondary: PrimitiveColor = .black12
    let tertiary: PrimitiveColor = .black6
    let error: PrimitiveColor = .apricot50
}

struct StrokeColorsDark: StrokeColorTheme {
    let primary: PrimitiveColor = .white24
    let secondary: PrimitiveColor = .white12
    let tertiary: PrimitiveColor = .white6
    let error: PrimitiveColor = .apricot50
}
