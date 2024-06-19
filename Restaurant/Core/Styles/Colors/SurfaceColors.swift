//
//  SurfaceColors.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

struct SurfaceColorsLight: SurfaceColorTheme {
    let primary: PrimitiveColor = .white
    let secondary: PrimitiveColor = .haze
    let action: PrimitiveColor = .seaFoam
    let hero: PrimitiveColor = .nandor
}

struct SurfaceColorsDark: SurfaceColorTheme {
    let primary: PrimitiveColor = .black
    let secondary: PrimitiveColor = .mineshaft
    let action: PrimitiveColor = .seaFoam
    let hero: PrimitiveColor = .nandor
}
