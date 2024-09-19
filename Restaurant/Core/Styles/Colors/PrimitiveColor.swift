//
//  PrimitiveColor.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import SwiftUI

enum PrimitiveColor: Primitive {
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
            return .init(hex: "#495E57")!
        case .ripeLemon:
            return .init(hex: "#F4CE14")!
        case .apricot:
            return .init(hex: "#EE9972")!
        case .apricot50:
            return .init(hex: "#EE9972", opacityPercent: 50)!
        case .apricot24:
            return .init(hex: "#EE9972", opacityPercent: 24)!
        case .apricotPeach:
            return .init(hex: "#FBDABB")!
        case .seaFoam:
            return .init(hex: "#47F0C8")!
        case .haze:
            return .init(hex: "#EDEFEE")!
        case .cobblestone:
            return .init(hex: "#6B")!
        case .mineshaft:
            return .init(hex: "#33")!
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
