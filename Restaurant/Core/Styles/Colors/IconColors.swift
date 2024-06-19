//
//  IconColors.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

struct IconColorsLight: IconColorTheme {
    let primary: PrimitiveColor = .black
    let secondary: PrimitiveColor = .cobblestone
    let contrast: PrimitiveColor = .white
}

struct IconColorsDark: IconColorTheme {
    let primary: PrimitiveColor = .white
    let secondary: PrimitiveColor = .cobblestone
    let contrast: PrimitiveColor = .black
}
