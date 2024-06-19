//
//  TextColorTheme.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

protocol TextColorTheme {
    var primary: PrimitiveColor { get }
    var secondary: PrimitiveColor { get }
    var title: PrimitiveColor { get }
    var contrast: PrimitiveColor { get }
    var disabled: PrimitiveColor { get }
    var error: PrimitiveColor { get }
}
