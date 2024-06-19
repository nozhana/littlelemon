//
//  StrokeColorTheme.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

protocol StrokeColorTheme {
    var primary: PrimitiveColor { get }
    var secondary: PrimitiveColor { get }
    var tertiary: PrimitiveColor { get }
    var error: PrimitiveColor { get }
}
