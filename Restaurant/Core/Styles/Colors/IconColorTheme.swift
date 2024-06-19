//
//  IconColorTheme.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

protocol IconColorTheme {
    var primary: PrimitiveColor { get }
    var secondary: PrimitiveColor { get }
    var contrast: PrimitiveColor { get }
}
