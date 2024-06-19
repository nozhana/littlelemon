//
//  PrimitiveColor.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
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
