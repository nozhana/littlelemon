//
//  SurfaceColorTheme.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

protocol SurfaceColorTheme {
    var primary: PrimitiveColor { get }
    var secondary: PrimitiveColor { get }
    var action: PrimitiveColor { get }
    var hero: PrimitiveColor { get }
    var error: PrimitiveColor { get }
}
