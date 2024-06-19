//
//  TextColors.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

struct TextColorsLight: TextColorTheme {
    let primary: PrimitiveColor = .black
    let secondary: PrimitiveColor = .mineshaft
    let title: PrimitiveColor = .ripeLemon
    let contrast: PrimitiveColor = .white
    let disabled: PrimitiveColor = .cobblestone
    let error: PrimitiveColor = .apricot
}

struct TextColorsDark: TextColorTheme {
    let primary: PrimitiveColor = .white
    let secondary: PrimitiveColor = .haze
    let title: PrimitiveColor = .ripeLemon
    let contrast: PrimitiveColor = .black
    let disabled: PrimitiveColor = .cobblestone
    let error: PrimitiveColor = .apricot
}
