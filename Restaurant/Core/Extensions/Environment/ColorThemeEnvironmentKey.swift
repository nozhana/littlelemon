//
//  ColorThemeEnvironmentKey.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import SwiftUI

struct ColorThemeEnvironmentKey: EnvironmentKey {
    static var defaultValue: ColorTheme { .light }
}

extension EnvironmentValues {
    var colorTheme: ColorTheme {
        get { self[ColorThemeEnvironmentKey.self] }
        set { self[ColorThemeEnvironmentKey.self] = newValue }
    }
}
