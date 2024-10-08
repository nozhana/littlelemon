//
//  ColorTheme.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import SwiftUI

protocol ColorTheme: Themable<PrimitiveColor> {
    var surface: SurfaceColorTheme { get }
    var text: TextColorTheme { get }
    var icon: IconColorTheme { get }
    var stroke: StrokeColorTheme { get }
}
