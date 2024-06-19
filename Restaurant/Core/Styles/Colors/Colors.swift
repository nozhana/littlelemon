//
//  Colors.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/18/24.
//

import SwiftUI

enum PrimitiveColor {
    case nandor
    case ripeLemon
    case apricot, apricot50, apricot24
    case apricotPeach
    case seaFoam
    case haze
    case cobblestone
    case mineshaft
    case white, white24, white12, white6
    case black, black24, black12, black6
    
    
    var value: Color {
        switch self {
        case .nandor:
            return .hex("#495E57")!
        case .ripeLemon:
            return .hex("#F4CE14")!
        case .apricot:
            return .hex("#EE9972")!
        case .apricot50:
            return .hex("#EE9972", opacityPercent: 50)!
        case .apricot24:
            return .hex("#EE9972", opacityPercent: 24)!
        case .apricotPeach:
            return .hex("#FBDABB")!
        case .seaFoam:
            return .hex("#47F0C8")!
        case .haze:
            return .hex("#EDEFEE")!
        case .cobblestone:
            return .hex("#6B")!
        case .mineshaft:
            return .hex("#33")!
        case .white:
            return .white
        case .white24:
            return .white.opacity(0.24)
        case .white12:
            return .white.opacity(0.12)
        case .white6:
            return .white.opacity(0.06)
        case .black:
            return .black
        case .black24:
            return .black.opacity(0.24)
        case .black12:
            return .black.opacity(0.12)
        case .black6:
            return .black.opacity(0.06)
        }
    }
}

protocol ColorTheme {
    var surface: SurfaceColorTheme { get }
    var text: TextColorTheme { get }
    var icon: IconColorTheme { get }
    var stroke: StrokeColorTheme { get }
}

protocol SurfaceColorTheme {
    var primary: PrimitiveColor { get }
    var secondary: PrimitiveColor { get }
    var action: PrimitiveColor { get }
    var hero: PrimitiveColor { get }
}

protocol TextColorTheme {
    var primary: PrimitiveColor { get }
    var secondary: PrimitiveColor { get }
    var title: PrimitiveColor { get }
    var contrast: PrimitiveColor { get }
    var disabled: PrimitiveColor { get }
    var error: PrimitiveColor { get }
}

protocol IconColorTheme {
    var primary: PrimitiveColor { get }
    var secondary: PrimitiveColor { get }
    var contrast: PrimitiveColor { get }
}

protocol StrokeColorTheme {
    var primary: PrimitiveColor { get }
    var secondary: PrimitiveColor { get }
    var tertiary: PrimitiveColor { get }
    var error: PrimitiveColor { get }
}

struct AnyColorTheme: ColorTheme {
    private let theme: ColorTheme
    
    init(_ colorTheme: ColorTheme) {
        self.theme = colorTheme
    }
    
    var surface: SurfaceColorTheme {
        theme.surface
    }
    
    var text: TextColorTheme {
        theme.text
    }
    
    var icon: IconColorTheme {
        theme.icon
    }
    
    var stroke: StrokeColorTheme {
        theme.stroke
    }
}

extension ColorTheme {
    func eraseToAnyColorTheme() -> AnyColorTheme {
        .init(self)
    }
}

extension ColorTheme where Self == AnyColorTheme {
    static var light: Self { .init(ColorsLight()) }
    static var dark: Self { .init(ColorsDark()) }
}

extension ColorTheme {
    subscript(_ keyPath: KeyPath<ColorTheme, PrimitiveColor>) -> Color {
        self[keyPath: keyPath].value
    }
}

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
