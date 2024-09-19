//
//  PrimitiveGradient.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/18/24.
//

import SwiftUI

enum PrimitiveGradient: Primitive {
    case light, dark
    
    var value: AnyGradient {
        switch self {
        case .light:
            return Gradient(colors: [
                PrimitiveColor.apricot.value,
                PrimitiveColor.apricotPeach.value
            ])
            .eraseToAnyGradient()
        case .dark:
            return Gradient(colors: [
                PrimitiveColor.mineshaft.value,
                PrimitiveColor.nandor.value
            ])
            .eraseToAnyGradient()
        }
    }
}
